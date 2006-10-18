From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to
	off
Date: Wed, 18 Oct 2006 12:12:48 +0200
Message-ID: <200610181212.48952.prakash@punnoor.de>
References: <200610050938.10997.prakash@punnoor.de>
	<20061017211301.GE3502@stusta.de>
	<20061017144053.29b6b29c@freekitty>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0012305452=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 82374168
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Oct 2006 12:12:33 +0200 (MEST)
In-Reply-To: <20061017144053.29b6b29c@freekitty>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stephen Hemminger <shemminger@osdl.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

--===============0012305452==
Content-Type: multipart/signed; boundary="nextPart8121510.MIUtiWASzF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8121510.MIUtiWASzF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 17 Oktober 2006 23:40 schrieb Stephen Hemminger:
> On Tue, 17 Oct 2006 23:13:01 +0200
>
> Adrian Bunk <bunk@stusta.de> wrote:
> > On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> > > Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > > > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > > > Hi,
> > > > >
> > > > > subjects say it all. Without irqpoll my nic doesn't work anymore.=
 I
> > > > > added Ingo
> > > > > to cc, as my IRQs look different, so it may be a prob of APIC
> > > > > routing or the
> > > > > like.
> > > > >
> > > > > Can you try booting with pci=3Dnomsi ? I have a similar problem w=
ith
> > > > > my
> > >
> > > I used snd-hda-intel.disable_msi=3D1 and this actually helped! Now the
> > > nforce nic works w/o problems. So it was the audio driver causing hav=
oc
> > > on the nic. ...
> >
> > Unless someone finds and fixes what causes such problems, I'd therefore
> > suggest the patch below to let MSI support to be turned off by default.

Could it perhaps be that the forcedeth driver isn't MSI aware and this caus=
es=20
breakage?

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart8121510.MIUtiWASzF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNf4gxU2n/+9+t5gRAjsrAKDjX1Akfp5p1tAkUmKnWZitnP6jxgCgjFEG
zZ6jt9hmlGu1qaX0r+iuf0o=
=IRcl
-----END PGP SIGNATURE-----

--nextPart8121510.MIUtiWASzF--


--===============0012305452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0012305452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0012305452==--
