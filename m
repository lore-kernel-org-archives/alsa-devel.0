From: Diego Viola <diego.viola@gmail.com>
Subject: Re: alsa-lib: commit
	ce2095c41f2891c51f5dbd28e0317200314c5a75 breaks
	speaker-test/pulseaudio
Date: Wed, 19 Dec 2018 17:32:34 -0200
Message-ID: <CA+ToGPHWyUH2DWDSTHd+wPLKekGoepLKe2uMEXP1LKMyuZmOsQ@mail.gmail.com>
References: <CA+ToGPG3zHSY7bNRtLyigTGZtaVpb7tnfuHuPOVDRtw9U9weGg@mail.gmail.com>
 <s5hmup1bq5a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com
 [209.85.219.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A579E2677C8
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 20:32:47 +0100 (CET)
Received: by mail-yb1-f193.google.com with SMTP id h10so8342329ybp.6
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 11:32:47 -0800 (PST)
In-Reply-To: <s5hmup1bq5a.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Wed, Dec 19, 2018 at 11:30 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 19 Dec 2018 03:29:38 +0100,
> Diego Viola wrote:
> >
> > Hello Takashi,
> >
> > I currently have an issue with speaker-test and pulseaudio, and the
> > root of the problem seems to be a regression in alsa-lib.
> >
> > The issue occurs when I run speaker-test, it creates endless output
> > with no sound, and the output does not stop until I hit ctrl-c.
> >
> > I've been investigating about this issue and concluded (through a git
> > bisect) that this is a regression in alsa-lib, and this is the bad
> > commit that introduces the bug:
> >
> > commit ce2095c41f2891c51f5dbd28e0317200314c5a75
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Thu Mar 29 09:51:46 2018 +0200
> >
> >     pcm: ioplug: Implement proper drain behavior
> >
> >     This patch fixes the draining behavior of ioplug in the following
> >     ways:
> >
> >     - When no draining ioplug callback is defined, implement the draining
> >       loop using snd_pcm_wait*() and sync with the drain finishes.
> >       This is equivalent with the implementation in the kernel write().
> >       Similarly as in kernel code, for non-blocking mode, it returns
> >       immediately after setting DRAINING state.
> >
> >     - The hw_ptr update function checks the PCM state and stops the stream
> >       if the draining finishes.
> >
> >     - When draining ioplug callback is defined, leave the whole draining
> >       operation to it.  The callback is supposed to return -EAGAIN for
> >       non-blocking case, too.
> >
> >     - When an error happens during draining, it drops the stream, for a
> >       safety reason.
> >
> >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >
> > I've sanity checked and can confirm that going back to the previous
> > commit fixes the issue.
> >
> > My original bug report on the pulseaudio bug tracker:
> > https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/593
> >
> > Thanks, and please let me know if you need more information.
>
> Thanks for the report.  Actually this looks rather like a bug in pulse
> plugin itself.  The commit above starts the stream before calling
> pa_stream_drain(), and this seems causing the problem.  IOW,
> pa_stream_drain() doesn't work as advertised.
>
> In anyway, we should fix the regression and in this case it's safer to
> cover in the alsa-lib side.  Below is the fix patch.  Please give it a
> try.
>
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] pcm: ioplug: Fix the regression of pulse plugin drain
>
> The recent change to support the drain via polling caused a regression
> for pulse plugin; with speaker-test -c2 -twav with pulse, it leads to
> either no sounds or stall.
>
> The only sensible behavior change in the commit wrt pulse plugin is
> that now it starts the stream before calling drain callback.  This
> supposed to be correct, but it seems hitting a pulse plugin bug.
>
> The start before drain callback is only a matter of consistency, and
> since this doesn't work for the single existing plugin using drain
> callback, we don't need to stick with this behavior.
>
> For addressing the regression, we check the presence of the drain
> callback and start the stream only when it doesn't exist, i.e. only in
> drain-via-poll mode.
>
> Fixes: ce2095c41f28 ("pcm: ioplug: Implement proper drain behavior")
> Reported-by: Diego Viola <diego.viola@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  src/pcm/pcm_ioplug.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
> index 881a1a85adaf..1e25190a0f71 100644
> --- a/src/pcm/pcm_ioplug.c
> +++ b/src/pcm/pcm_ioplug.c
> @@ -537,9 +537,11 @@ static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
>                 return -EBADFD;
>         case SND_PCM_STATE_PREPARED:
>                 if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
> -                       err = snd_pcm_ioplug_start(pcm);
> -                       if (err < 0)
> -                               goto unlock;
> +                       if (!io->data->callback->drain) {
> +                               err = snd_pcm_ioplug_start(pcm);
> +                               if (err < 0)
> +                                       goto unlock;
> +                       }
>                         io->data->state = SND_PCM_STATE_DRAINING;
>                 }
>                 break;
> --
> 2.19.2
>

I can confirm that your patch fixes the problem.

Thank you, I appreciate it a lot.

Regards,
Diego
