From: Alexander Schlarb <alexander-alsa@xmine128.tk>
Subject: C-Media USB Audio Device (0d8c:000c) volume scale
Date: Sun, 13 Jul 2014 19:47:36 +0200
Message-ID: <1651150.0tgDBQbzXi@alexander-nb.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3722469258029474773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xmine128.tk (vsrv77162.customer.xenway.de [95.129.55.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A60C2610A3
 for <Alsa-devel@alsa-project.org>; Sun, 13 Jul 2014 19:47:09 +0200 (CEST)
Received: from alexander-nb.home (178-191-77-243.adsl.highway.telekom.at
 [178.191.77.243])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: shardragon)
 by xmine128.tk (Postfix) with ESMTPSA id 9771F284CF
 for <Alsa-devel@alsa-project.org>; Sun, 13 Jul 2014 19:47:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3722469258029474773==
Content-Type: multipart/signed; boundary="nextPart3842385.FI5ue7drts"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3842385.FI5ue7drts
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi everybody!

I've just opened what I think is a bug at GitHub[1] and have been told to send 
it to this list instead.

System configuration:
 - http://www.alsa-project.org/db/?f=fb914e7a6b8d91993b00d61c94c885e8d2ede527
 - https://github.com/opensrc/alsa/issues/4 (some additional PulseAudio stuff)

My problem:
I have a DeLock USB audio device with an C-Media audio chip. When changing the 
volume in alsamixer there is no problem, but when changing the volume through 
any PulseAudio frontend (in my case either pavucontrol or veromix-plasmoid), 
all volumes below 30% in the GUI are shown as 0% in alsamixer and no sound is 
played.
The PulseAudio wiki[2] blames this on ALSA for exporting incorrect dB 
information. However there is a StackExchange answer[3] which suggests adding 
the parameter ignore_dB=1 in /etc/pulse/default.pa which fixed the issue, so 
I'm not sure if this is indeed ALSAs fault?

Please tell me if this can be fixed in ALSA or if this might be a PulseAudio 
bug...

With best regards,
Alexander Schlarb

[1] https://github.com/opensrc/alsa/issues/4
[2] 
http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/PulseAudioStoleMyVolumes/#butthisisevilmypcmcontrolisalwayssetto100thisway
[3] http://askubuntu.com/questions/15069/how-do-i-change-the-way-ubuntu-adjusts-my-volume-mixer-levels
--nextPart3842385.FI5ue7drts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlPCxj4ACgkQMlhAbB09kImJeACfZ0twcRPEjG4s91PpEgRF5DEy
a04AoIlikAbOtxz6gGAxpojf7sKi7x8k
=WjMU
-----END PGP SIGNATURE-----

--nextPart3842385.FI5ue7drts--


--===============3722469258029474773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3722469258029474773==--
