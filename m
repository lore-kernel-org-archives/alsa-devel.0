From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 1/3] ALSA: hda - Handle error from
	snd_hda_power_up*()
Date: Wed, 27 Jun 2018 19:12:06 +0300
Message-ID: <20180627161206.GG20518@intel.com>
References: <20180627091034.22724-1-tiwai@suse.de>
 <20180627091034.22724-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F31267999
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 18:12:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180627091034.22724-2-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 27, 2018 at 11:10:32AM +0200, Takashi Iwai wrote:
> Although snd_hda_power_up() and snd_hda_power_up_pm() may fail, we
> haven't dealt with the error properly in many places.  It's an unusual
> situation but still possible.
> =

> This patch spots these places and adds the proper error paths.
> =

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_beep.c       |  3 +-
>  sound/pci/hda/hda_codec.c      |  4 ++-
>  sound/pci/hda/hda_controller.c |  4 ++-
>  sound/pci/hda/hda_proc.c       |  3 +-
>  sound/pci/hda/hda_sysfs.c      |  4 ++-
>  sound/pci/hda/patch_ca0132.c   | 53 +++++++++++++++++++++++++++-------
>  sound/pci/hda/patch_realtek.c  |  3 +-
>  7 files changed, 57 insertions(+), 17 deletions(-)
> =

> diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
> index 066b5b59c4d7..e9d5fbd6c13a 100644
> --- a/sound/pci/hda/hda_beep.c
> +++ b/sound/pci/hda/hda_beep.c
> @@ -26,7 +26,8 @@ static void generate_tone(struct hda_beep *beep, int to=
ne)
>  	struct hda_codec *codec =3D beep->codec;
>  =

>  	if (tone && !beep->playing) {
> -		snd_hda_power_up(codec);
> +		if (snd_hda_power_up(codec) < 0)
> +			return;
>  		if (beep->power_hook)
>  			beep->power_hook(beep, true);
>  		beep->playing =3D 1;
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 20a171ac4bb2..44165f3e344e 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -65,7 +65,9 @@ static int codec_exec_verb(struct hdac_device *dev, uns=
igned int cmd,
>  		return -1;
>  =

>   again:
> -	snd_hda_power_up_pm(codec);
> +	err =3D snd_hda_power_up_pm(codec);
> +	if (err < 0)
> +		return err;
>  	mutex_lock(&bus->core.cmd_mutex);
>  	if (flags & HDA_RW_NO_RESPONSE_FALLBACK)
>  		bus->no_response_fallback =3D 1;
> diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controlle=
r.c
> index a12e594d4e3b..4273be1f3eaa 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -645,7 +645,9 @@ static int azx_pcm_open(struct snd_pcm_substream *sub=
stream)
>  				   buff_step);
>  	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>  				   buff_step);
> -	snd_hda_power_up(apcm->codec);
> +	err =3D snd_hda_power_up(apcm->codec);
> +	if (err < 0)
> +		return err;

Missing azx_release_device() here?

>  	if (hinfo->ops.open)
>  		err =3D hinfo->ops.open(hinfo, apcm->codec, substream);
>  	else
-- =

Ville Syrj=E4l=E4
Intel
