From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: asym plugin in asoundrc causes "poll time out" errors in jackd
Date: Mon, 28 Nov 2005 20:32:06 +0200
Message-ID: <20051128183206.GJ10146@edu.joroinen.fi>
References: <20051103161229.GB10146@edu.joroinen.fi> <s5h8xw5snxd.wl%tiwai@suse.de> <20051103162442.GC10146@edu.joroinen.fi> <s5hek5xsn3m.wl%tiwai@suse.de> <20051103171856.GD10146@edu.joroinen.fi> <s5h3bmdsifi.wl%tiwai@suse.de> <20051103182506.GG10146@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051103182506.GG10146@edu.joroinen.fi>
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

On Thu, Nov 03, 2005 at 08:25:06PM +0200, Pasi K=E4rkk=E4inen wrote:
> > > >=20
> > > > Hmm, it looks more complicated than needed... :)
> > > >=20
> > > > First of all, I don't see the point to use asym plugin.
> > > > jackd has options -C and -P, and you can pass the different devic=
e
> > > > name for each direction.  Also, don't forget to pass the appropri=
ate
> > > > channel numbers via -i and -o options for both directions.
> > > >=20
> > > > BTW, asym plugin itself is really harmless.  It just does pass-th=
ru
> > > > the given PCM for the specified direction.  Nothing else.
> > > > So, the problem is either multi plugin or the handling of asymmet=
rical
> > > > PCMs by jackd.
> > > >=20
> > >=20
> > > Thanks for your comments!
> > >=20
> > > I've cleaned up the asoundrc (removed asym/duplex-stuff).
> > >=20
> > > http://nrg.joroinen.fi/asoundrc-multi.txt (also attached to this ma=
il).
> > >=20
> > > Does it look OK now?=20
> > >=20
> > > Now I start jackd like this:
> > >=20
> > > $ jackd -d alsa -C jackmulti_capture -P jackmulti_playback -r 44100=
 -i 12 -o 10
> > > jackd 0.100.0
> > > Copyright 2001-2005 Paul Davis and others.
> > > jackd comes with ABSOLUTELY NO WARRANTY
> > > This is free software, and you are welcome to redistribute it
> > > under certain conditions; see the file COPYING for details
> > >=20
> > > JACK compiled with System V SHM support.
> > > loading driver ..
> > > apparent rate =3D 44100
> > > creating alsa driver ...
> > > jackmulti_playback|jackmulti_capture|1024|2|44100|12|10|nomon|swmet=
er|-|32bit
> > > configuring for 44100Hz, period =3D 1024 frames, buffer =3D 2 perio=
ds
> > > nperiods =3D 2 for capture
> > > nperiods =3D 2 for playback
> > > ALSA: poll time out, polled for 34806057 usecs
> > > ALSA: poll time out, polled for 34805957 usecs
> > > ALSA: poll time out, polled for 34806090 usecs
> > > ALSA: poll time out, polled for 34805870 usecs
> >=20
> > Could you try ALSA CVS version?  (both drivers and libs)
> >=20
> >
>=20
> Yes, that's possible if there are possible fixes in CVS.
> =20

I'm running now alsa 1.0.10-1 Debian packages, with kernel 2.6.14-2-686-s=
mp.

The same problem still exists.

Looking at the jackd code, the "poll time out" messages come from poll()
system call when jackd is started in fullduplex mode for alsa multi devic=
e.

If jackd is started in fullduplex mode for alsa _hw_ device directly, I d=
on't
get those poll time out messages. Or if I start jackd in _halfduplex_ (ei=
ther
playback or capture) mode for alsa multi device, I don't get those messag=
es.

So the poll time out's only occur when alsa multi device is used in fulld=
uplex mode.

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/pcm/pcm_multi.c

It seems to be last modified 5 months ago.. Takashi, is there something y=
ou
recommend me to try/test/patch to get fullduplex working with multi plugi=
n?=20

Others have reported same problem to jackd mailinglist.

Thanks!

-- Pasi K=E4rkk=E4inen
      =20
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
