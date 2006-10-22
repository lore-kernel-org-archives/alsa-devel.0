From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to
	off
Date: Sun, 22 Oct 2006 22:29:13 +0200
Message-ID: <200610222229.16927.prakash@punnoor.de>
References: <200610050938.10997.prakash@punnoor.de>
	<s5h64eh5yzx.wl%tiwai@suse.de> <s5h3b9l5ykv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2097824560=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15DC5174
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Oct 2006 22:28:57 +0200 (MEST)
In-Reply-To: <s5h3b9l5ykv.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com, perex@suse.cz, Stephen Hemminger <shemminger@osdl.org>
List-Id: alsa-devel@alsa-project.org

--===============2097824560==
Content-Type: multipart/signed; boundary="nextPart1173569.TBC4RBGXb1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1173569.TBC4RBGXb1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 18 Oktober 2006 19:21 schrieb Takashi Iwai:

> > Yes, it would be better to check the value and reset chip->msi if
> > not successful.  But it's not a fatal error, so the current code
> > should work.
>
> The below is the revised patch.

I tried it and it works fine for me now (with the driver not using msi=20
automatically now).

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1173569.TBC4RBGXb1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFO9ScxU2n/+9+t5gRAht5AJ0UIWGeVlvwZ7GUY0NVshGQYoM/xgCeLyav
Pmnn44/yLpCz3Hrxee91CsM=
=i6rR
-----END PGP SIGNATURE-----

--nextPart1173569.TBC4RBGXb1--


--===============2097824560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2097824560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2097824560==--
