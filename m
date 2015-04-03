From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: linux-next - strange audio bug
Date: Thu, 02 Apr 2015 20:34:35 -0400
Message-ID: <57781.1428021275@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2683844850053072839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr1.cc.vt.edu (unknown [198.82.215.225])
 by alsa0.perex.cz (Postfix) with ESMTP id EC2B5265777
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2015 02:34:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--===============2683844850053072839==
Content-Type: multipart/signed; boundary="==_Exmh_1428021275_2118P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1428021275_2118P
Content-Type: text/plain; charset=us-ascii

Next-20150310 works OK, next-20150324 has the bug.

Dell Latitude E6530 laptop, lspci tells me:

01:00.1 Audio device: NVIDIA Corporation GF108 High Definition Audio Controller (rev a1)
        Subsystem: Dell Device 0535
        ...
        Kernel driver in use: snd_hda_intel

Symptoms:  Audio works perfectly at boot, and for some amount
of time after.  But somewhere around 6-8 hours of uptime, it gets
into a strange state where I'll get no audio... and then it will
cut in for all of 2 seconds or so (fairly consistent, that part),
and then cut back out for anywhere from 10 seconds to a minute,
then another 2 seconds of sound.. lather rinse repeat.

Before I start the thankless task of bisecting this (which means I'll
be able to do only 1, *maybe* 2 steps a day), does this ring any bells?

--==_Exmh_1428021275_2118P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVR3gGwdmEQWDXROgAQISYg//fArsUhXiY+hWW8vKUVkNbDwBxeqByXXU
3QUY/dvIEAERrg0o4CO8kwmgFlb93erRn7oXMzHnqRQtoai/xABSWUVY8QB6RcXd
Ez7wgE7qyHxu3TjTyoESlyDJkkAiqbczzyEMhJ1c85CWFHEbUifScNnGO3g58uPh
E7jk7rznaHEXeszmaETYfx8QNQhAQC3WP+LrunYANSw17QA1/I23xMQpmchAnlcH
En6nT5Eoj1nWRccQmI1okeu6pQpJH/v76QamhrerFPchKG0BuK+GhzREkpMCuZ20
QQlkRbXxaytfQaq3CLRmQFrhWrsJi4Fskdwhv7MzWID5bcnjxOP+TssmwjhGn0F9
KmRvHND4AqB94O+qdnYyYdHeKzksCKoU4292GOgoWzjpB3vxZ9lbOuGka1aKxdQ7
/w9XBQlA0pln9o3ne8bDPIrsDrcvmlKbCDId7ablklOTgEp73NMRJlIEfuASGb9T
ghDmFVBqqcX3JWGh3Zgp6HtIOAvcbC4tpLEAorgMDn7b4vN+AKCyOfRIAv5Q9Cxn
ZVkvETo+KqWU3keR8Y18aqub+Jo0DAlCa/agQeO0a2JOgdHA6MRY8x6KplGxP4V0
q2SDYKhT2eEVzqPV044TXso7Cb2iqaqTbg+N9uwhXzpvoDNNv1q1MJ08WnXSHMnr
aLYteQJYTvo=
=cBB8
-----END PGP SIGNATURE-----

--==_Exmh_1428021275_2118P--

--===============2683844850053072839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2683844850053072839==--
