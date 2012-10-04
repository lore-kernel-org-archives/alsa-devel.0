From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Thu, 04 Oct 2012 15:56:55 +0200
Message-ID: <87r4pepcgo.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7352257924122176113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DEBD26173B
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 10:19:19 +0200 (CEST)
Received: from dex.adm.naquadah.org (unknown
 [IPv6:2a01:e34:ec03:2920:5653:edff:fe1b:bb5f])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mx1.naquadah.org (Postfix) with ESMTPSA id 1A3C45C105
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 10:19:19 +0200 (CEST)
Resent-To: alsa-devel@alsa-project.org
Resent-Message-ID: <878vbhml61.fsf@dex.adm.naquadah.org>
In-Reply-To: <87r4pvgxvx.fsf@dex.adm.naquadah.org> (Julien Danjou's message of
 "Fri, 21 Sep 2012 18:10:26 +0200")
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

--===============7352257924122176113==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Thanks for your help so far! I just spent some time playing with
hda-analyzer, and found something interesting. Excuse me in advance, I
don't really know and understand what I'm talking about, so I'll try to
be the more clear I can.

I managed to make the weird sound disappear in one case: when the
speakers are not muted, which is at least a good start. All I have to
do, it to uncheck the mute buttons of val[8] and val[9] in "Node 0x0b
AUD_MIX" and let their value to 0.
By the way, changing the value of val[8] to something between 1 and 31
makes a different sound. Changing value of val[9] makes not effect

Does that ring a bell to you, or could you translate this to me? :)

Thanks a lot for your time,

Best,
=2D-=20
Julien Danjou
# Free Software hacker & freelance
# http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQbZWnAAoJEGEbqVCLeKXCK58P/A10dV37nZeKMC4eAOEhz9Pf
QhZEc+0ucBIZnca8KMPdDbKodggi20F+/3X9J/O7oydFtVW9ssGg6kj/hImQVI8f
dOfv3sPb6CihuFWwQH5733tZ+LzKkeuwwmZka2tTNT3++1TU0Z0FXjGyRtpp2xgv
Wk2tomYGU9vd1WmdTqA4Fl7ts0gAmYQQpXG4XXWwlXWODR5EhVerY9Tg61rtmTKW
ySQBcGtiLJNPA+dHoGqC6lVAluCjgKD1xsP+QfxC6UxYN+RH5+d9j/bxJFCcZxcf
PhYkZiXuhcchuq5F6TfFIA62IX8i2TDZPJ9HtivMFRVKlaZQgLMHst0dkVZYwBO/
NtsK29f6iRaDWcUhbIrnjyUQDA0Ya9Lbnp0U2lCFsxOr0YoPiftF/JaZTij7ihE5
7/pWV56kOn1MuNBzqpy1S+EliVYFQLREUwvKSUU6e/iHEAaoIVW2XO7MOUkclnbg
HCeaZ/iCRJ2MOhqFChkDpX9549ItEABjGrke0kUIH6VdNBNNhNcsFfSVrK9tucUS
6hstbRpVwp8iosomF5567g63dgQK6eQ/0vtBV79dLWkrsZ7eB0xYxHEfY0M+5FcE
Hx8GaE/mMJUMRgRwJuGcmSVZzUp/0up1evC1AKxfkWp/gWkfYU0Au7bM0X54arQ6
hRg6EOZcxUGdzJlAx72E
=/3ui
-----END PGP SIGNATURE-----
--=-=-=--

--===============7352257924122176113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7352257924122176113==--
