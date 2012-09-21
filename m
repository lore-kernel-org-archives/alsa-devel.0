From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Fri, 21 Sep 2012 18:10:26 +0200
Message-ID: <87r4pvgxvx.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0260453206436641635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 24032265DC6
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 18:11:04 +0200 (CEST)
In-Reply-To: <s5h6277pdfi.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
 21 Sep 2012 18:07:29 +0200")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0260453206436641635==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21 2012, Takashi Iwai wrote:

> One last thing I'd try is to disable the analog loopback path
>
>     hda-verb /dev/snd/hwC0D0 0x0d SET_AMP 0x7180

Woh, that does something! The noise is now different, it's a lot more
"piercing". It was shhhhhhht now it's hiiiiiiiiiii.

=2D-=20
Julien Danjou
;; Free Software hacker & freelance
;; http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXJFyAAoJEGEbqVCLeKXCIQsP/3FTm3pxQ8MShvAWpUNfsnj5
qpjck2vusAm+ey50KnjrjrEc5CWsCJfhIr3p88DBv6dMSLhGJNFoPVJZQmGL8iFD
Y+zPiIc/3KJCk4W4tqi0fVDFuZ4wNOc4Uvg2fKZU2h4yoIsDfltWYHCAtU2q7GHm
ns6KXj9mU9USTziqCQ30GnIiXXB7oT5yz/Q5fI+lDRmLOg6Uaf9/ZtxBzKdTbnEC
AwX/wYzszG38stUkCgQ047WZm6uwmaT0N6cdM2KanyuLzaMojL6dZCxYYzH8lbeM
Drqt4fZc0wS5pzGS6YyqXN63/gGa8V71Q0VB7/46s4TuOA3e6ZRCA5sodnXqJdv4
H1c+yw8tcWGhD2Zcs0VP5StIhWkqKR0HglQQkRO0yfbfXOkLieAEp2wTzpFN4VYZ
Cp0lwtwkscKtZp/1lQ3pvM0rKzcJbud5sM+I/VjomfXtSe3dCbS8HWwEPf07gJkA
Ue6RnAdLpRU05AipHrkqK2Ao8pq4pJInOSyjhL7oiIr5tCZzmr06v+kaTb3w4LqU
Y1Ho1m9jN807sh2j8mW8svc9qB5jbtn/2J34V6pgTmjVi56VV2yFyiYvsFcRg9ZN
D4uY3AEf6kE4MWBCW5TwR2MyExZ4IrSNK5/hd4g0gDqTD4eyTTQ1SAm9DImnVfgO
Vb23CgbRaEp7aRqyNTf7
=13N0
-----END PGP SIGNATURE-----
--=-=-=--

--===============0260453206436641635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0260453206436641635==--
