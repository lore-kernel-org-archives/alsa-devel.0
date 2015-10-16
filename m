From: Mark Brown <broonie@kernel.org>
Subject: Re: HDMI codec, way forward?
Date: Fri, 16 Oct 2015 15:12:51 +0100
Message-ID: <20151016141251.GL14956@sirena.org.uk>
References: <5620E482.6050507@ti.com> <5620EE2F.8070504@metafoo.de>
 <20151016133717.GI32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3029967738480357641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4215A2606A2
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 16:12:59 +0200 (CEST)
In-Reply-To: <20151016133717.GI32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, Vinod Koul <vinod.koul@intel.com>, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3029967738480357641==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6aLNMpa4RfPduGT7"
Content-Disposition: inline


--6aLNMpa4RfPduGT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2015 at 02:37:17PM +0100, Russell King - ARM Linux wrote:

> If all the effort that's been put into discussion was put into sorting
> out a solution, maybe we'd be a little further forward than we are now.

> I've sent one proposal which uses a notifier to inform audio and CEC
> drivers about state changes in the HDMI video side, and had precisely
> zero replies to it - people seemed to prefer discussing stuff rather
> than reviewing code and coming up with actual solutions.

I agree entirely with the above.  FWIW I'm not reviewing code so much
because I don't feel I have enough HDMI-specific knowledge to make sure
things are general enough and the lack of discussion makes me unsure
that it's really helping - I don't want to give the impression that it's
a case of addressing some code level comments I might have when I'm not
sure we're even travelling in the right direction.

--6aLNMpa4RfPduGT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWIQXiAAoJECTWi3JdVIfQpjYH/0E7C8wIMzD7NmN16IFS5jvj
FIhPiEjA29Z7rtc+9ET6yeZzsgT0GYz6MRNu/6KdNsoCKfx5PoPBzMekpe282HoD
pObU3NsulZtesS4KnLEQtZjH6F5WSHzqIptdXUpqc+YH9j0fpMNIkz9/vclViyE6
+pcLVaoXRjDcxp631lboft0a2zZ8bJuFojnwpEViwp810qsEBaDE6UTvyk/XlCMo
QLtHwUD8pkYqwZwlhsReOblPG1sFeKOISJx3XZGbJFksK9QQqDsbS9lxboF130Ek
zOs2KCJP/lib2ywxWkvgdRiIiD2a244j+Gxshp/VPNGB/eR9rt7I37VF4KO4UpU=
=k65h
-----END PGP SIGNATURE-----

--6aLNMpa4RfPduGT7--

--===============3029967738480357641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3029967738480357641==--
