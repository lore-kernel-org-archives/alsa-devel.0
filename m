From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 18:09:10 +0200
Message-ID: <878vbh3pzt.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <87haqrijiz.fsf@dex.adm.naquadah.org> <s5htxura31x.wl%tiwai@suse.de>
 <87d31fii3v.fsf@dex.adm.naquadah.org> <s5hmx0ja08z.wl%tiwai@suse.de>
 <874nmried6.fsf@dex.adm.naquadah.org> <s5hfw6bpen9.wl%tiwai@suse.de>
 <87vcf7gyl5.fsf@dex.adm.naquadah.org> <s5h6277pdfi.wl%tiwai@suse.de>
 <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <5072E5A7.9040701@canonical.com> <s5htxu5gfy7.wl%tiwai@suse.de>
 <s5hr4p9gf5x.wl%tiwai@suse.de> <87ehl93rap.fsf@dex.adm.naquadah.org>
 <s5hk3v1gdpi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1332229107858763213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E5002625C4
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 18:10:01 +0200 (CEST)
In-Reply-To: <s5hk3v1gdpi.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
 08 Oct 2012 17:56:09 +0200")
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

--===============1332229107858763213==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08 2012, Takashi Iwai wrote:

> No, not about noise but the system beep sound.
> Such like
> 	% echo -en "\a"
> on Linux console.

Oh that. Yes, the volume I hear when echoing a '\a' change correctly
when I change the beep volume in alsamixer.

(On a side note, I don't know how precise it should be, but setting the
beep volume to 0 (but still unmuted) still does an audible beep.)

=2D-=20
Julien Danjou
=2D- Free Software hacker & freelance
=2D- http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQcvqmAAoJEGEbqVCLeKXCR/MQALWJ5vBEMRX3yX0PLMLl9yhZ
sXOUsrjqtvG3FLVrxJGf3hXYsxkTtp6YHYJJ/GCGPVedSbb7HzfXEHXrcI4yjTNL
P3j1Z2hTw+80JGDkjiYLRwnBJMGOe/y0pbSrg2muM3eNixBVjMVavbBQ+fi0sRpy
89nFZcO6c5yUMxWPaOrlNpNbxuJlhAxOOv1XixZqzcK8QSfVQ6wjI0EBn5hwpM+v
uhmSfvckuxjVXliAJNAfPdFMYGdQOqGeU5jeawUtnx1egXOjx0ESDWXEkmJjc9Lv
wwqpd4GWfwTsPfTqrR26lI+ED5bfYmyISI15u1om4HytILck+Pkin6Cl4tLCTrC5
FVAE9iFuAlBRA6ZlSYVicuxgVO5/xYy6IQ1BUwg5M+i6H/D670jO2Oh+23X+n/Df
TUwqKLh1nw254sCSiIPgKP/wyb0p1XaBsAdzCKxPvVNb7QZweohRHyJBI0YWLHlL
AAuBIr0RuYhWhYPonVdRFK4Vk1f1SZPgxyhokrzmqwWNFZKrXGnHaapd8R/WAWnV
TZgoex8aA16daoZz5FLZ3h9MtWtVpa70qw5tqnUv1WyC5a0ULpBskOuNpRGn+fL6
qPUOIg5GOdno0vYs1nGZMTuwS+tEaA7K4HAqxv2ajXGFAVPnzyAjX72pkJGPIink
2dnovaUpHA++KsCqiqkL
=kpfl
-----END PGP SIGNATURE-----
--=-=-=--

--===============1332229107858763213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1332229107858763213==--
