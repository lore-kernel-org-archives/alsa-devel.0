From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 17:41:02 +0200
Message-ID: <87ehl93rap.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <87pq5fiklg.fsf@dex.adm.naquadah.org> <s5hwqzna4pn.wl%tiwai@suse.de>
 <87haqrijiz.fsf@dex.adm.naquadah.org> <s5htxura31x.wl%tiwai@suse.de>
 <87d31fii3v.fsf@dex.adm.naquadah.org> <s5hmx0ja08z.wl%tiwai@suse.de>
 <874nmried6.fsf@dex.adm.naquadah.org> <s5hfw6bpen9.wl%tiwai@suse.de>
 <87vcf7gyl5.fsf@dex.adm.naquadah.org> <s5h6277pdfi.wl%tiwai@suse.de>
 <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <5072E5A7.9040701@canonical.com> <s5htxu5gfy7.wl%tiwai@suse.de>
 <s5hr4p9gf5x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5931095067851440880=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 234BF261983
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 17:41:53 +0200 (CEST)
In-Reply-To: <s5hr4p9gf5x.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
 08 Oct 2012 17:24:42 +0200")
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

--===============5931095067851440880==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08 2012, Takashi Iwai wrote:

> In other words: Julien, could you check whether beep volume from
> speaker/headphone changes when you adjust "Beep" volume in alsa mixer?

When you say beep volume from speaker/headphone, do you refer to what I
call noise?

Because if yes, this is actually the case:

=2D if "Beep" muted -> noise :(
=2D if "Beep" unmuted and volume =3D=3D 0 -> no noise :)
=2D if "Beep" unmuted and volume > 0 -> different type of noises! :(

=2D-=20
Julien Danjou
=2D- Free Software hacker & freelance
=2D- http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQcvQOAAoJEGEbqVCLeKXCFZMP/iKMcNicyTgjT0x1hstYmOgt
UfGdn7OrUtatiZRA5gLMEYVWNm6gEc6/UI1B0C62R5Rp1O+X1aDTLLX/POYvHWXp
MnraomWpVxkPiykszk4gFsj0fbJzyxI25UOgnaVWJM0u6e71MYk0/UgLDFdA+n0b
WEO1FvIIH4bjsEBDlcpnA/10x2Jc8Hd3iMVEvp9uCilIwSwcCPCCoPzlacm5v7hE
+cH3BwMKvGa27CVfbd0d3eeJZppAGdlT19tHhrCpxjhoEmjZjm8RzMoI42+ol0Tp
MeU7pUf7744GN4mrfu/+PI2s2nju+6NfawqdLQuefNduZt18ysTI94/u2lwix7mQ
50hCCNCZoHEUxAV39nJJeOL2KzQsbN6Yr6i48IbCV9pxWJQQNHq18Nmk2bE64Rrx
430U+w7pZjK5Mo1NYCj2BYOE49BBpThOwl9Ogote/vB6lDGuTJB0y1iT/RD7H/ma
1ImOjTsP4m9TJmnfhEARosRSwobXMBXjSyJ5bTTJs7a3lqrgbC7Hz9918gyQ6RAd
Sr2BNaX3TLdQP60rwQ89UpVPG5p8dkxo9Mp4NXYwxYLWvWSLzJZ3iRjA3qOdqplW
1NFTYLtDjs5SS95L8Ptt8yaAyZnaAD1BvQNsw6Zq4Kj4X5i/TAlZFTRiJY4Ks4hc
k7GyzZZZWS0CY6kNgwXq
=Pbl6
-----END PGP SIGNATURE-----
--=-=-=--

--===============5931095067851440880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5931095067851440880==--
