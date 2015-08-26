From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: rt5645: Prevent the pop sound of
 the headphone while rebooting or shutdowning
Date: Wed, 26 Aug 2015 11:51:58 +0100
Message-ID: <20150826105158.GP12878@sirena.org.uk>
References: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
 <20150825175726.GJ12878@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F90D70@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6200038585128095051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BF5F2604D5
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 12:52:03 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F90D70@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "woojoo.lee@samsung.com" <woojoo.lee@samsung.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6200038585128095051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RtGa12sjXv8gVUZO"
Content-Disposition: inline


--RtGa12sjXv8gVUZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2015 at 02:17:40AM +0000, Oder Chiou wrote:

> It de-initialed our jack detection function, and it cannot be turned off in
> _BIAS_OFF. If we didn't de-initial it, we will hear the pop sound in the
> situation of powering off, thanks.

OK, can you add a comment explaining what the register writes do (or
ideally move to using #defines for the register values so it's obvious
just from looking at the writes)?

--RtGa12sjXv8gVUZO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3ZpNAAoJECTWi3JdVIfQjP0H/A6yGKGd6g0Evr3vKTrxYe0q
GbWOZulugg5h10q2Gv9MjZBkqWsvCDtYDDWwcj7w9NZvBUn7tJ9F2mXoKUQo/Dsz
qHs/WP5CiEKcJDTKUimkH2GwuBhRzxR24fDfHsaGzd9ioMgaZAI4PNdNrZs/u3Iw
lDJSFDiXb+13/VBefnDQxlTVC13+w6LEyce0/lQzW44bhvlWGeZw3spCxiJySKjE
oLF9oPdF10JcdjXd9/YGqrBn6vrXSTC/oEi9h1SUg7v+bnaic1lmtZly2Jo8hfhB
CWlsMFooV725dHLKmjR3Uu7UcI7pzGlKeMHBLXCCqyndv/DEancftKP8nN/O/EU=
=Jdbp
-----END PGP SIGNATURE-----

--RtGa12sjXv8gVUZO--

--===============6200038585128095051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6200038585128095051==--
