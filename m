From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: asym plugin in asoundrc causes "poll time out" errors in jackd
Date: Thu, 3 Nov 2005 19:21:09 +0200
Message-ID: <20051103172109.GE10146@edu.joroinen.fi>
References: <20051103161229.GB10146@edu.joroinen.fi> <s5h8xw5snxd.wl%tiwai@suse.de> <20051103162442.GC10146@edu.joroinen.fi> <s5hek5xsn3m.wl%tiwai@suse.de> <20051103171856.GD10146@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nVMJ2NtxeReIH9PS"
Content-Transfer-Encoding: 7bit
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


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

well.. at least now :)

-- Pasi K=E4rkk=E4inen
      =20
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asoundrc-multi.txt"

# START OF .asoundrc

# Alias for first Delta card
pcm.delta1010_1 {
   type hw
   card 1
}
ctl.delta1010_1 {
   type hw
   card 1
}


# Alias for second Delta card
pcm.delta1010_2 {
   type hw
   card 2
}
ctl.delta1010_2 {
   type hw
   card 2
}




# Create virtual device out of multiple soundcards.
# This cannot be used by JACK, which will complain that it
# cannot get mmap-based access. See jackmulti below.


pcm.multi_playback {
type multi
# First soundcard associated with slave "a"
slaves.a.pcm delta1010_1
slaves.a.channels 10

#slaves.b.pcm delta1010_2
#slaves.b.channels 10

    # Read the lines below as follows:
    # bindings.x.slave y
    # bindings.x.channel z
    # The above example means:
    # "Bind channel z on slave y to channel x of the new multi device"
    # Check above to see which soundcard is associated with which slave


    # The first 10 channels of the first soundcard
    bindings.0.slave a
    bindings.0.channel 0
    bindings.1.slave a
    bindings.1.channel 1
    bindings.2.slave a
    bindings.2.channel 2
    bindings.3.slave a
    bindings.3.channel 3
    bindings.4.slave a
    bindings.4.channel 4
    bindings.5.slave a
    bindings.5.channel 5
    bindings.6.slave a
    bindings.6.channel 6
    bindings.7.slave a
    bindings.7.channel 7
    bindings.8.slave a
    bindings.8.channel 8
    bindings.9.slave a
    bindings.9.channel 9

}

pcm.multi_capture {
type multi
# First soundcard associated with slave "a"
slaves.a.pcm delta1010_1
slaves.a.channels 12

#slaves.b.pcm delta1010_2
#slaves.b.channels 12

    # Read the lines below as follows:
    # bindings.x.slave y
    # bindings.x.channel z
    # The above example means:
    # "Bind channel z on slave y to channel x of the new multi device"
    # Check above to see which soundcard is associated with which slave


    # The first 12 channels of the first soundcard
    bindings.0.slave a
    bindings.0.channel 0
    bindings.1.slave a
    bindings.1.channel 1
    bindings.2.slave a
    bindings.2.channel 2
    bindings.3.slave a
    bindings.3.channel 3
    bindings.4.slave a
    bindings.4.channel 4
    bindings.5.slave a
    bindings.5.channel 5
    bindings.6.slave a
    bindings.6.channel 6
    bindings.7.slave a
    bindings.7.channel 7
    bindings.8.slave a
    bindings.8.channel 8
    bindings.9.slave a
    bindings.9.channel 9
    bindings.10.slave a
    bindings.10.channel 10
    bindings.11.slave a
    bindings.11.channel 11

}



# JACK requires a ctl (mixer) interface for any pcm interface
# it uses. A ctl interface for a multi device is a bit strange,
# but set this to the mixer of the first soundcard to keep JACK happy.
ctl.multi_playback {
    type hw
    card 1
}

ctl.multi_capture {
    type hw
    card 1
}


# This creates a multi-channel interleaved PCM stream based on
# the multi device. JACK will work with this one, as it can get
# mmap access to the channels.
pcm.jackmulti_playback {
    type route
    slave.pcm multi_playback


# As I understand it, you read "ttable.x.y z" as "route channel y of
# slave device specified above to channel x of the new (client) device,
# and multiply signal along this route with factor z", where z is
# between 0.0 and 1.0. A value of 1.0 therefore indicates no change to
# the signal (a straight routing between channels).
ttable.0.0 1.0
ttable.1.1 1.0
ttable.2.2 1.0
ttable.3.3 1.0
ttable.4.4 1.0
ttable.5.5 1.0
ttable.6.6 1.0
ttable.7.7 1.0

ttable.8.8 1.0
ttable.9.9 1.0
ttable.10.10 1.0
ttable.11.11 1.0
ttable.12.12 1.0
ttable.13.13 1.0
ttable.14.14 1.0
ttable.15.15 1.0


}

# JACK requires a ctl (mixer) interface for any pcm interface
# it uses. This is set to the first soundcard to keep JACK happy.
ctl.jackmulti_playback {
    type hw
    card 1
}


pcm.jackmulti_capture {
    type route
    slave.pcm multi_capture


# As I understand it, you read "ttable.x.y z" as "route channel y of
# slave device specified above to channel x of the new (client) device,
# and multiply signal along this route with factor z", where z is
# between 0.0 and 1.0. A value of 1.0 therefore indicates no change to
# the signal (a straight routing between channels).
ttable.0.0 1.0
ttable.1.1 1.0
ttable.2.2 1.0
ttable.3.3 1.0
ttable.4.4 1.0
ttable.5.5 1.0
ttable.6.6 1.0
ttable.7.7 1.0

ttable.8.8 1.0
ttable.9.9 1.0
ttable.10.10 1.0
ttable.11.11 1.0
ttable.12.12 1.0
ttable.13.13 1.0
ttable.14.14 1.0
ttable.15.15 1.0


}


# JACK requires a ctl (mixer) interface for any pcm interface
# it uses. This is set to the first soundcard to keep JACK happy.
ctl.jackmulti_capture {
    type hw
    card 1
}



# END OF .asoundrc


--nVMJ2NtxeReIH9PS--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
