From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Tue, 20 Sep 2011 15:05:34 -0400
Message-ID: <20110920190534.GF1223@alittletooquiet.net>
References: <20110916203601.GD8309@alittletooquiet.net>
	<20110919231413.GD1223@alittletooquiet.net>
	<s5hsjnrr840.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3138368712636820773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id BB4A9103854
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 21:05:35 +0200 (CEST)
In-Reply-To: <s5hsjnrr840.wl%tiwai@suse.de>
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


--===============3138368712636820773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Thanks for your response.

On Tue, Sep 20, 2011 at 09:22:23AM +0200, Takashi Iwai wrote:
> At Mon, 19 Sep 2011 19:14:13 -0400,
> Forest Bond wrote:
> >=20
> > On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond wrote:
> > > I have two boards with a VT1708:
> > >=20
> > > * VIA EPIA EX15000G
> > > * VIA VB8002
> > >=20
> > > I'm using VLC to play audio via PulseAudio to the analog outputs.  Th=
e VB8002
> > > sounds great, but the EX15000G has random pops and clicks in the outp=
ut.  Both
> > > machines are running exactly the same configuration (they are using t=
he same
> > > pre-built OS image).
> >=20
> > Maybe this issue would be more approachable if I could produce it witho=
ut
> > PulseAudio involved?
>=20
> Yes.

Heh, I guess I'm probably not going to be able to do that very easily.

> > Incidentally, these boards both produce a crackling/static sound when P=
ulseAudio
> > is playing and the PCM mixer is turned all the way down.  I have seen s=
cattered
> > reports of this in various bug trackers.  The problem does not occur wh=
en
> > playing via alsa directly.  One thing I have noticed is that the crackl=
ing noise
> > follows the rhythm of the music being played.  It actually sounds like =
the music
> > has been heavily distorted (i.e. via extreme digital clipping) and then
> > attenuated significantly.
> >=20
> > It seems likely that there are driver issues that PulseAudio is exposin=
g.  What
> > can I do to track them down?
>=20
> Is the problem related with the driver version?  You mentioned the
> difference of drivers installed on your systems.
> If it's a regression of the driver, it'd be easier to figure out.

No, the issue occurs with both driver versions.

> Other than that, I'd try to adjust PA, e.g. try tsched=3D0.  Usually
> this kind of problem is because of inaccurate playback position
> reporting from the hardware.  PA relies (too much) on the playback
> position as default.

Using tsched=3D0 fixes the pops and clicks on the EX15000G.  Any idea why I=
 might
see problems on one board but not the other given how similar they are?

The crackling with PCM volume set to 0 persists with tsched=3D0.  It seems
unlikely that this isn't driver or hardware issue.  But fixing the pops and
clicks without using tsched=3D0 is more important to me.  If you can provide
suggestions as to where I might start looking, I would be happy to try and =
come
up with a fix.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk544/4ACgkQRO4fQQdv5AwWAQCgi8I8AiL1zJ6S44OdlSMu67uY
AScAn0fZD54ABdni86Hrdg6WnP4CdKNT
=38gb
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--

--===============3138368712636820773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3138368712636820773==--
