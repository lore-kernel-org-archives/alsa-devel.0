From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.3
Date: Mon, 6 Feb 2012 11:15:51 +0000
Message-ID: <20120206111551.GD3070@opensource.wolfsonmicro.com>
References: <20120204125527.GC8042@opensource.wolfsonmicro.com>
	<s5hobtcqpcr.wl%tiwai@suse.de>
	<20120206110807.GB3070@opensource.wolfsonmicro.com>
	<s5h8vkgqkoj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4507177247106343163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A7B8103A71
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 12:15:52 +0100 (CET)
In-Reply-To: <s5h8vkgqkoj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Junio C Hamano <gitster@pobox.com>
List-Id: alsa-devel@alsa-project.org


--===============4507177247106343163==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 12:13:16PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > The tag.  It's done this because I generated the request too soon after
> > pushing the tag so the tag wasn't on the server but the branch was and
> > it's not done the right thing with the error handling.

> Interesting.  So, git is too clever and gives the alternative
> automatically...?

Sort of - AIUI it just looks for something on the remote end that is at
the appropriate commit (which is what it's always done).  When the tag
support was added it should probably have been modified to check that if
a tag was specified to generate the pull request it's found the tag
rather than the commit.

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL7ZcAAoJEBus8iNuMP3dDq4P/Rn2J5F9v900CI4rCWLRT1F4
CgB64xq/kKJmAm5YmZkSE6ORwkMC3eqVm8l5/iB3YjVWwLcYnCD5diKbvBHMHZva
c0ndXTSetUk+dCZBrb5m7ixE8I2lIsywnYggjAtVmyTQ5whhl1qD3xP1DUN1Ea7Z
TLPFhBueHE9vBs/JsW4yc0xx/cUp1SI4rHy5LZMzb+2NKcWlF9ux+q87CjHlyQ7y
juxDm1pi9jzG91mrLWPcN6dDPZcfwsibD/OnvH6xj3dRtMLcgn+8KDmRSZcSIUOv
xCkrb0tqPyxvuJ4cQq3C62O6FdHSgepZmmN4987byr7mKJRwHinUJdsXl4tIXC5F
8Z4OR81AMqdi1fv84u4746TPXxwwOOYXl4IqU6K0en0h/ykDd2MxAokpjVkT+m5l
8KlsC2FI4r6WtnZj+c9VDHPakXIqFtVuJ4XFL7HWczIvMB6JYZ0hPGQOgdQvGntk
bujxhq2bSheJpR9xE683hZATNhHaPjumqP03ZWb7xTALTBvbpiW9xTH2qilnqR7/
vydXql/8Tgxj6J1hDSByDm3XMkW8zz1yReB308LLOS3uMAHMvvNab6MLY5eb4947
hFZsCFsCVSiJYyvBpUs8Oifxq5x8bcxI1LXtWX/raWXdeChBgCLysFtOmru5Ql9g
Bf3VDTqZE7d9EN/34eLu
=/duA
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

--===============4507177247106343163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4507177247106343163==--
