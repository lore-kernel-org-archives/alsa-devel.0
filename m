From: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: BUG: soft lockup in snd_virmidi_output_trigger
Date: Fri, 27 Jul 2018 14:51:04 +0900
Message-ID: <20180727055104.GA18733@dragonet>
References: <20180726055326.GA12625@dragonet>
 <s5hva92yxda.wl-tiwai@suse.de>
 <20180727041322.GA13067@dragonet>
 <s5hbmatuue9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hbmatuue9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, kt0755@gmail.com, syzkaller@googlegroups.com, bammanag@purdue.edu, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 27, 2018 at 07:20:30AM +0200, Takashi Iwai wrote:

I think there is a mistake on the reported-by tag.
The reported-by tag (e4c8abb920ef...) is for WARNING in port_delete.
I guess the tag below is correct.
Reported-by: syzbot+619d9f40141d826b097e@syzkaller.appspotmail.com
Could you please make sure that the reported-by tag is correct?

By the way, I can't reproduce the crash WARNING in port_delete so
far. I feel sad for saying this..
I really want to reproduce the crash and thus, to help to fix the
crash. If there is any progress on it, I will let you know
immediately.


Best regards,
Dae R. Jeong

> On Fri, 27 Jul 2018 06:13:22 +0200,
> Dae R. Jeong wrote:
> > 
> > I tested it and it worked.
> > Thanks a lot!
> 
> Good to hear.  Below is the final patch with a proper comment (and
> with syzbot reported-by, too) I'm going to queue to sound.git tree.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> 
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: virmidi: Fix too long output trigger loop
> 
> The virmidi output trigger tries to parse the all available bytes and
> process sequencer events as much as possible.  In a normal situation,
> this is supposed to be relatively short, but a program may give a huge
> buffer and it'll take a long time in a single spin lock, which may
> eventually lead to a soft lockup.
> 
> This patch simply adds a workaround, a cond_resched() call in the loop
> if applicable.  A better solution would be to move the event processor
> into a work, but let's put a duct-tape quickly at first.
> 
> Reported-and-tested-by: Dae R. Jeong <threeearcat@gmail.com>
> Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_virmidi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
> index 289ae6bb81d9..8ebbca554e99 100644
> --- a/sound/core/seq/seq_virmidi.c
> +++ b/sound/core/seq/seq_virmidi.c
> @@ -163,6 +163,7 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>  	int count, res;
>  	unsigned char buf[32], *pbuf;
>  	unsigned long flags;
> +	bool check_resched = !in_atomic();
>  
>  	if (up) {
>  		vmidi->trigger = 1;
> @@ -200,6 +201,15 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>  					vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
>  				}
>  			}
> +			if (!check_resched)
> +				continue;
> +			/* do temporary unlock & cond_resched() for avoiding
> +			 * CPU soft lockup, which may happen via a write from
> +			 * a huge rawmidi buffer
> +			 */
> +			spin_unlock_irqrestore(&substream->runtime->lock, flags);
> +			cond_resched();
> +			spin_lock_irqsave(&substream->runtime->lock, flags);
>  		}
>  	out:
>  		spin_unlock_irqrestore(&substream->runtime->lock, flags);
> -- 
> 2.18.0
> 
