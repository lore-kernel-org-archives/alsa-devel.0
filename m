From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 8/9] pcm: rewindable,
 forwardable: don't return stale data
Date: Sun, 14 Sep 2014 10:57:32 +0800
Message-ID: <CAN8ccibab6YQ-7SL_SNt+b69fRL+OWHRuxshwEeNb3S2=W2JZA@mail.gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
 <1410633021-20395-9-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
 [209.85.216.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF2D26164D
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 04:57:34 +0200 (CEST)
Received: by mail-qc0-f173.google.com with SMTP id i8so2247649qcq.32
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 19:57:33 -0700 (PDT)
In-Reply-To: <1410633021-20395-9-git-send-email-patrakov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

>
> The current behavior of snd_pcm_rewindable and snd_pcm_forwardable means
> that the returned value is only accurate to one period. Or maybe even
> meaningless if period interrupts are off. Fetch the up-to-date position
> of the hardware pointer, as that's what is wanted by callers.

Why do dmix need to support rewind/forward since it also set the slave in
free run mode ?

>
> Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
> ---
>  src/pcm/pcm_dmix.c   | 6 ++++++
>  src/pcm/pcm_dshare.c | 6 ++++++
>  src/pcm/pcm_dsnoop.c | 6 ++++++
>  src/pcm/pcm_hw.c     | 6 ++++++
>  src/pcm/pcm_ioplug.c | 2 ++
>  src/pcm/pcm_plugin.c | 6 ++++++
>  6 files changed, 32 insertions(+)
>
> diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
> index babde6a..d9565f9 100644
> --- a/src/pcm/pcm_dmix.c
> +++ b/src/pcm/pcm_dmix.c
> @@ -661,6 +661,9 @@ static int snd_pcm_dmix_pause(snd_pcm_t *pcm
ATTRIBUTE_UNUSED, int enable ATTRIB
>
>  static snd_pcm_sframes_t snd_pcm_dmix_rewindable(snd_pcm_t *pcm)
>  {
> +       int err = snd_pcm_dmix_hwsync(pcm);
> +       if (err < 0)
> +               return err;
>         return snd_pcm_mmap_playback_hw_rewindable(pcm);
>  }
>
> @@ -744,6 +747,9 @@ static snd_pcm_sframes_t
snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
>
>  static snd_pcm_sframes_t snd_pcm_dmix_forwardable(snd_pcm_t *pcm)
>  {
> +       int err = snd_pcm_dmix_hwsync(pcm);
> +       if (err < 0)
> +               return err;
>         return snd_pcm_mmap_avail(pcm);
>  }
>
