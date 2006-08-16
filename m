From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re:
	=?iso-8859-1?q?MCP51_on_Asus_M2NPV-VM_doesn=27t_get_?=
	=?iso-8859-1?q?correct_parameters=09set?=
Date: Wed, 16 Aug 2006 18:25:16 +0200
Message-ID: <200608161825.19898.prakash@punnoor.de>
References: <200608110013.49451.prakash@punnoor.de>
	<200608161551.40736.prakash@punnoor.de>
	<s5hzme4wzu5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537146912=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzme4wzu5.wl%tiwai@suse.de>
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

--===============1537146912==
Content-Type: multipart/signed; boundary="nextPart5259073.JjLoPPiaYA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5259073.JjLoPPiaYA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 16 August 2006 15:54 schrieb Takashi Iwai:
> At Wed, 16 Aug 2006 15:51:40 +0200,
>
> Prakash Punnoor wrote:
> > Am Mittwoch 16 August 2006 14:19 schrieb Takashi Iwai:
> > > At Wed, 16 Aug 2006 14:04:50 +0200,
> > >
> > > Prakash Punnoor wrote:
> > > > Am Mittwoch 16 August 2006 13:11 schrieb Takashi Iwai:
> > > > > position_fix=3D1 is actually a hardware problem.  This could be f=
ixed
> > > > > by BIOS update (if any)...
> > > >
> > > > Thx for the info. But what exactly should I report to Asus?
> > >
> > > That the position registers (70h/74h) don't work properly.
> > > I don't know what values are read there.  You need to try to dump the
> > > values to check what's going on there.
> >
> > Well, could you point me how to do it? Im not a kernel dev...
>
> Just add printk arround reading azx_dev->posbuf in azx_pcm_pointer().

I tried again, and I think you can forget about the issue. The stack3 setti=
ng=20
seems to fix everything, ie position_fix=3D1 isn't needed and it seems to w=
ork=20
nice with 0. (I never tried stack3 alone...)

Sorry for the noise. :-/
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart5259073.JjLoPPiaYA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE40bvxU2n/+9+t5gRAo2qAJwOnSmvp0tBP5HTHXwyTOzXXxkq8wCfWCcu
wd+bzW9KKaVF2iHOybjta2A=
=bels
-----END PGP SIGNATURE-----

--nextPart5259073.JjLoPPiaYA--


--===============1537146912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1537146912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1537146912==--
