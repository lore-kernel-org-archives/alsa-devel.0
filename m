From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 017/102] ASoC: sta32x: Fix array access
	overflow
Date: Thu, 20 Feb 2014 01:46:34 +0900
Message-ID: <20140219164634.GA2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7788869794029029832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F9FB265AAB
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:46:49 +0100 (CET)
In-Reply-To: <1392723422-12689-2-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7788869794029029832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YfA6L/ars3kY+zmg"
Content-Disposition: inline


--YfA6L/ars3kY+zmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:52PM +0100, Takashi Iwai wrote:
> Preset EQ enum of sta32x codec driver declares too many number of
> items and it may lead to the access over the actual array size.

Applied, thanks.

--YfA6L/ars3kY+zmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBN/mAAoJELSic+t+oim9JUEP/RITF7VirFC5tU4z0Zd5V5m5
bzLg/nasXRY1aHYMUmex/lyfDToFaHQV36bQOCDiX7ZrAsVwz0/RyC/9gHUl7HQr
GwiIFgoCFWVjKTRCrPIvNLiGeq/xcv9sA39KCV/xomkq2jnffFFCH4Zh07U+5uqa
Yv+udlAEftaRwJYdLRpk1SIJvOqSvQnvSX4CQ5il8CQwLvCmyeIfUP+0Gl46NhAi
a784l3hShS/jQKWjPDotttjw/CM7maLLNZ2EyLVaeiCjH4QOryyauTn2ghioxai+
mQ0qYNv8y2sulxqU8XNIxbXU55pEaTbxdNTnFRO2F9LY2x3igrZqed7IF+Q3elN5
8AqtcrohElf2DHhV9QtXA9cUjL6NWgLZWk9tkadtvRErC72krrltAzIdwgTF7k3U
87MKahv7zM3E4vE3iGWPuC6AiRnKKwgBqHTE/HruFOHmx+wX6JzJPOkf1klXeI1Y
7ggQUnl8QmiG5obn6hGJODk+j67gLmHLtNdKlfZOGq+Z/7f10V0QiLe8OxPyr6w+
L7hm0/woAUw12mCU6w4fY2oBez4kA+7EY5WAiXkxZa6y/mZr/HiCNQ2gfKBW0uSW
21tyURF8K6Z7riMjijVURfePvYZvXwMMRIV87i9bhx+ve9LFzGOrMjIPGn5Qryxh
yw0OVzkTz3XvalWnUjJs
=HrHB
-----END PGP SIGNATURE-----

--YfA6L/ars3kY+zmg--

--===============7788869794029029832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7788869794029029832==--
