From: Baptiste Jonglez <baptiste@bitsofnetworks.org>
Subject: Assertion failure in alsa-lib crashing applications
 (snd_pcm_area_copy: Assertion `dst < src || dst >= src + bytes' failed)
Date: Tue, 7 Jun 2016 19:29:35 +0200
Message-ID: <20160607172935.GC25444@lud.polynome.dn42>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6312985690347871751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mails.bitsofnetworks.org (rezine.polyno.me [193.33.56.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 111F72605F1
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 19:29:38 +0200 (CEST)
Received: from rev-140-155.legacytubes.illyse.net ([89.234.140.155]
 helo=lud.polynome.dn42) by mails.bitsofnetworks.org with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.84_2)
 (envelope-from <baptiste@bitsofnetworks.org>) id 1bAKor-0007Ho-AZ
 for alsa-devel@alsa-project.org; Tue, 07 Jun 2016 19:29:37 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6312985690347871751==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When using Ring [1], an audio-video application, it sometimes crashes
because of an assertion in libasound.so:

    pcm.c:2758: snd_pcm_area_copy: Assertion `dst < src || dst >= src + bytes' failed.

The complete upstream bug report is at [2].  The (not-so-useful) stack
trace is the following:

#0  0x00007fc356e462a8 raise (libc.so.6)
#1  0x00007fc356e4772a abort (libc.so.6)
#2  0x00007fc356e3f1b7 __assert_fail_base (libc.so.6)
#3  0x00007fc356e3f262 __assert_fail (libc.so.6)
#4  0x00007fc35ba65c84 snd_pcm_area_copy (libasound.so.2)
#5  0x00007fc35ba65ebc snd_pcm_areas_copy (libasound.so.2)
#6  0x00007fc35baa6d95 n/a (libasound.so.2)
#7  0x00007fc35ba77c1f n/a (libasound.so.2)
#8  0x00007fc35ba77a59 n/a (libasound.so.2)
#9  0x000000000051ba97 n/a (dring)
#10 0x000000000051c118 n/a (dring)
#11 0x000000000051cfad n/a (dring)
#12 0x00007fc357787c40 execute_native_thread_routine (libstdc++.so.6)
#13 0x00007fc359ec2424 start_thread (libpthread.so.0)
#14 0x00007fc356efacbd __clone (libc.so.6)

The next time it crashes, I will have debug symbols in dring.  I can also
recompile alsa-lib with debug symbols, what is the best way to do that?

Looking around, it seems other projects have run into the same issue:

    https://aur.archlinux.org/packages/ultrastardx-git/?comments=all#comment-435458
    https://aur.archlinux.org/packages/zoom/#comment-544696
    http://ubuntuforums.org/showthread.php?t=2248373
    https://github.com/js-platform/node-webrtc/issues/110
    https://fedorahosted.org/fldigi/ticket/70

The output of the alsa-info.sh script on my system is at [3].
What else can I provide to debug this issue further?

Thanks,
Baptiste

[1] https://ring.cx
[2] https://tuleap.ring.cx/plugins/tracker/?aid=502
[3] http://www.alsa-project.org/db/?f=0dd2ba1021b3d535f30f07c55dc18e2ef60db26d

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVwR6AAoJEL4B7CKgTi5GVHwP/j3hRfmbSG7/ZFA5mYEX1akI
QaoL0d2sVK94bggYUwQ9YDzK+WEBUE1eRkVz7AkZuCv24DYvGGUWkzb1hM1FO/GX
HIVy4s0B5oWL0C3XZ2LHTDT8DX7hEA/mi7DNy4GbHribYSwNGbACimquigXdBBof
IFcor/3Nh1Ch6dq7FGEkMLfIPUpggjnXBP3UhEdsHDjjF4+X7Mdoi4YD5CIpVzVX
6rcE5Yt2HtDms75nG1pkNBbesqD982eZvUd15iCn2WcXWUZKawEhx1jGglvn+U/G
RwT/hl6fEs5M+mpw+O/ZVqySz9GM5oyHket+KLMUEYBZa/Y8nGYVLRApwffoEWTv
pSA4J0l1NN/NenwsFKUMl4WyMAtF4BecPWQzAQyrLerMhafJQRdYYIuq4t6Tpa1Z
GuF0yZ25IQjAJNLjiFRJtcsi+NImFyl9LLDXWTzl7w2zVENOlABCzaZd0jR7yz3e
UvgPjkPz6hLvi9xfgg76iXnJLTC7oGpin3gZWlqPsxNqNfASvdvKgfaC/rLnFEyQ
pWPXzR9nJ4DyMSeIaSJe8atHd1v5Pz2GGO5QWRGU9KciizVRrTvcuP+VPnbFziFC
QhTEAb7zdO3zfmuOB7KOBoi8FXZFSVoxHW3MdsKieCUBc8FD7OgEip21KNUs6pgF
1fX4hTOv2A2j0Q3QuB8V
=K/Lg
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

--===============6312985690347871751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6312985690347871751==--
