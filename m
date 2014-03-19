From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Wed, 19 Mar 2014 13:14:57 +0000
Message-ID: <20140319131457.GK11706@sirena.org.uk>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
 <532848D5.30806@ti.com> <53285827.1070709@ti.com>
 <20140318180732.GJ11706@sirena.org.uk> <53297BEE.4050903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5391760368256058005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB1132650A0
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 14:15:06 +0100 (CET)
In-Reply-To: <53297BEE.4050903@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5391760368256058005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jh1kIBBoW85WO3/I"
Content-Disposition: inline


--Jh1kIBBoW85WO3/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 01:13:50PM +0200, Peter Ujfalusi wrote:
> On 03/18/2014 08:07 PM, Mark Brown wrote:

> > OK, so is the patch an improvement or not?  If it fixes some cases it's
> > probably worth applying even if further fixes are still needed.

> Some application might fail (like mplayer with 44.1KHz) with constraint on the
> period size only. Without the constraint we will have constant pops at every
> period when non aligned size has been selected - if the FIFO depth is
> configured to more than 1, which is not yet the case in upstream.

OK, given that the FIFO depth change isn't yet upstream it'd be a step
backwards so I'll leave this for now.

--Jh1kIBBoW85WO3/I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKZhOAAoJELSic+t+oim9Tg0P/1nCs10gTnHnELmK2dTt6pHg
3/XVVG+P6s57QoX5F4zUKrw7+TosAPFu5DsyUZho8DFhodxq6RBRKta4xys3wr4B
Iuz5fYMPGeTgCuc7yOvZSqpq70qE3owu+/kZ38zBfEWNtMahAcd/a8SArGFX+scy
6iUr3l0+2N/7hRkHn/gtnKmu6QMgFT+9zMwASabePidzi0WxEhpGqTKEO+pd8Bzt
aUfNfCsc0iRUtwAPif5OQT9+1gI/x+Lt8DVWIrADkk4bVrQQxaWVGJ/EubiHqC37
X0HAWyBLH62IGOJGqP8gyBgyflHHF6eyJn+HmRhv0GqiGmuaaAtHnmWOgVcxad4/
QW+VWQigeIzo9gxWpkuH3prfWCRTydVWrvPns/Vo7TIK9tl9Nc8f+BWCP7r58ylK
ZskvTcTdjHWbQclDKulG9Z01rM0Aj7eBGRlDOxsGs7jgkWcvqHAUztsTLgSlLuVB
veLayfgJsToqM5G+eFsAaL6JVq1WV2sztu5T2aRNqfEdTNuq7cMnh5gPNQIUkoAK
LvY8sfRxVUd1VJeslJuBxQZXLqINe5SkqWqAuArARjbrIdV31pnSON7C89os0Xo5
fIx5Op9otaluT6gPPiShss5cueCBGOwDAD5NAzGQXQ91M1EVQ4Hg/cJkM8D4Yn6r
v84N5+dZVSZoU4rNrgil
=tBH5
-----END PGP SIGNATURE-----

--Jh1kIBBoW85WO3/I--

--===============5391760368256058005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5391760368256058005==--
