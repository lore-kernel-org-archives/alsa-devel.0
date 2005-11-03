From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: asym plugin in asoundrc causes "poll time out" errors in jackd
Date: Thu, 3 Nov 2005 20:21:11 +0200
Message-ID: <20051103182111.GF10146@edu.joroinen.fi>
References: <20051103161229.GB10146@edu.joroinen.fi> <s5h8xw5snxd.wl%tiwai@suse.de> <20051103162442.GC10146@edu.joroinen.fi> <s5hek5xsn3m.wl%tiwai@suse.de> <20051103171856.GD10146@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051103171856.GD10146@edu.joroinen.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 03, 2005 at 07:18:56PM +0200, Pasi K=E4rkk=E4inen wrote:
> On Thu, Nov 03, 2005 at 05:38:37PM +0100, Takashi Iwai wrote:
> > At Thu, 3 Nov 2005 18:24:42 +0200,
> > Pasi K=E4rkk=E4inen wrote:
> > >=20
> > > On Thu, Nov 03, 2005 at 05:20:46PM +0100, Takashi Iwai wrote:
> > > > At Thu, 3 Nov 2005 18:12:29 +0200,
> > > > Pasi K=E4rkk=E4inen wrote:
> > > > >=20
> > > > > Hi list!
> > > > >=20
> > > > > I've already sent this mail to jackd mailing list, but didn't g=
ot any
> > > > > helpful replies.. so I'm trying if somebody knows more about as=
ym stuff
> > > > > here.
> > > > >=20
> > > > > I'm trying to run jackd with multi + asym plugins in ~/.asoundr=
c, but I get
> > > > > "ALSA: poll time out, polled for 17407547 usecs" messages all t=
he time from
> > > > > jackd..
> > > > >=20
> > > > > .asounrdc available here:
> > > > > http://nrg.joroinen.fi/asoundrc-asym.txt
> > > >=20
> > > > Please post it instead of URL.
> > > >=20
> > >=20
> > > Attached.
> >=20
> > Hmm, it looks more complicated than needed... :)
> >=20
> > First of all, I don't see the point to use asym plugin.
> > jackd has options -C and -P, and you can pass the different device
> > name for each direction.  Also, don't forget to pass the appropriate
> > channel numbers via -i and -o options for both directions.
> >=20
> > BTW, asym plugin itself is really harmless.  It just does pass-thru
> > the given PCM for the specified direction.  Nothing else.
> > So, the problem is either multi plugin or the handling of asymmetrica=
l
> > PCMs by jackd.
> >=20
>=20
> Thanks for your comments!
>=20
> I've cleaned up the asoundrc (removed asym/duplex-stuff).
>=20
> http://nrg.joroinen.fi/asoundrc-multi.txt (also attached to this mail).
>=20
> Does it look OK now?=20
>=20
> Now I start jackd like this:
>=20
> $ jackd -d alsa -C jackmulti_capture -P jackmulti_playback -r 44100 -i =
12 -o 10
> jackd 0.100.0
> Copyright 2001-2005 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
>=20
> JACK compiled with System V SHM support.
> loading driver ..
> apparent rate =3D 44100
> creating alsa driver ...
> jackmulti_playback|jackmulti_capture|1024|2|44100|12|10|nomon|swmeter|-=
|32bit
> configuring for 44100Hz, period =3D 1024 frames, buffer =3D 2 periods
> nperiods =3D 2 for capture
> nperiods =3D 2 for playback
> ALSA: poll time out, polled for 34806057 usecs
> ALSA: poll time out, polled for 34805957 usecs
> ALSA: poll time out, polled for 34806090 usecs
> ALSA: poll time out, polled for 34805870 usecs
>=20
> Still the same problem..  I have not yet even combined both cards to th=
ese
> multi devices.. I'm only using single ice1712 device at the moment.
>=20
> If the alsa/asoundrc part looks OK now, then I think I have to start
> debugging jackd..
>=20

I've recompiled jackd with DEBUG_WAKEUP defined, and I get this:

$ jackd -d alsa -C jackmulti_capture -P jackmulti_playback -r 44100 -i 12=
 -o
10
jackd 0.100.0
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.
loading driver ..
apparent rate =3D 44100
creating alsa driver ...
jackmulti_playback|jackmulti_capture|1024|2|44100|12|10|nomon|swmeter|-|3=
2bit
configuring for 44100Hz, period =3D 1024 frames, buffer =3D 2 periods
nperiods =3D 2 for capture
nperiods =3D 2 for playback
9399899033: checked 2 fds, 34805939 usecs since poll entered
9399899033 playback stream timed out
9399899033 capture stream timed out
ALSA: poll time out, polled for 34805939 usecs


looking at jack-audio-connection-kit-0.100.0/drivers/alsa/alsa_driver.c=20
alsa_driver_wait() function:

poll_enter =3D jack_get_microseconds ();

..

if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {
..
}

poll_ret =3D jack_get_microseconds ();

..

#ifdef DEBUG_WAKEUP
	fprintf (stderr, "%" PRIu64 ": checked %d fds, %" PRIu64
		" usecs since poll entered\n", poll_ret, nfds,
		poll_ret - poll_enter);
#endif


It looks like there are no events coming from ALSA to jackd..=20

So the problem is in multi-plugin? Or do I miss something?

- Pasi K=E4rkk=E4inen



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
