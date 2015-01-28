From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 1/5] ALSA: line6: Fix racy loopback handling
Date: Tue, 27 Jan 2015 23:41:03 -0600
Message-ID: <CAEUsAPa_uu8760eEYjy5OBXsCb0yaVvA7RbgcAtcVEymjGHizw@mail.gmail.com>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
 <1422375197-17293-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 96A8326158C
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 06:41:04 +0100 (CET)
Received: by mail-qa0-f45.google.com with SMTP id n8so14944787qaq.4
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 21:41:03 -0800 (PST)
In-Reply-To: <1422375197-17293-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2015 at 10:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
>  /* open capture callback */
> diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
> index 3762a98026aa..b1d376501616 100644
> --- a/sound/usb/line6/playback.c
> +++ b/sound/usb/line6/playback.c
> @@ -284,15 +282,18 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
>  */
>  int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
>  {
> -       int ret, i;
> +       unsigned long flags;
> +       int ret = 0, i;
>
> +       spin_lock_irqsave(&line6pcm->out.lock, flags);
>         for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
>                 ret = submit_audio_out_urb(line6pcm);
>                 if (ret < 0)
> -                       return ret;
> +                       break;
>         }
>
> -       return 0;
> +       spin_unlock_irqrestore(&line6pcm->in.lock, flags);
> +       return ret;

s/in.lock/out.lock/
