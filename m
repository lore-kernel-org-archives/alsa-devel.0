From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx: Enable COMPILE_TEST builds
Date: Tue, 16 Jul 2013 10:58:04 +0100
Message-ID: <20130716095804.GD22506@sirena.org.uk>
References: <1373904242-30250-1-git-send-email-broonie@kernel.org>
 <20130716002320.GF23589@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7271862338278062915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AA0626165C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 11:58:07 +0200 (CEST)
In-Reply-To: <20130716002320.GF23589@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7271862338278062915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 08:23:22AM +0800, Shawn Guo wrote:
> On Mon, Jul 15, 2013 at 05:04:02PM +0100, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > Since DT based boards don't have any dependency on arch/arm enable them
> > if COMPILE_TEST is enabled.

> I do not quite follow the commit log.  I think menuconfig SND_IMX_SOC
> also covers a few non-DT boards.

It does but they all have dependencies on the boards concerned which
prevent anything except the DT boards showing up.

> With IMX/MXC moved over to multiplatform build, there shouldn't be any
> <mach/*> includes anyway.  That may be the reason why COMPILE_TEST
> should work.

Some of them have or should have dependencies on ARCH_ARM at least for
the machine type checks.  But yes, I'd expect more of the machines could
be built - I just didn't feel like spending the time and effort to check
which, I'm more concerned with getting build coverage for the CPU side
in the first instance.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5RkpAAoJELSic+t+oim90iYP/jeKjoLqVcWbQdg5T70F8Pa+
aq9d1MfutsM42TePHMlATjJx2hhupmutEHiXTDHh2xzrBSH762TQ+qIDbIplDE7Z
C9YrN2qFOoCXp670TAcmLDHSyqvwuLD1J2xaI50RxeK05n7c/HNdrT4NlgWGUy3e
NlljRBszGn/JEzimVsyH8pdZGmwdVFFikJVnJOM7UdvBtesIHS7jJ8jKwyUR+Evr
+35I0bRVd34lbduO3Wbay+zFqVFypXPFuf72f5TS7WUn5OCuVAxYtyvZqGgjRTji
4quB6Gvkt6YlfTh/LureqWCExASYLDdq1g5eutQdEKSXEamhoBj9QHuwudfcXeyz
oAGpNXEj+51PdcJJIYd3nKwM8ouCntYdcW12r5WWWEk9m9/7qWBgN3b/xJAV3cVS
KjlY3JS+/TYhn4mRmiHppw4lDi0FySzXN1G5ei48teqtY/jDL1YadHTD911Mc7Iw
eQPdKdvDT7h6H4vN4urcCwaArZkOZgOWaf4QnpzQLR4p+qv4RBGH7V1917TxD6Fy
cx3JRicRuK9OEADb07xvbM+PMAb6OYctvXRfl5mJ4lgeubAzmaBfvh6wncQCIQpf
ZrO84tGXd7k5oUL+9Zh0wpnXVPtD2Dm0bAcYCwUH6Ja+5Z/rU0nB+qazu/rWIEYp
eiIylC8rx65DyqO+VkVR
=oLKW
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--

--===============7271862338278062915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7271862338278062915==--
