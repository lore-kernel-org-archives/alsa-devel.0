From: Melvin Vermeeren <mail@mel.vin>
Subject: Re: [PATCH] ALSA: dice: add stream format parameters
	for Mytek devices
Date: Tue, 19 Jun 2018 20:23:24 +0200
Message-ID: <2029377.pJKpRF2PWc@melvin-pc>
References: <20632004.ST2tKRhYS0@melvin-pc> <6661723.mKedtcoM4l@melvin-pc>
 <3387264.iPd986TAIQ@melvin-pc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5906739485084647244=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by alsa0.perex.cz (Postfix) with ESMTP id A6D722675EC
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 20:23:29 +0200 (CEST)
In-Reply-To: <3387264.iPd986TAIQ@melvin-pc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5906739485084647244==
Content-Type: multipart/signed; boundary="nextPart5957417.4Cy7At9ihl"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5957417.4Cy7At9ihl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Takashi,

Have you discovered any news regarding the timing issue in DICE or anything 
else from my previous email? I noticed in your recent commit 
1ceb506d631f512f8e5b04821c21104b80c15dee, you referred to an email with 
details from 2016[1], leading me to do some experimenting.

On Thursday, 7 June 2018 16:40:21 CEST Melvin Vermeeren wrote:
> Do you have a suggestion for anything I could try to either resolve the
> issue or how to provide additional information?

I have ported the "old modules" from my initial email[2], which is commit:

2eb65d67afbf9364b525b657f1475d1a2cbc27de
ALSA: dice: expand timeout to wait for Dice notification

to my current kernel, 4.16.12-rt5-1-rt. Then I did a quick hack to correctly 
identify the Mytek's channel mapping for this old driver. I found that both 
PCM and DSD over DoP now work perfectly, though sometimes it misses the lock 
as described in the initial mail. I have been playing back DSD over DoP for 
over 30 minutes so far with zero drop-outs or other issues. This is not 
possible with current DICE.

I must conclude that the packet sequence quirk described in your email is not 
the same issue that impacts the Mytek, since that this quirk exists since 
kernel 3.13 and in my initial email there were no problems with kernel 4.4. 
Though I must admit I do not know where the current problem comes from.

Please let me know if there is anything I can do to further diagnose the 
problem with current DICE.

[1] [alsa-devel] Dice packet sequence quirk and ALSA firewire stack in Linux
4.6 http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107715.html 
[2] [alsa-devel] DICE Stereo-192-DSD-DAC issues since 2016-02-08 / kernel >= 
~4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/
125524.html

Thank you,

Melvin Vermeeren.
--nextPart5957417.4Cy7At9ihl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETnzUjuV5O+rCrz6nRiwQnTrHuFkFAlspShwACgkQRiwQnTrH
uFkbsw//aynXgPCCcakZZRsM87aXSUSRJB1h/rT5uqeAL06tFSUPmkg233R5XY42
cLWxL5l0y9HrVId/pw46HtqofPCtlhTsKR+6lEFqtM+GuHVN2EDrv/MbThUTtG0L
yS2iG8C/DBYR1HHe0xdZ5Ofen23tjxbQdbW+Ig7lr6q4wScZhnfQrkrLwoYBEJJb
6xjlgWvp3DT3oOe2yRDGWbHMsFwzKcqGfIstOiu0krpjaoixMDQK/n5SiZL8OMnw
g2V1pCMQZ8o+/HlWJa0lDB1I0mtcNy4bio/c62zwdvcaNI3nXCm+2LU5nL2Jj5+j
CNl9ETBRHcubQmQ54PKW89xafHZ7y8ySSGQBjt1TZbxYNkxx6Nk7TlmOgM+rSUX5
Z7L6IVKgtYhqb8abY6U7ZChMtilxSDB/laSyrANC3pxqzbIa2JOUJihzRRLw7jfz
qP+77mXohsbr+7T6E6/rrLp5UXYbQIQw7MV/cPHPGT4aWCctRY42ChUqRhwLcq0H
8PmOPjPIc6jYG2Jf8YsxH/3ijephGmoiWkjZHcMdud/OTRTSpdaCy+6sJVO+KXWY
WTA1eFP+U/IQ1icCJCIzho80UBZDHXqEcyuvB9tE1kJEoTDjpBS1/BSjl8gF79Cy
C41h9pcleS3FI9dMuq1402xuN6r25q5czIkxeqg/IkXPYT8iKfw=
=U+k2
-----END PGP SIGNATURE-----

--nextPart5957417.4Cy7At9ihl--




--===============5906739485084647244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5906739485084647244==--
