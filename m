From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Thu, 02 Nov 2006 23:59:54 +0100
Message-ID: <1162508394.3381.4.camel@johannes.berg>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162456168.3241.2.camel@ux156>
	<17738.26872.275355.217147@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0010218991=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1AE62C3
	for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2006 00:01:35 +0100 (MET)
In-Reply-To: <17738.26872.275355.217147@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mackerras <paulus@samba.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org


--===============0010218991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+ufBX2XQFZWl99govrE/"


--=-+ufBX2XQFZWl99govrE/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-03 at 08:54 +1100, Paul Mackerras wrote:

> True.  Can the trigger function sleep in the suspend case? =20

No idea. Takashi?

> And
> presumably the resume trigger should only restart the DMA if it was
> running when the suspend trigger was called, but how does it know
> that?

Well, I assume that if it's not playing the pcm trigger will neither be
called during suspend nor during resume, since the actual device suspend
is later, this is only the pcm suspend. Actually, could the device
suspend sleep and wait? Then we could play a sound during suspend if we
somehow manage to make the audio device suspend last, and the pcm
first :)

johannes

--=-+ufBX2XQFZWl99govrE/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARUp4aaVg1VMiehFYAQL2iBAAlRRFvatKrxatJXP28J9dGMUj5x9mMKY8
g/CA4VJ/W2zqKSgXwL+UUCj9GK5fWfrY1JBAUvOuDngzdmgaH2/TY8pjIKr+ZQlH
Djm4lWh/Qoe/vDlJv1QCDVj51pVMWILiOU0W4f0OB3YJED4HS72onJBm2YIRB+G9
IpMgusCdYF3VsKQoG6jik/f1cMytcITNxihXro47fAPzfcBtepPPjifU1wWXePjF
tEmmZviNbrZZ3jGoSOxQ0oA5/lOsf3WpgplUbURjuTarHV8dbT/7G3pRmdGZrKWM
FoPFbGbiRmIyW3/+0vrkuvFsib2wxzuseZ70uuRQ6J0kFzhckThwId9UNfVOTGNP
Yp0v6yVxKKyykLFzI0qarn0n86nlQB2CqfEto+Yyk1f0enxChRqUWd3Okd+L1oys
jfMKOt5fkQYfMA4CgkkWBY9Il3KVNgF2pXwSk4qsGauhgZy6WcAn2ByxChga+Jzn
dgzFpZHe9Kh49px+VPoWvYaJGvxJcOIZgTlnd+8HI9h3iuVsTdP67CAB7obv4EpE
IwOx45glv7dCF6zCfhRb9nx6/4SiA9UTQSbnNHOHj35CjCV/lmnlFrnXC5gQ3IZI
c9lhA3dSI/0k+xoxjQEhBIJdKmte+UW3WV4+0PfV0OHNaoKnnk9AjJbxiRrfcewS
uabVMBo6EhI=
=1lV0
-----END PGP SIGNATURE-----

--=-+ufBX2XQFZWl99govrE/--



--===============0010218991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0010218991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0010218991==--
