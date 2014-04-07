From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - Do not assign streams in reverse order
Date: Mon, 07 Apr 2014 23:39:03 +0300
Message-ID: <53430CE7.9060009@iki.fi>
References: <1396899398-1293-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1396899398-1293-1-git-send-email-anssi.hannula@iki.fi>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Anssi Hannula wrote:
> Currently stream numbers are assigned in reverse order.
>=20
> Unfortunately commit 7546abfb8e1f9933b5 ("ALSA: hda - Increment
> default stream numbers for AMD HDMI controllers") assumed this was no=
t
> the case (specifically, it had the "old cards had single device only"
> =3D> "extra unused stream numbers do not matter" assumption), causing
> non-working audio regressions for AMD Radeon HDMI users on v3.14.
>=20
> Change the stream numbers to be assigned in increasing order instead.
>=20
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D77002
> Reported-by: Christian G=FCdel <cg@dmesg.ch>
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Tested-by: Christian G=FCdel <cg@dmesg.ch>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: <stable@vger.kernel.org> # 3.14
> ---
>=20
> Takashi, please check I didn't miss anything (I'm not that familiar
> with this low-level HDA code). :)

Alex wrote in the above bugreport now that the stream counts are:
Kaveri:                4 streams, 7 endpoints
Kabini:                2 streams, 3 endpoints
Bonaire/Hawaii:        6 streams, 7 endpoints
Trinity/Richland:      4 streams, 6 endpoints
Oland:                 2 streams, 2 endpoints
Tahiti/Pitcairn/Verde: 6 streams, 6 endpoints

So we have cards with less streams than converters, if I understood
correctly.

I'd think my patch is still reasonable even if we'll have to fix the
stream counts anyway, the pros and cons I see are:
+ safer in case we/manufacturer get the stream count wrong for some car=
d
- easily hides too high stream count

But your call :)


>  sound/pci/hda/hda_intel.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e354ab1ec20f..7a7b7b10dddf 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1856,13 +1856,14 @@ azx_assign_device(struct azx *chip, struct sn=
d_pcm_substream *substream)
>  		struct azx_dev *azx_dev =3D &chip->azx_dev[dev];
>  		dsp_lock(azx_dev);
>  		if (!azx_dev->opened && !dsp_is_locked(azx_dev)) {
> -			res =3D azx_dev;
> -			if (res->assigned_key =3D=3D key) {
> -				res->opened =3D 1;
> -				res->assigned_key =3D key;
> +			if (azx_dev->assigned_key =3D=3D key) {
> +				azx_dev->opened =3D 1;
> +				azx_dev->assigned_key =3D key;
>  				dsp_unlock(azx_dev);
>  				return azx_dev;
>  			}
> +			if (!res)
> +				res =3D azx_dev;
>  		}
>  		dsp_unlock(azx_dev);
>  	}
> --=20
> 1.8.4.5

--=20
Anssi Hannula
