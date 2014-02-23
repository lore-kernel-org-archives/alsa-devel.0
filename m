From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 046/102] ASoC: uda1380: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:31:35 +0900
Message-ID: <20140223023135.GL25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-19-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7867125447372433941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F4175265055
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:55 +0100 (CET)
In-Reply-To: <1392723517-12772-19-git-send-email-tiwai@suse.de>
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


--===============7867125447372433941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FC52J0nKTzya17Ed"
Content-Disposition: inline


--FC52J0nKTzya17Ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:02PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.
> Also, use ARRAY_SIZE() in some ASOC_ENUM_SINGLE() lines.

Applied, thanks.

--FC52J0nKTzya17Ed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV2DAAoJELSic+t+oim98eUP/2AiwgGuPMRtFsRiz5lhEUqQ
mTkCkd8/V6BlwG4M08iPEJD+VrHLoupImmvBDpPWIT5/GcrcQCRlBaYWPS4b8EkF
RATtr+bs/yixNTa9G9Isa2hQQscJHcTSYZ2zBSThOuVaWbRAicREJzGNHUoZ+p5v
yfZReXhmWLa3j2U2llYMMRkPt4mlrl+/OCxtgerxbmfPnzG1NXOnKHzhsiqeWjkA
29Fuunb/5C4A/q3UuS5dG+IOffsPpVO6Ep9yWsVqtGmuc977SaG3QUTF9aDHfyq3
rgbx8ALhV5hNO1SVZ283kj7/PtlKKMzuuFRGQXiISrWrSjLbqJKBGgxdTXIQJLfO
ZVukaPyqwZTm8AWeBgZU8mPqtf8JiF1VXWIizVtMsmIpantgAZ4eXpJH5OsEUAWK
KtBNB0ZKh0BJL0KHDLJwTQnefcyDdH4CqbeZx4K5YXu/k71OBowICnN6Aa698Nxq
7fBN1s18t/2NKr1K+TzHHG/Na0XSyLl14RHcxUm5q1YmkNokZdk7ODPj3h3695tg
eMwTOVkN/SLZSQ3Qtk0j3meQkt4YpHX1CeFOYYWWTzt6V7+XfdeLZPiF6bnf5wVs
W29I/Oaof60GMvHalO822/Jb2q8A1ULyoq6kxktCVrHJZIOBieZxcRDVj9MabGdL
SXY3mXqFYbNudbmhR5mP
=q1A0
-----END PGP SIGNATURE-----

--FC52J0nKTzya17Ed--

--===============7867125447372433941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7867125447372433941==--
