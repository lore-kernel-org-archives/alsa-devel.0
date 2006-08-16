From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re:
	=?iso-8859-1?q?MCP51_on_Asus_M2NPV-VM_doesn=27t_get_?=
	=?iso-8859-1?q?correct_parameters=09set?=
Date: Wed, 16 Aug 2006 14:04:50 +0200
Message-ID: <200608161404.50502.prakash@punnoor.de>
References: <200608110013.49451.prakash@punnoor.de>
	<s5hmza5x7ea.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0762959776=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmza5x7ea.wl%tiwai@suse.de>
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

--===============0762959776==
Content-Type: multipart/signed; boundary="nextPart1228077.eS4s5rU9zN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1228077.eS4s5rU9zN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 16 August 2006 13:11 schrieb Takashi Iwai:
> At Fri, 11 Aug 2006 00:13:46 +0200,
>
> Prakash Punnoor wrote:
> > Hi,
> >
> > using snd-hda-intel I get a high pitched sound (and changing vol leads =
to
> > muted sounds) if I don't set position_fix=3D1. I have to recheck whethe=
r I
> > need model=3D3stack set or whether alsa puts it correctly. I am on x86_=
64
> > using linux-2.6.18-rc4.
>
> The model=3D3stack was already fixed in ALSA HG tree but it's not
> included in 2.6.18rc.
>
> position_fix=3D1 is actually a hardware problem.  This could be fixed by
> BIOS update (if any)...

Thx for the info. But what exactly should I report to Asus? And if they don=
't=20
fix it, wouldn't a quirk be user-friendly? (The kernel also applies various=
=20
quirk for broken BIOSes...)

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1228077.eS4s5rU9zN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE4wnixU2n/+9+t5gRAms/AKCs/d6eObJgRlSbaSILKv29uWsR0QCfVLNZ
pQhjqZPVOyWspr+AAcK/U2Q=
=gXAv
-----END PGP SIGNATURE-----

--nextPart1228077.eS4s5rU9zN--


--===============0762959776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0762959776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0762959776==--
