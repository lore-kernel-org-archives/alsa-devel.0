From: Clive Messer <clive@vacuumtube.org.uk>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 17:36:24 +0000
Message-ID: <200902251736.24306.clive@vacuumtube.org.uk>
References: <20090219024611.GA7930@tango.0pointer.de>
	<200902251656.47813.clive@vacuumtube.org.uk>
	<s5hvdqymozf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from abbey4.objectsoft-systems.ltd.uk
	(abbey4.objectsoft-systems.ltd.uk [87.194.123.10])
	by alsa0.perex.cz (Postfix) with ESMTP id AF7A91038D4
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 18:36:25 +0100 (CET)
In-Reply-To: <s5hvdqymozf.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 25 Feb 2009 16:59:48 Takashi Iwai wrote:
> Oops, sorry, pasted a wrong version.
> Here it is.
>
>
> thanks,
>
> Takashi
> ---
> diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
> index e9ce092..5211d1c 100644
> --- a/src/pcm/pcm_hw.c
> +++ b/src/pcm/pcm_hw.c
> @@ -131,6 +131,10 @@ struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t *pc=
m)
> =A0static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0int err;
> +=A0=A0=A0=A0=A0=A0=A0long old_hwptr, new_hwptr;
> +=A0=A0=A0=A0=A0=A0=A0long old_applptr, new_applptr;
> +=A0=A0=A0=A0=A0=A0=A0old_hwptr =3D hw->sync_ptr->s.status.hw_ptr;
> +=A0=A0=A0=A0=A0=A0=A0old_applptr =3D hw->sync_ptr->c.control.appl_ptr;
> =A0=A0=A0=A0=A0=A0=A0=A0hw->sync_ptr->flags =3D flags;
> =A0=A0=A0=A0=A0=A0=A0=A0err =3D ioctl((hw)->fd, SNDRV_PCM_IOCTL_SYNC_PTR,=
 (hw)->sync_ptr);
> =A0=A0=A0=A0=A0=A0=A0=A0if (err < 0) {
> @@ -138,6 +142,11 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int
> flags) SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return err;
> =A0=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0new_hwptr =3D hw->sync_ptr->s.status.hw_ptr;
> +=A0=A0=A0=A0=A0=A0=A0new_applptr =3D hw->sync_ptr->c.control.appl_ptr;
> +=A0=A0=A0=A0=A0=A0=A0printf("sync_ptr1: %ld(%ld), %ld(%ld)\n",
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 new_hwptr, new_hwptr - old_hwptr,
> +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 new_applptr, new_applptr - old_applptr=
);
> =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> =A0}
> =A0

Takashi,

Applied, but I'm not getting any "sync_ptr1: .... " logging on stdout. Any =

ideas?

Regards

Clive
-- =

Clive Messer <clive@vacuumtube.org.uk>
