From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/6] ASoC: core: add
 snd_soc_add_dai_pcm_controls helper
Date: Sat, 12 Mar 2016 13:11:05 +0700
Message-ID: <20160312061105.GX3898@sirena.org.uk>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
 <1457441641-7501-2-git-send-email-arnaud.pouliquen@st.com>
 <20160310050646.GD11154@localhost> <56E13971.9030909@st.com>
 <20160310125817.GB6839@subhransu-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7070641761461700417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37CAA260714
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:34:33 +0100 (CET)
In-Reply-To: <20160310125817.GB6839@subhransu-desktop>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, "Koul, Vinod" <vinod.koul@intel.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org


--===============7070641761461700417==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rzwkXnKuCXxoL5m"
Content-Disposition: inline


--3rzwkXnKuCXxoL5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2016 at 06:28:18PM +0530, Subhransu S. Prusty wrote:

> That calls for a discussion on how the controls should be represented for
> DPCM. Takashi/Mark/Liam we need your opinion on how the PCM related controls
> should be represented in DPCM concepts.

I think we should be moving away from DPCM towards something that scales
to cover off-SoC devices as well.

--3rzwkXnKuCXxoL5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW47L4AAoJECTWi3JdVIfQ8qsH/2Zj/CexWUFUr8lASx4qgqNb
s8R25e4HtgzexvYnPelOXA+mjlmor4BkkZhRiS4vbxiWehwoWVOJynQeWenCWmtQ
dFsUYs6FAOUd56fxptREQ+oO2mntKAajdH5+j7lk+jx8zAKpGVGTCJ8dVFO3eIHu
vNd28t8TmByjZtQayrDHVnyMFOW86mSQfFVoYcd4vpUiC8WqEsx/5u5edMweVSYb
JZlDT9lTB5acnfqIs9l/RejXx0uxhd2CqMF3o7qBWcvGxcyYkuxBsiE41jB/bPW+
g8wk7/pUgmpJPLpLl71NLMLVYy026GX+oQumIef5KZpkjfxscIMQoL1yj5TAXDE=
=O69W
-----END PGP SIGNATURE-----

--3rzwkXnKuCXxoL5m--

--===============7070641761461700417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7070641761461700417==--
