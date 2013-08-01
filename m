From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm0010: Use DMA-safe memory for SPI
	transfers
Date: Thu, 1 Aug 2013 10:02:00 +0100
Message-ID: <20130801090200.GH9858@sirena.org.uk>
References: <1375347225-6453-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3102385351703720026=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BEA62616CB
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 11:02:03 +0200 (CEST)
In-Reply-To: <1375347225-6453-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3102385351703720026==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWpKTRlZ6tbpMUDT"
Content-Disposition: inline


--SWpKTRlZ6tbpMUDT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 09:53:45AM +0100, Dimitris Papastamos wrote:
> We should be allocating our buffers for the SPI transfers
> from the DMA zone.

Applied, thanks.

--SWpKTRlZ6tbpMUDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+iQFAAoJELSic+t+oim9ek0P/21izVPJMCQizY/DI+sbtl+J
iP+2b3wRBQmEDNsuEJK9JDbFW9FG+OJZnmjpoqqlNgd1Ij5O5X6Q6a5uQBeTbIrv
vjuz7qTdcjlE6y5/h/3mz0TGXFS9XHRnUtUsopDpsGLPAZ8p6EfgZV7/L0vMXNaW
iOiwtdZGqrvhk8FPNtglbEFZTj9xG24Dj0UqPorYyaflH2vMwfd2re/L5fUvmmdj
jlNe3tgJ505Hv1V92P69HudUmndNXkpyNBlPEzhKAdXi6aG1FWdUKBe9F9RrvVLc
jhroRuENM+uNlShECrRR1FtNmpnGYo2vCFpeChn0IfLSlqJhJR/xf3iZzDVpIy23
GGk4xU0JAyhU4Hw9l4+4zm0qclPEwKNYLtQYl4zEGMVGUgqEhrmwuhNa6t/yPvCQ
f2vQXfQMSf6ve0fBIzaAplyopwp0r6o1TReUv66ARSuBLMd/vPjLrgZRaZ2tbzTd
HuRLb8XNUH+uHOfcSwwx54nE6m0QVIyn0pA3/CbY/YPv49TItRf8aJ0GscR5pGN8
vZ/xbCSjDCh1nmww7fkveA9Zp7+aUXR9QTKnPpcOQS0Xvmid1yHbq2tt3WPcgiNb
BNegmqCYFWc3DD+sDkx4Hd+Y++xpKweUbPW1wVHrdGhPCWamlqF95lD9Cn98H28u
HBXI/ZGuaKhEjA0n2xcQ
=QKid
-----END PGP SIGNATURE-----

--SWpKTRlZ6tbpMUDT--

--===============3102385351703720026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3102385351703720026==--
