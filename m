From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 18:24:23 +0200
Message-ID: <87ehl96ifc.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2052773727834296735=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B642E2625E7
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 18:25:14 +0200 (CEST)
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

--===============2052773727834296735==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08 2012, Takashi Iwai wrote:

> OK, then could you try the patch below?

The patch is not enough on itself, but it seems on a good track. As soon
as the module is started, the noise starts for one second and stops.

The "Beep Playback Switch" is shown as muted in alsamixer. If I unmute
it, well, no noise, as expected. If i re-mute it, the noise come back.

So this patch just works after module loading, but I guess that's to be
expected if I understand the code correctly. :)

=2D-=20
Julien Danjou
// Free Software hacker & freelance
// http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQcv43AAoJEGEbqVCLeKXCGskQAKPi52aUYen5kZHRI0rPyXb6
8uwntDWUHVlpm5nWIl4axfaRub8Xo1/ISLuDkKVnKiPzpNY4mEcBUS+aMRRy2vOg
GB5npk3mH0NLhm7Roi/moVn22R58GnYUVDVyQqt/Fn3f/IaxESpjsFdQWZ8aLpps
2wRdo9BDVtLEjxH1CysVl4MKUZ5VAu4UkV3tblMuYk9w/IDHpvPWM4ICDJkHcrmt
7VvW3qEpu7uj8oat5PhYWk0xSe6g45n9U89biLT0W2hpavLN304fRdLDoEL0OQQG
JyxXQ6TSr/1aKZWDL+972Gru8f61cQgxMr/iAVIk0ZbrfeKu0TM/bF/Jfu1nn5S/
iLB7whv9EblHAd0nAcM2R8x9hH21+gbFcC/Y6tbrY/qhKapEAh7eqiTTXJrIHVAH
GJYkw0HgfsOeKK5gYUTzPIgR41wEL1lwGzRTEP8KuMCblR4qsNgphpeT8/whdj15
5Czcez1NXs89+DyDL7jWw35252H7xHJ0ScBoKR0Mzb+ZtQuU7CQQtLhzjuL6G1UL
IGjGvm3LTIF24i16XQYbpE9n1cKuWJpTxiWltDXyhM7LRjgk+sb4TWV26yOFrQPM
boV7qtc5Nmj/eE5nUCx7gF/LJvO2RIJyLOXBwbhim3kC9Pa7Fd8QnKO++90Lk8tk
HF9KRlWL2OuhtH6KXIdZ
=Z8cF
-----END PGP SIGNATURE-----
--=-=-=--

--===============2052773727834296735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2052773727834296735==--
