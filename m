From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/4] ASoC: core: add code to complete
 dai init after pcm creation
Date: Wed, 2 Mar 2016 19:34:34 +0900
Message-ID: <20160302103434.GG18327@sirena.org.uk>
References: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
 <1456820357-2545-3-git-send-email-arnaud.pouliquen@st.com>
 <20160302040313.GY18327@sirena.org.uk> <56D6B335.4090509@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2236679878912052980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE61F261515
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 11:34:49 +0100 (CET)
In-Reply-To: <56D6B335.4090509@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org


--===============2236679878912052980==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xx/ztRkOV32K77De"
Content-Disposition: inline


--Xx/ztRkOV32K77De
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2016 at 10:32:37AM +0100, Arnaud Pouliquen wrote:

> Here is an alternative but with higher impact in soc-core:
> 1)Create 2 helper functions in soc-core:
>  - snd_soc_add_dai_pcm_controls:
>  	=>register a control that needs to be linked to pcm device.
> 	 if dai probed(pcm device exist) => link control to pcm device
> 	 else postpone link creation in soc_probe_link_dais
>  -  snd_soc_add_dai_iec_control
> 	same but based on snd_pcm_create_iec958_ctrl

The whole point is to avoid functions...

> 2) add 2 news fields in snd-soc-dai struct
> struct snd_kcontrol *pcm_kctl /* list control that will be linked to
> pcm device*/
> struct snd_pcm_iec958_params *params /* if not null iec control is
> created */

> Abandon helper function for iec control should simplify implementation
> but that also makes sense to have helper for this generic control...

This seems better though I'm confused about what exactly these would be,
I've not looked at the first patch since it seemed to have problems.

--Xx/ztRkOV32K77De
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1sG4AAoJECTWi3JdVIfQqrQH/36H+0RIJKoQUXL2RzaY8RFC
efJmKTLxcRwnXr7D6QWPJrtpfPdOkMwes56QwIlt3pQEvXeDnhI68yQuq7Yvb6L5
YaBxqsLPsJg2TGynAkX+42hknW9Oa7pEx5skLqbcUdxIynh4UZSovTTcDhpmQIID
keIo0mZvKjTZsu1tPB3/z4TCnc4wN4v/ygDniUzoQhznQh62GQtT09YFdpw/n8qN
ep1iHNqBN1pW29u/alhTr0pXjxU2H19qqVStRqTAr1bjmkBNNLlY8AFIq+pT6U0/
+T4GZdVinFantn4EbI4L/23YEuiGA3m1MFvkj/s8a3RqM2SA86+9wczHIa2d2r8=
=d0J4
-----END PGP SIGNATURE-----

--Xx/ztRkOV32K77De--

--===============2236679878912052980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2236679878912052980==--
