From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/19] ASoC: fsi: Add DMAEngine support
Date: Sun, 19 Feb 2012 18:40:17 -0800
Message-ID: <20120220024014.GA3914@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3735435262872701188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1621324672
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 03:40:33 +0100 (CET)
In-Reply-To: <87aa50i971.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============3735435262872701188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 12:59:33AM -0800, Kuninori Morimoto wrote:
> This patch supports DMAEngine to FSI driver.
> It supports only Tx case at this point.
> If platform/cpu doesn't support DMAEngine, FSI driver will
> use PIO transfer.

Applied, thanks!  I have resolved the conflict with your bugfix patch
which is now merged into Linus' tree so please check that I have done
this correctly.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQbJ0AAoJEBus8iNuMP3d2xQP/jjUWxz5C2gfVAYNsMFuqeDy
FLj0XbNRI9oc+lSMxGLyQhSy1nYjPEf0ByqIz9L2IejEU0hd36W52lV6Ql7ioCTf
JF0W68RFWeo9xx/j5T5fnEWZtRFQkuC3aDV1DxfCdbXZNgKkdVNwGaO6uamPLHW3
vcRKQXkap918sICTh9B4S0V7p83D0eeMCLEDqMOfKcAnw6KhglOA2b6se+HmjrOq
ZC2dCLoY71/nFpv08xyDWRaoIu28f/DZDhp7WC0J6rboB/OGOdiTpCR91R8drUw6
lscfIjj41XBZ2Lfsc04oIk6oqGMoYQOLxlOv01rCCAeE/DeuMUORDKnpG+9XC4vP
ZT8JAt/jcB62NeoCktPHm0ME0A5p9vbcIID0CKzo1u9lyEls3DZ2q3Cixw7ldNAj
mk/oUHCHX4ZD58831A+efIA0OpNuubHdHLBiAIKb2ijHxLb697wJ6FfQPYv8AhM8
cTDYbckGf3ch14I0ZV2+PTUM/3WVbsUleHEWr3AUJOqbg+ckzkcYs7VBhMJLUo2k
lYos5jhMcFkD773TrCe2uLzGI0mVr6LqD+qBPklwykrQy62BloLy5sOJut//qHbg
zM8UmfmUOIEwkOzy4jYFtfp/8KpOgOetU6CnSUsYF2xcStcGj4WSS0lK5Uge1md1
76sfCKzf+42aZMpQ6lPT
=BIsl
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--===============3735435262872701188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3735435262872701188==--
