From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: nau8825: Add FLL configuration
Date: Mon, 19 Oct 2015 16:25:57 +0100
Message-ID: <20151019152557.GB32054@sirena.org.uk>
References: <1444427341-7135-1-git-send-email-benzh@chromium.org>
 <1444452616-32903-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1290251760924655317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF722656F3
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 17:26:03 +0200 (CEST)
In-Reply-To: <1444452616-32903-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Anatol Pomozov <anatol@google.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org


--===============1290251760924655317==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 09, 2015 at 09:50:16PM -0700, Ben Zhang wrote:
> snd_soc_codec_driver.set_pll is implemented to configure the FLL.
> The codec internal SYSCLK can be from either the MCLK pin directly,
> or the FLL. This is configured by snd_soc_codec_driver.set_pll.

Please don't post new patches in the middle of an existing series, and
please don't post partial patch serieses - both makit it hard to follow
what's going on and what the current version is.  As it is I'm a bit
confused as I have a v3 1/2 but no 2/2...

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJQuEAAoJECTWi3JdVIfQJcgH/3n4OuK4DFIiOM70Xe+iQItR
6abA30OdlUvkBVK4LcXMgjgUJKJHSJ0+oLUtiM9FWqd2axNMqzwUr+Vd+K4E7xff
VxxWfBPo99cImRqjKELr4d8WymypAKUjoGNXKdxC8/OG3rxheJ16hNxpIRzhneTp
SDRP0tcq7J/AX1XvJhNak4vOTsROEwYWuqNZnPMAmV1lzSuGwg1pIIIF+9VGSCSe
ODx50S1u+gzv7VkRHn1P1fgiwKu3977nv4+g3pvEsNmdgHn+bTptdW+eNPCo0/E/
UBr66uzs3RPllg/7hWo0Sb68Hp1IEtbw4fcN+XyyTZ1hGY2p69xnIb0O4M8zi2A=
=g9Vw
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

--===============1290251760924655317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1290251760924655317==--
