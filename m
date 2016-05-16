From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.7
Date: Mon, 16 May 2016 14:24:29 +0100
Message-ID: <20160516132429.GM2953@sirena.org.uk>
References: <20160516111142.GG2953@sirena.org.uk>
 <s5hzirq5f66.wl-tiwai@suse.de> <s5hwpmu5eji.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3053989586420808637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 980F22666B8
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 15:25:07 +0200 (CEST)
In-Reply-To: <s5hwpmu5eji.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3053989586420808637==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2016 at 03:16:17PM +0200, Takashi Iwai wrote:

> BTW, one trivial warning to be fixed is:

> sound/soc/codecs/hdac_hdmi.c:1721:16: warning: unused variable =E2=80=98t=
imeout=E2=80=99 [-Wunused-variable]

> Introduced in the commit b2047e996cd8
>     ASoC: hdac_hdmi: add link management

I've got a patch for that in my inbox.

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOcoLAAoJECTWi3JdVIfQDVwH/2hOM6uV8mDcA7QZ0sNHzg1W
vuEjMnMjbS+rnryIZSijjjXLv8JULuGoELHKUaW196DhkxqhExV1qHnG18aii4tJ
j3V8TMmJoG0x82ehilCUXnaMb2g8cx7WGnm4tc/46xNRNpY1kz3NkHG+zZqpgWzL
k+66pOv/Cud4aYoXjY9tmGMmnhDDoNU08bQK0D3DgV2ocTKJ8yrKnQXdtE8k0NQc
T/qy2byibnlSd8qEoBlikGTTrUl+RrsZklCF9kSaLZYzKI3E29atIeDtHWdJu8o4
fHPi3PaZ5qwMeXwm7cl5f8XYMjHuBrh8nsckzKG/AiOqCQSEAfax1cZ8g6gX9aA=
=l+j/
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--

--===============3053989586420808637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3053989586420808637==--
