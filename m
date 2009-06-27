From: Andreas Nuesslein <nutz@unfoog.de>
Subject: No sound with nVidia Corporation MCP79 High Definition
 Audio (rev b1) (Macbook Pro 5, 5)
Date: Sat, 27 Jun 2009 03:16:54 +0200
Message-ID: <20090627031654.22d8f25b@honshu.wg15>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1043307246665209761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 357E8243D2
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 03:16:47 +0200 (CEST)
Received: from honshu.wg15 (port-87-234-90-241.dynamic.qsc.de [87.234.90.241])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx.unfoog.de (Postfix) with ESMTPSA id B4B253AF298
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 03:16:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1043307246665209761==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zPA=wVZqsM2Ia9zV9GVB==N"; protocol="application/pgp-signature"

--Sig_/zPA=wVZqsM2Ia9zV9GVB==N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I just got a macbookpro (mid2009 version) with a new nvidia chipset.

there is no sound at all. neither via the built-in speakers nor via
out-jack.

i tried aplay -D myfile.wav with everything from aplay -L  as well.

i also tried a recent snapshot (alsa-driver-20090626.tar.bz2) as well
as gentoo ebuilds alsa-headers-9999 and alsa-driver-9999 (which uses
git to pull recent versions).

so here's a little information i can gather:

$ lspci -s 00:08.0 -v
00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio
(rev b1) Subsystem: nVidia Corporation Device cb79
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
        Memory at d3480000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel


alsa-info:
http://www.alsa-project.org/db/?f=3D80e89b82fec184b68a88b9ed4128544a276775fc

modinfo snd-hda-intel:
http://www.nopaste.com/p/a3B7miINP

i also found a thread about that problem (w/o solution obviously):

http://www.uluga.ubuntuforums.org/showthread.php?t=3D1188849&page=3D2


hope that's all information necessary.

if i can i'd love to help in some way.

thanks

--Sig_/zPA=wVZqsM2Ia9zV9GVB==N
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkpFcwYACgkQGIPRDsWq365fdgCfYnHqqEzx0ttqSbDnwiBQ4Dny
aWAAn2sxDW3Ct2BjIUsIKUv4l8tXgEgc
=bSXM
-----END PGP SIGNATURE-----

--Sig_/zPA=wVZqsM2Ia9zV9GVB==N--

--===============1043307246665209761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1043307246665209761==--
