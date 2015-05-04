From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/7] ASoC: hda - add soc hda codec
	driver wrapper
Date: Mon, 4 May 2015 14:12:26 +0100
Message-ID: <20150504131226.GV15510@sirena.org.uk>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
 <1430250870-3169-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0435389441887069557=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C78D42604E4
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:12:41 +0200 (CEST)
In-Reply-To: <1430250870-3169-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0435389441887069557==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b3OyYALfe3DXUU4J"
Content-Disposition: inline


--b3OyYALfe3DXUU4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 01:24:24AM +0530, Vinod Koul wrote:

> For ASoC HDA codecs we need to provide match function based on id_table and
> driver register/unregister wrapper functions

This changelog doesn't really leave me that much the wiser as to what
this is intended to do...  what are we matching in what ID table and
what are we wrapping?

> ---
>  sound/soc/Kconfig             |    1 +
>  sound/soc/Makefile            |    1 +
>  sound/soc/hda/Kconfig         |    3 ++
>  sound/soc/hda/Makefile        |    3 ++
>  sound/soc/hda/soc-hda-codec.c |   85 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/hda/soc-hda-codec.h |   44 +++++++++++++++++++++
>  6 files changed, 137 insertions(+)

If this is for CODECs why is it in a new directory?

> +const struct soc_hda_device_id *
> +snd_soc_hda_get_device_id(
> +			struct hdac_device *hdev,
> +			struct soc_hda_codec_driver *drv)

Please can we have more normal indentation - put at least the first
argument for the function on the same line as the function name.

--b3OyYALfe3DXUU4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR3A6AAoJECTWi3JdVIfQ9KcH/0jBPANijZQZtxsPSQZZNex0
pYyDjlXiRggbUl5334wagT8XGKfUXxNbYcsPazRyhq4UyD6ccekJyvjcGjDbPycQ
1kFgfeqKctQdpNRrM8UKJLtyqH5e1I5VePgqnjuNlGWbo2p+fpo4SYkD5tMSKVov
kj7ruDXdCaqbypEZBg/W55VvuItbZUIRmQU2fE2infAoXKwrU03Mqk4A67TPzGEr
DMGevfVvIKvchY+49fQrOIkLI4R8BG9Q3C7j7n7puBAmD7uvPu9qv2l9hUnV5qiA
3S5xcVaOHY5i0/RYApOj7PHOP1U4SV3FatJ88uyQsPnOxrs+3SuCgpUYHYe+WLc=
=A/Fc
-----END PGP SIGNATURE-----

--b3OyYALfe3DXUU4J--

--===============0435389441887069557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0435389441887069557==--
