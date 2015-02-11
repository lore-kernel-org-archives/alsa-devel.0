From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch] ALSA: seq: potential out of bounds
	in	do_control()
Date: Wed, 11 Feb 2015 16:35:50 +0100
Message-ID: <54DB76D6.3090803@ladisch.de>
References: <20150211151054.GA30155@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 033BA2605D0
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 16:35:53 +0100 (CET)
In-Reply-To: <20150211151054.GA30155@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dan Carpenter wrote:
> Smatch complains that "control" is user specifigy and needs to be
> capped.  The call tree to understand this warning is quite long.
>
> snd_seq_write()  <-- get the event from the user
>   snd_seq_client_enqueue_event()
>     snd_seq_deliver_event()
>       deliver_to_subscribers()
>         snd_seq_deliver_single_event()
>           snd_opl3_oss_event_input()
>             snd_midi_process_event()
>               do_control()
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I have spent some time reviewing this code, but I may have missed
> something where we verify that control is in bounds.  I'm not very
> familiar with this code and the call tree is fairly long.

BTW, there are other ways to deliver events.  In any case, events are
pretty much opaque blobs, and most fields are not checked.

> diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
> index 9b6470c..7ba9373 100644
> --- a/sound/core/seq/seq_midi_emul.c
> +++ b/sound/core/seq/seq_midi_emul.c
> @@ -269,6 +269,9 @@ do_control(struct snd_midi_op *ops, void *drv, struct snd_midi_channel_set *chse
>  {
>  	int  i;
>
> +	if (control >= ARRAY_SIZE(chan->control))
> +		return;

Is this correct for an unsigned int converted to an int?


Regards,
Clemens
