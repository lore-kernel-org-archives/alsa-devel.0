From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Wed, 9 Sep 2015 16:13:28 +0100
Message-ID: <20150909151328.GL9751@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <alpine.DEB.2.10.1509090954430.3157@heelroid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8041751709196532139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C02526049B
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 17:13:41 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1509090954430.3157@heelroid>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8041751709196532139==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gmhhrsDozM2n+uz5"
Content-Disposition: inline


--gmhhrsDozM2n+uz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 09:55:53AM -0500, Brian Austin wrote:
> On Wed, 9 Sep 2015, Mark Brown wrote:
> > On Wed, Sep 09, 2015 at 04:40:36PM +0200, Takashi Iwai wrote:

> > How are you generating these - what compiler and config?  None of the
> > build bots are reporting any of the warnings you have here.

> Shouldn't that build server at Intel catch these? I usually get emails=20
> about things like this from them.

Yeah, I haven't particularly noticed anything from them either (they
don't publish reporting like kernelci.org does or I have locally for
mine so it's harder to see if they reported something and it got
missed).

--gmhhrsDozM2n+uz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8EyYAAoJECTWi3JdVIfQLioH/jn5ZU73Hp7ZP+K7kSmYAEwb
H/lCHI8Ds9g8omOwRMSjU3Z1ZGkVg03NVwZV7Wa4k+kp8JDdHeuhyV8jnexGhhDP
+pjXdDS3DrUNl/tu7upH2LYC/0nNZHWujB6hHjT2ZeWdcBMbAUvt2YlFTTl9Zut6
Ez5/1NcvUOH9slVt3AvXPm/bE7RXD9dTGv5ZGKKMI2cph/NMYTgubPHuhSJNyUpn
kG76/j0jljHMViK6R2/zzAcSYHHRa/4aV5Yfrt7Z47fRNzi+vvstl9DFCVM7m3PC
qLJze4doIXceV5s9fAjfafi4jPPdOrFxPtNkLsErA/bNC9Si/zEpgd3GfwdGcEM=
=AIDj
-----END PGP SIGNATURE-----

--gmhhrsDozM2n+uz5--

--===============8041751709196532139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8041751709196532139==--
