From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: BUG in snd_ctl_find_numid
Date: Mon, 18 Jan 2016 14:18:57 +0100
Message-ID: <CACT4Y+b_VEiA3UBu==QGK1w5A6iVVZkb_kCWB42+L4nmP3yWyw@mail.gmail.com>
References: <CACT4Y+bWU+e8zVaMfCee9+6F4J_3Z_9bhNJwz5Rp559CBtMPsw@mail.gmail.com>
 <s5h37tvuivs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h37tvuivs.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 2:17 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 18 Jan 2016 13:59:49 +0100,
> Dmitry Vyukov wrote:
>>
>> Hello,
>>
>> The following program triggers a BUG in snd_ctl_find_numid:
>
> Do I understand correctly that you meant a kernel WARNING with a stack
> trace as a "BUG"?  If so, the patch below should cover it.


Yes, I guess it's just a BUG warning message.

> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: control: Avoid kernel warnings from tlv ioctl with
>  numid 0
>
> When a TLV ioctl with numid zero is handled, the driver may spew a
> kernel warning with a stack trace at each call.  The check was
> intended obviously only for a kernel driver, but not for a user
> interaction.  Let's fix it.
>
> This was spotted by syzkaller fuzzer.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/control.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 196a6fe100ca..a85d45595d02 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1405,6 +1405,8 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
>                 return -EFAULT;
>         if (tlv.length < sizeof(unsigned int) * 2)
>                 return -EINVAL;
> +       if (!tlv.numid)
> +               return -EINVAL;
>         down_read(&card->controls_rwsem);
>         kctl = snd_ctl_find_numid(card, tlv.numid);
>         if (kctl == NULL) {
> --
> 2.7.0
>
