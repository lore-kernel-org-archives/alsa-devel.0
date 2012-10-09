From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Tue, 09 Oct 2012 10:39:06 +0200
Message-ID: <87bogct4yd.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <87d31fii3v.fsf@dex.adm.naquadah.org> <s5hmx0ja08z.wl%tiwai@suse.de>
 <874nmried6.fsf@dex.adm.naquadah.org> <s5hfw6bpen9.wl%tiwai@suse.de>
 <87vcf7gyl5.fsf@dex.adm.naquadah.org> <s5h6277pdfi.wl%tiwai@suse.de>
 <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <87ehl96ifc.fsf@dex.adm.naquadah.org> <s5h7gr1gc7o.wl%tiwai@suse.de>
 <87ehl86h4l.fsf@dex.adm.naquadah.org> <s5hvcek7oh7.wl%tiwai@suse.de>
 <87zk3wity4.fsf@dex.adm.naquadah.org> <5073C20C.2080603@canonical.com>
 <s5hk3v06tet.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3942483188106953436=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE8D262636
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 10:39:59 +0200 (CEST)
In-Reply-To: <s5hk3v06tet.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
 09 Oct 2012 08:39:22 +0200")
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

--===============3942483188106953436==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09 2012, Takashi Iwai wrote:

> Your suggestion reminds me of another bug on another Vaio Z model but
> with a different codec.  On that machine, the speaker output must come
> from the first DAC.  Otherwise silences.  Julien's machine might have
> a similar restriction.
>
> The patch below will change the DAC assignment order.  Give it a try
> instead of previous ones.

Unfortunately, this doesn't help at all: with that patch I've a bunch of
different noises following what I mute/unmute. And muting/unmuting the
"Beep" toggles a different noise, but I cannot find the silence back. :(

=2D-=20
Julien Danjou
/* Free Software hacker & freelance
   http://julien.danjou.info */

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQc+KqAAoJEGEbqVCLeKXC6S4P/1cBrBzk/KWRbP0zo4OaibJK
m/XyCWx8s/AyX13mbhmHcLIdijenXkpojFMziKh3DfTZne+Nr+j5eGnYetBMVzO+
wGTLMXSXSPi3yXvDm5f+uHFgqyHt7bjMKmBiAb0/26gBc+P6kwBSDachvB94kfqQ
QiYlUu9GjTFnMWExAZ5fO5wINYTCm94pSbUi0UHHvA/zOESY780/umhT7ikdS84k
C0W2EeVKhwiDw/3CUFjvcVdkFetSIPlYk3K773WNd4pCrjBttUVyuE3xo5mO0b6T
jwgkSEWoGko7cLpZh6urOOOX947bysL4PnMEjjp1dmZM84WBcm8BG9SC2jAJsn96
oiMGZCpXLW3it+slVsg/PqaojkrKI43GoB2qj8raW7Oj5jw3l60wBqIjH1Ce/MOM
o6CpO5P8I4ZXOpfuwWCJLjjmZidf7rBopnsmkheH67k1hD0CRavvuxdwnoPFJq4T
hfH7o37eWg7UIdeV9kyUgyMjmg87XiQXl1m9jknJWkEdiOf9ds+xVc2MaAOwr1VN
XRrdgMcVOpqLWH3vemRE5d+JbCMFZLKvLOfYvIJZSjz8qh5VeR5VRmNm8PvZ07Xi
Ojb5Tw/3ZHGrjD/PYZ/69wRuUqLsYb6UO+W5THJR36wbXnl9skvaV4GATtb7EEgf
oMM9UwXMsYdAdBsWyByb
=sgMl
-----END PGP SIGNATURE-----
--=-=-=--

--===============3942483188106953436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3942483188106953436==--
