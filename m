From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Wed, 21 Sep 2011 13:40:57 -0400
Message-ID: <20110921174056.GK1223@alittletooquiet.net>
References: <20110916203601.GD8309@alittletooquiet.net>
	<20110919231413.GD1223@alittletooquiet.net>
	<s5hsjnrr840.wl%tiwai@suse.de>
	<20110920190534.GF1223@alittletooquiet.net>
	<s5h39fqz3u7.wl%tiwai@suse.de>
	<20110921143510.GG1223@alittletooquiet.net>
	<s5hobyegdmk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3734500529852053916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 55B1F24436
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 19:41:01 +0200 (CEST)
In-Reply-To: <s5hobyegdmk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3734500529852053916==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Sep 21, 2011 at 04:43:15PM +0200, Takashi Iwai wrote:
> At Wed, 21 Sep 2011 10:35:10 -0400, Forest Bond wrote:
> > On Wed, Sep 21, 2011 at 10:39:44AM +0200, Takashi Iwai wrote:
> > > At Tue, 20 Sep 2011 15:05:34 -0400, Forest Bond wrote:
> > > > On Tue, Sep 20, 2011 at 09:22:23AM +0200, Takashi Iwai wrote:
> > > > > At Mon, 19 Sep 2011 19:14:13 -0400, Forest Bond wrote:
> > > > > > On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond wrote:
> > > > > > > I have two boards with a VT1708:
> > > > > > >=20
> > > > > > > * VIA EPIA EX15000G
> > > > > > > * VIA VB8002
> > > > > > >=20
> > > > > > > I'm using VLC to play audio via PulseAudio to the analog outp=
uts.  The VB8002
> > > > > > > sounds great, but the EX15000G has random pops and clicks in =
the output.  Both
> > > > > > > machines are running exactly the same configuration (they are=
 using the same
> > > > > > > pre-built OS image).

[...]

> > > As mentioned, the usual problem is the inaccurate DMA position
> > > reporting, especially when tsched=3D0 helped.  It means a problem of
> > > HD-audio controller.  We have already many workarounds in the driver
> > > code, but more investigations are needed in such a case...
> >=20
> > Again, I'm happy to spend the time needed to get this fixed.  If you ca=
n provide
> > hints on where to look, that would be great.  Can you point me at some =
git
> > commits that fixed similar issues?  I checked the git log but did not f=
ind any
> > such commits that changed patch_via.c.
>=20
> Well, there are a few possible causes.  If it's something wrong in the
> codec side, it can be a PM code.  The latest driver has a mixer enum
> "Dynamic Power-Control".  Try to disable it.

This control is not enabled for the VT1708 codec because the
set_widgets_power_state function pointer is not defined for this codec.  I
assume the hardware doesn't support the underlying feature?  Or maybe it is=
 just
not implemented yet in the driver?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk56IagACgkQRO4fQQdv5AztxACgrpJoxWsUNr4RMk09kyuDMeK8
TlAAoJFyBEdqpH8fkuhHZPuyhCMSMejk
=Jhsm
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--

--===============3734500529852053916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3734500529852053916==--
