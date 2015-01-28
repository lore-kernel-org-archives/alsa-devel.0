From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 3/5] ALSA: line6: Reorganize PCM stream
	handling
Date: Tue, 27 Jan 2015 23:50:16 -0600
Message-ID: <CAEUsAPZVa5cSBcTZ8xEYX7cSt=mD-vOsmwaLgs77MqdwPMvQJg@mail.gmail.com>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
 <1422375197-17293-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com
 [209.85.192.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 18C16261600
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 06:50:17 +0100 (CET)
Received: by mail-qg0-f49.google.com with SMTP id i50so15404872qgf.8
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 21:50:16 -0800 (PST)
In-Reply-To: <1422375197-17293-4-git-send-email-tiwai@suse.de>
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
> Secondly, the stream state are now managed in opened and running bit
> flags of each line6_pcm_stream.  Not only this a bit clearer than
> previous combined bit flags, this also gives a better abstraction.

Nice.

> diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
> index 21342a9dddd7..1184876f4e00 100644
> --- a/sound/usb/line6/capture.c
> +++ b/sound/usb/line6/capture.c
> @@ -67,20 +67,18 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
>
>  /*
>         Submit all currently available capture URBs.
> +       must be called in line6pcm->out.lock context

s/out.lock/in.lock/
