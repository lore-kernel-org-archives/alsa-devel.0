From: Melvin Vermeeren <mail@mel.vin>
Subject: Re: [PATCH] ALSA: dice: add stream format parameters
	for Mytek devices
Date: Thu, 07 Jun 2018 16:40:21 +0200
Message-ID: <3387264.iPd986TAIQ@melvin-pc>
References: <20632004.ST2tKRhYS0@melvin-pc>
 <1cef1eca-3a06-e05e-765f-dfe984091085@sakamocchi.jp>
 <6661723.mKedtcoM4l@melvin-pc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5485488493875609642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B202670BE
 for <alsa-devel@alsa-project.org>; Thu,  7 Jun 2018 16:40:25 +0200 (CEST)
In-Reply-To: <6661723.mKedtcoM4l@melvin-pc>
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

--===============5485488493875609642==
Content-Type: multipart/signed; boundary="nextPart9498945.GlybBugrUk"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9498945.GlybBugrUk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Over the past weeks I have had some time to do some more research and hacking. 
Thank you for the supplied un-upstreamed documents. Mytek has also been very 
helpful providing some details about the unit. It appears that the assumptions 
so far are largely invalid and there is almost no work to be done on ALSA Dice 
driver.

Although this is good news, I have unfortunately also discovered a problem.

On Monday, 21 May 2018 17:09:37 CEST Melvin Vermeeren wrote:
> On Saturday, 19 May 2018 10:23:30 CEST Takashi Sakamoto wrote:
> > In my opinion, it's hard to achieve it with quick hack to the engine
> > and ALSA Dice driver. Especially for your case, one data block for
> > outgoing packet to target device should include two kind data; PCM
> > and PDM samples. I can see output from '/proc/asound/DSD/dice' in
> > your previous message[8] includes below:
> > 
> > ```
> > 
> > rx 0:
> >    iso channel: 1
> >    sequence start: 0
> >    audio channels: 4
> >    midi ports: 0
> >    names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
> >    ac3 caps: 00000000
> > 
> > ```
> > 
> > If the 'ANALOG L/R' represent data channels for two PCM samples
> > and the 'DSD1281/2' represent data channels for two PDM samples,
> > I can assume that one data block includes two kind of samples,
> > thus two data streams of PCM/PDM samples should be multiplexed into
> > one data stream of IEC 61883-1/6 packets.
>
> Also, I am not yet sure whether this specific DAC supports DoP over IEEE
> 1394. Possibly there is another format in use for PDM playback over IEEE
> 1394. Expect more details on this within the next few days.

It turns out the Mytek Stereo-192-DSD-DAC only supports PDM samples over PCM 
with DoP standard[1]. DoP uses 24-bit PCM frames at 176.4kHz sampling 
frequency to transmit PDM samples.

The "DSD128" channels to my DAC are for DSD128 DoP mode using the method as 
described in 3.2. in the standard. Because this unit does not support 352.8kHz 
four PCM channels are used in 176.4Khz rate to effectively transmit DSD128.

This means the ALSA Dice driver can remain as is, since DoP standard is used 
from userspace applications like MusicPlayerDaemon (MPD). I got DSD64 DoP 
working by hacking the channel mappings. For proper DSD128 DoP with four 
channels some changes are needed in MPD, I'll contact their mailing list soon.

The above proposition might still be needed in the future if we encounter IEEE 
1394 hardware that only supports native PDM formats.

I will submit another patch soon to possibly add support for Mytek Manhattan 
DAC and to correct and update some comments in the dice-mytek.c file.

----

Unfortunately, I have confirmed the existence of some sort of timing or 
transmission issue to the unit. This did not happen when I ran the "old" 
modules out-of-tree for over a year, as described in the initial mail[2]. In 
this mail I also noticed the popping issue.

It comes down to that the transmission is somehow not bit-perfect. In PCM mode 
this causes subtle cracking and popping, which is a lot more notable on higher 
frequencies. The higher the sampling frequency, the more rapid the popping 
sounds become. The PCM stream never fully drops out, sounds do always keep 
playing.

In DSD (DoP) mode this causes complete drop-out of the signal for ~0.2-1.0 
seconds since the DAC leaves DoP mode when the DoP markers are missing. This 
happens consistently every 2 seconds or so. The 2 seconds it does play DSD64 
it does work properly without any artefacts in the produced analog signal. The 
display on DAC keeps saying "dsd DoP" during the dropout.

Currently my kernel is 4.16.12-rt5. I also built 4.17.0-rc2-sound+ from 
Tiwai's repo today, which is commit 3248e54292f93e1bf7b9ff084918d79dd6f655f8. 
The problem is exactly the same in both and was also the same on any kernel I 
used since I switched to the "new" modules.

It should be noted the number of errors is variable. In the best case it is as 
described above. In other cases the number of problematic packets is so high 
the DAC cannot switch into DSD DoP mode at all, staying permanently silent 
while the display flickers between "dsd DoP" and "176.4 PCM" rapidly. For PCM 
streams the number and intensity of cracks and pops increase substantially.

Based upon the above, I think it is likely to be a timing issue. Not sure if 
it occurs during packet transmission or if something goes wrong when starting 
the streams, when the DAC "locks" to the packets.

Do you have a suggestion for anything I could try to either resolve the issue 
or how to provide additional information?

[1] http://dsd-guide.com/sites/default/files/white-papers/
DoP_openStandard_1v1.pdf
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/
125524.html

Regards,

Melvin Vermeeren
--nextPart9498945.GlybBugrUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETnzUjuV5O+rCrz6nRiwQnTrHuFkFAlsZQ9UACgkQRiwQnTrH
uFmL9w/+NHIO45QFPFXSIjsPmWwGnknqFxRG/G8q977VF5Jv/QlhW9p1bHRg5AMR
sKE2CqPESwxnYDve/qn0xg32qYX4nub+L3i+GkZGpwCLwWJWxJlQiAP+CrZOPf9M
DGl3B/owh2TkGOx61bTbkLIfYi5cHTO/KTWt1T63aMsloQiEHkGE4sInBk+yLJlk
vI1nLSghsytfRqqfGdQ8w/VYgKaoUyFRlwk6ShGrm4Mu1uTx8bMxRssjUfnfO6SJ
9G74JySGQ+tMQRNPaTAmJCgVeHuTvRsRcB0eWdGUUKZS4wCuyJiIApDvRco9dmYk
uzwVwvL8bU6+VR7liF8fHcE1H1K2c/cGhQOEvot8CxPIr2pENHZI2awpyC9LFrjK
eZ9xx2qXFc5iFYuALwxnPMOM8EZ9EmJiaG1A6q8IKjinuiUq75j/1BFuCfCatY0w
1llGLwcACaa7H2Tr3Z4oatnzW5sRo9X1rloDIDXCKnXdFJp5zt/NgN/OwjrmAZMr
nRXQ0e7+YxK+F52YMAArpruZUqlxw2XCbccr8ZFNG2kZV8sicmrPaK/Gf0e4e4Bs
V4vgOIxIjcvv3udKiflk52HFSuEBykSvCaapkMKS19gEkAR3g9NMIVC7OFEt28hu
pyc4Cd+VJGVjJ00gJyc5ZcGIrDiMg2DxCMC5+xNRCJouafXxYnY=
=hvjc
-----END PGP SIGNATURE-----

--nextPart9498945.GlybBugrUk--




--===============5485488493875609642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5485488493875609642==--
