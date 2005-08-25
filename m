From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 25 Aug 2005 22:04:34 +0200
Message-ID: <200508252204.37294.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <430DFC0D.1010502@netvigator.com> <1124996325.17363.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1171561.J39TXXPXRn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124996325.17363.6.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

--nextPart1171561.J39TXXPXRn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op donderdag 25 augustus 2005 20:58, schreef Manuel Jander:
> Hi,
>
> On Fri, 2005-08-26 at 01:12 +0800, Raymond wrote:
> > Alien wrote:
> > > PS: i forgot the latest patch i had to try out.
> >
> > Don't forget the latest patch "Fixed missing spin_unlock" on CVS .
> >
> > > I'll do one patch to try out, and hope it doesn't require me to reboot
> > > this machine...
> > >
> > > i'm using alsa CVS from some weeks ago, i think
> >
> > Although I can play multiple mono sound streams on device 2 on my au883=
0.
> >
> > I don't know why the connection routine of device 2 is disabled only on
> > au8810 driver.
> >
> > If you have any application using device 2 to playback (e.g. 3D demo in
> > vortexcontrol), wierd things may happen on au8810 since some of the
> > route and mixer of device 2 playback stream has not been assigned.
>
> The WT and A3D subsystems for AU8810 are disabled, because:
>
> - The AU8810 does not has any WT engine.
> - The AU8810 A3D slices/sources register addresses have not been
> confirmed and seem to be wrong. It looks like the AU8810 has 8 3D
> sources instead of the 16 that the AU8830 has, but further work is
> required, starting with the disassemble of a AU8810 WDM driver, in order
> to find out/conform the 3D slices/sources register addresses.

is it possible that this could have some negative outcome on the driver? in=
=20
particular, that it's not initialized and might be trying to be used at som=
e=20
point?

--nextPart1171561.J39TXXPXRn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDDiRVuBWKXETrtdcRAgwJAJ46Az5gB6J19XUgru4+0Bv0HvQTwwCguA/0
dP4pIFJqneFbFtPsg9h3MgY=
=0QBu
-----END PGP SIGNATURE-----

--nextPart1171561.J39TXXPXRn--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
