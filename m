From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/7] ASoC: Intel: mrfld: add the gain
	controls
Date: Thu, 25 Sep 2014 15:20:26 +0100
Message-ID: <20140925142026.GS27755@sirena.org.uk>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7493954242519295791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC5D8260421
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 16:21:04 +0200 (CEST)
In-Reply-To: <1411125368-5836-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7493954242519295791==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLfVvEQOBD/VeTNx"
Content-Disposition: inline


--yLfVvEQOBD/VeTNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 04:46:02PM +0530, Subhransu S. Prusty wrote:

> +/* Gain helper with min/max set */
> +#define SST_GAIN(name, path_id, task_id, instance, gain_var)				\
> +	SST_GAIN_KCONTROLS(name, "Gain", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VALUE,	\
> +		SST_GAIN_TC_MIN, SST_GAIN_TC_MAX,					\

As far as I can tell from following the macros through this looks like
it will create controls called "name Gain Volume" which doesn't seem
excellent.

> +#define SST_NUM_GAINS 36
> +static struct sst_gain_value sst_gains[SST_NUM_GAINS];

> +static const struct snd_kcontrol_new sst_gain_controls[] = {
> +	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst_gains[0]),

This table is full of magic number references into the array...

> +	SST_GAIN("codec_out1", SST_PATH_INDEX_CODEC_OUT1, SST_TASK_SBA, 0, &sst_gains[23]),
> +	SST_GAIN("media_loop1_out", SST_PATH_INDEX_MEDIA_LOOP1_OUT, SST_TASK_SBA, 0, &sst_gains[30]),

...with holes in the array.  This seems really error prone.

>  	char params[0];
>  } __packed;
> +/**** widget defines *****/
> +
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +struct sst_ids {

This is adding includes in the middle of the file (which isn't the usual
kernel coding style) and is missing a blank lines.  This sort of stuff
is getting quite repetitive and hence annoying, especially the blank
lines thing which comes up again and again and just makes everything
even harder to read.

--yLfVvEQOBD/VeTNx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBAgAGBQJUJCSpAAoJECTWi3JdVIfQNrAH+LBKUAKlet09Bsxu2jWGuAdA
ri4HhMfMQZfkmDViRyz49oRd7ZWGZrUjC3BUPbKdoJVMEz/RyeAXzna0YQGHbPmb
Jl8Wti30pX/6Q1dWAxZBg375wmdVPNlMnW5Q2QihcZCUZDkBtsZV4IrLPSWDt9wH
7fHdjQKamiwCcjBg/eQWRLjQckUCTOODzwIagV+k6XkRcBpO2bz4BCpCE7TR0imv
q/0fUnof9ZDO88FX6kB90pTe3vMjOF0wDJdFxBPkX3eKzui4enjjTMrkPmisNcR7
hUhIR2qZ0j86EBv7i0JeZsEvJS4GSyr6QE6R5wzDp4iqaPkAwhO11IZDKhw0hw==
=s6/C
-----END PGP SIGNATURE-----

--yLfVvEQOBD/VeTNx--

--===============7493954242519295791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7493954242519295791==--
