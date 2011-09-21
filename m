From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Wed, 21 Sep 2011 13:55:53 -0400
Message-ID: <20110921175552.GL1223@alittletooquiet.net>
References: <20110916203601.GD8309@alittletooquiet.net>
	<20110919231413.GD1223@alittletooquiet.net>
	<s5hsjnrr840.wl%tiwai@suse.de>
	<20110920190534.GF1223@alittletooquiet.net>
	<s5h39fqz3u7.wl%tiwai@suse.de>
	<20110921143510.GG1223@alittletooquiet.net>
	<s5hobyegdmk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3812978985369658349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 52E2A24424
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 19:56:00 +0200 (CEST)
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


--===============3812978985369658349==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline


--4LwthZj+AV2mq5CX
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
> > > > The crackling with PCM volume set to 0 persists with tsched=3D0.

[...]

> > > Hrm, which PA version are you using?  I remember vaguely a buggy PA
> > > SIMD operations in some old PA versions.
> >=20
> > 1:0.9.22+stable-queue-24-g67d18-0ubuntu3 from Ubuntu Lucid.
> >=20
> > > Also, when you mute the mixer (nor the PA's mixer), e.g. via
> > > "alsamixer -c0", the noise goes away, right?
> >=20
> > I do not use the PA mixer.  The noise is present with ALSA's PCM contro=
l set to
> > zero (-51dB).  If I move the PCM control up one tick (to -50.8dB) the n=
oise goes
> > away.
>=20
> OK, then it's an issue in the sound driver.
> Could you give alsa-info.sh outputs both mute-with-noise and without
> noise for comparison?

I guess we can ignore this one for now.  I do not have this problem using a
recent alsa-driver snapshot.  The PCM control does not go below -40.25dB wi=
th
this version.  It's possible the new driver simply doesn't allow the contro=
l to
be set to a problematic value.

I will note, however, that the master control with the snapshot has a minim=
um
value of 0dB and a maximum of 6.75dB, and that the audio is barely audible =
at
0dB.  I have to crank the master control all the way up to get the same vol=
ume
as the old driver set to 0dB.  Maybe I can come up with a fix for this.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk56JSUACgkQRO4fQQdv5AyErwCfahRec+7HHb6EuR5QoV7KWBxw
cMoAoL4Ky4jMCQS2PFyxVHSHm/Iqd7X5
=SlGe
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--

--===============3812978985369658349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3812978985369658349==--
