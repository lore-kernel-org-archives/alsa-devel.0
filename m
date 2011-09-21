From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Wed, 21 Sep 2011 10:35:10 -0400
Message-ID: <20110921143510.GG1223@alittletooquiet.net>
References: <20110916203601.GD8309@alittletooquiet.net>
	<20110919231413.GD1223@alittletooquiet.net>
	<s5hsjnrr840.wl%tiwai@suse.de>
	<20110920190534.GF1223@alittletooquiet.net>
	<s5h39fqz3u7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1487391412760538883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 349662452C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 16:35:14 +0200 (CEST)
In-Reply-To: <s5h39fqz3u7.wl%tiwai@suse.de>
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


--===============1487391412760538883==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Sep 21, 2011 at 10:39:44AM +0200, Takashi Iwai wrote:
> At Tue, 20 Sep 2011 15:05:34 -0400, Forest Bond wrote:
> > On Tue, Sep 20, 2011 at 09:22:23AM +0200, Takashi Iwai wrote:
> > > At Mon, 19 Sep 2011 19:14:13 -0400, Forest Bond wrote:
> > > > On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond wrote:
> > > > > I have two boards with a VT1708:
> > > > >=20
> > > > > * VIA EPIA EX15000G
> > > > > * VIA VB8002
> > > > >=20
> > > > > I'm using VLC to play audio via PulseAudio to the analog outputs.=
  The VB8002
> > > > > sounds great, but the EX15000G has random pops and clicks in the =
output.  Both
> > > > > machines are running exactly the same configuration (they are usi=
ng the same
> > > > > pre-built OS image).
> > > >=20
> > > > Maybe this issue would be more approachable if I could produce it w=
ithout
> > > > PulseAudio involved?
> > >=20
> > > Yes.
> >=20
> > Heh, I guess I'm probably not going to be able to do that very easily.
> >=20
> > > > Incidentally, these boards both produce a crackling/static sound wh=
en PulseAudio
> > > > is playing and the PCM mixer is turned all the way down.  I have se=
en scattered
> > > > reports of this in various bug trackers.  The problem does not occu=
r when
> > > > playing via alsa directly.  One thing I have noticed is that the cr=
ackling noise
> > > > follows the rhythm of the music being played.  It actually sounds l=
ike the music
> > > > has been heavily distorted (i.e. via extreme digital clipping) and =
then
> > > > attenuated significantly.
> > > >=20
> > > > It seems likely that there are driver issues that PulseAudio is exp=
osing.  What
> > > > can I do to track them down?
> > >=20
> > > Is the problem related with the driver version?  You mentioned the
> > > difference of drivers installed on your systems.
> > > If it's a regression of the driver, it'd be easier to figure out.
> >=20
> > No, the issue occurs with both driver versions.
> >=20
> > > Other than that, I'd try to adjust PA, e.g. try tsched=3D0.  Usually
> > > this kind of problem is because of inaccurate playback position
> > > reporting from the hardware.  PA relies (too much) on the playback
> > > position as default.
> >=20
> > Using tsched=3D0 fixes the pops and clicks on the EX15000G.  Any idea w=
hy I might
> > see problems on one board but not the other given how similar they are?
>=20
> Do they have the same HD-audio controller chip (VIA one)?
> Usually it's an issue of controller chip, not codec chips, so I wonder
> if they behave differently even with a same controller.

I'm not really sure how to identify the controller chip.  alsa-info.sh outp=
ut is
here:

EX15000G:
http://www.alsa-project.org/db/?f=3Dea56226a7917391d6adf9078650d3a9395f51b17

VB8002:
http://www.alsa-project.org/db/?f=3D611cc772a3fab7552bbda193b6ad7998f66a60fb

As I understand it the VT1708 is the codec chip.  Is the audio controller p=
art
of the south bridge?  Both report having a VT8237.

> > The crackling with PCM volume set to 0 persists with tsched=3D0.
>=20
> Hrm, which PA version are you using?  I remember vaguely a buggy PA
> SIMD operations in some old PA versions.

1:0.9.22+stable-queue-24-g67d18-0ubuntu3 from Ubuntu Lucid.

> Also, when you mute the mixer (nor the PA's mixer), e.g. via
> "alsamixer -c0", the noise goes away, right?

I do not use the PA mixer.  The noise is present with ALSA's PCM control se=
t to
zero (-51dB).  If I move the PCM control up one tick (to -50.8dB) the noise=
 goes
away.

> > It seems unlikely that this isn't driver or hardware issue.  But fixing=
 the
> > pops and clicks without using tsched=3D0 is more important to me.  If y=
ou can
> > provide suggestions as to where I might start looking, I would be happy=
 to
> > try and come up with a fix.
>=20
> As mentioned, the usual problem is the inaccurate DMA position
> reporting, especially when tsched=3D0 helped.  It means a problem of
> HD-audio controller.  We have already many workarounds in the driver
> code, but more investigations are needed in such a case...

Again, I'm happy to spend the time needed to get this fixed.  If you can pr=
ovide
hints on where to look, that would be great.  Can you point me at some git
commits that fixed similar issues?  I checked the git log but did not find =
any
such commits that changed patch_via.c.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk559h0ACgkQRO4fQQdv5AxdgwCeJ23HluYKkr1kcrUXV6tZLkHi
uEcAn3zsY6jU8++hOWbYhs+uRCAhKsZ/
=Misy
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--

--===============1487391412760538883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1487391412760538883==--
