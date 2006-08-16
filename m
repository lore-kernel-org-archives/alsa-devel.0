From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re:
	=?iso-8859-1?q?MCP51_on_Asus_M2NPV-VM_doesn=27t_get_?=
	=?iso-8859-1?q?correct_parameters=09set?=
Date: Wed, 16 Aug 2006 15:51:40 +0200
Message-ID: <200608161551.40736.prakash@punnoor.de>
References: <200608110013.49451.prakash@punnoor.de>
	<200608161404.50502.prakash@punnoor.de>
	<s5hirksyisj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789504953=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirksyisj.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1789504953==
Content-Type: multipart/signed; boundary="nextPart4703198.4pTmoEacOB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4703198.4pTmoEacOB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 16 August 2006 14:19 schrieb Takashi Iwai:
> At Wed, 16 Aug 2006 14:04:50 +0200,
>
> Prakash Punnoor wrote:
> > Am Mittwoch 16 August 2006 13:11 schrieb Takashi Iwai:
> > > position_fix=3D1 is actually a hardware problem.  This could be fixed=
 by
> > > BIOS update (if any)...
> >
> > Thx for the info. But what exactly should I report to Asus?
>
> That the position registers (70h/74h) don't work properly.
> I don't know what values are read there.  You need to try to dump the
> values to check what's going on there.

Well, could you point me how to do it? Im not a kernel dev...

> > And if they don't
> > fix it, wouldn't a quirk be user-friendly? (The kernel also applies
> > various quirk for broken BIOSes...)
>
> Sure, but how could you choose the appropriate option for a certain
> board with a certain BIOS version?  That's the biggest question.

IIRC, this could be done reading DMI (perhaps after checking pci ids), as I=
=20
think for some other quirk in the kernel this was done (or at least=20
proposed).

bye,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart4703198.4pTmoEacOB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE4yLsxU2n/+9+t5gRAnDCAJ9pp0/DF8A1f3HaaX2ekKFJxhbyegCg+DSu
ST4+/2TOQIT1puJ0H5N8MqI=
=Kshh
-----END PGP SIGNATURE-----

--nextPart4703198.4pTmoEacOB--


--===============1789504953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1789504953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1789504953==--
