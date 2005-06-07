From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: au88x0_synth
Date: Tue, 7 Jun 2005 17:03:00 +0200
Message-ID: <200506071703.03192.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <200506061635.12201.alien999999999@users.sourceforge.net> <42A5A4A3.7040108@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3284549.iyqC2y39OQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A5A4A3.7040108@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart3284549.iyqC2y39OQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op dinsdag 7 juni 2005 15:44, schreef Raymond:
>  From your png, it seem that you are not using the alsamixer in the
> latest version of alsa-utils.

since i'm using alsa CVS for driver, kernel and lib; i'll use utils from CV=
S=20
as well...

> The alsamixer or amixer are unable to display EQ Peaks correctly, the EQ
> Peaks is a volatile read-only kcontrol which return 20 EQ peak values
> from the 10-bands stereo hardware equalizer in au8810/au8830.

didn't know that, in the previous versions, i know that all these peaks wer=
e=20
listed as mono sliders, not partly mono and stereo...

> The graphic equalizer in vortexcontrol use a timer callback to read and
> display the EQ peaks when EQ Enable switch is on. (attached vc_eq.png)

vortexcontrol looks nice, from what alsa CVS package is that?

> Alien wrote:
> >>What do you mean when you say "the equalizer sliders look odd" ?
> >
> > i'll show you: see png file, notice that the first 2 peaks are stereo,
> > and the last 2 peaks are mono... ???
> >
> >>Would you post the settings of the equalizer from "/data/path/mixer" or
> >>/etc/asound.state ?
> >
> > I must also say that when restoring, i always get one warning: something
> > with bad value for... somethingorother
>
> When you upgrade from ALSA 1.0.8 to ALSA 1.0.9 ,the SPDIF sample rate
> control ( ALSA 1.0.8 ) has been replaced by the IEC958 control ( ALSA
> 1.0.9 ).

thanks for the info, but since i'm not using SPDIF, this was never any=20
relevance for me

> You will need to delete old setting in "/data/path/mixer" and use
> alsactl to store the new setting, otherwise error will occur if you try
> to use alsactrl to restore the value of emunerated spdif sample rate
> control settings saved by the previous ALSA version to the au8810 in
> ALSA 1.0.9 driver.

actually, this one warning has been there for quite some time, i donno if i=
t's=20
emu10k1 or au8810... (i think even in 32bit, not sure about that), when=20
storing it, modprobe -r and modprobe again, and restoring, the warning=20
stays...

> Your /etc/asound.state seem OK and the equalizer is OFF.

never used the equalizer, i wasn't able to put the whole asound.state file,=
 (i=20
removed the emu10k1 stuff), cause the size of the mail was too large...

> > /etc/asound.state:
> > state.au8810 {
> > 	control.1 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'EQ Enable'
> > 		value false
> > 	}
> > 	control.2 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ0 31Hz'
> > 		value.0 16375
> > 		value.1 16375
> > 	}
> > 	control.3 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ1 63Hz'
> > 		value.0 16392
> > 		value.1 16392
> > 	}
> > 	control.4 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ2 125Hz'
> > 		value.0 16375
> > 		value.1 16375
> > 	}
> > 	control.5 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ3 250Hz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.6 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ4 500Hz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.7 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ5 1KHz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.8 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ6 2KHz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.9 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ7 4KHz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.10 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ8 8KHz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.11 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ9 16KHz'
> > 		value.0 16022
> > 		value.1 16022
> > 	}
> > 	control.12 {
> > 		comment.access read
> > 		comment.type INTEGER
> > 		comment.range '0 - 32767'
> > 		iface MIXER
> > 		name 'EQ Peaks'
> > 		value.0 0
> > 		value.1 0
> > 		value.2 0
> > 		value.3 0
> > 		value.4 0
> > 		value.5 0
> > 		value.6 0
> > 		value.7 0
> > 		value.8 0
> > 		value.9 0
> > 		value.10 0
> > 		value.11 0
> > 		value.12 0
> > 		value.13 0
> > 		value.14 0
> > 		value.15 0
> > 		value.16 0
> > 		value.17 0
> > 		value.18 0
> > 		value.19 0
> > 	}
> > 	control.13 {
> > 		comment.access 'read write'
> > 		comment.type IEC958
> > 		iface PCM
> > 		name 'IEC958 Playback Default'
> > 		value
> > '0082000000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000000000000000000=
00
> >0000000000000000000000000000000000000000000000000000000000' }
> > 	control.14 {
> > 		comment.access read
> > 		comment.type IEC958
> > 		iface PCM
> > 		name 'IEC958 Playback Con Mask'
> > 		value
> > ffffff0f000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000000000000000000=
00
> >000000000000000000000000000000000000000000000000000000000 }
> > 	control.15 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Master Playback Switch'
> > 		value true
> > 	}
> > 	control.16 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Master Playback Volume'
> > 		value.0 24
> > 		value.1 24
> > 	}
> > 	control.17 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Master Mono Playback Switch'
> > 		value true
> > 	}
> > 	control.18 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Master Mono Playback Volume'
> > 		value 24
> > 	}
> > 	control.19 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'PC Speaker Playback Switch'
> > 		value false
> > 	}
> > 	control.20 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 15'
> > 		iface MIXER
> > 		name 'PC Speaker Playback Volume'
> > 		value 0
> > 	}
> > 	control.21 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Phone Playback Switch'
> > 		value false
> > 	}
> > 	control.22 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Phone Playback Volume'
> > 		value 0
> > 	}
> > 	control.23 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Mic Playback Switch'
> > 		value false
> > 	}
> > 	control.24 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Mic Playback Volume'
> > 		value 0
> > 	}
> > 	control.25 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Mic Boost (+20dB)'
> > 		value false
> > 	}
> > 	control.26 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Line Playback Switch'
> > 		value true
> > 	}
> > 	control.27 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Line Playback Volume'
> > 		value.0 24
> > 		value.1 24
> > 	}
> > 	control.28 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'CD Playback Switch'
> > 		value true
> > 	}
> > 	control.29 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'CD Playback Volume'
> > 		value.0 24
> > 		value.1 24
> > 	}
> > 	control.30 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Video Playback Switch'
> > 		value false
> > 	}
> > 	control.31 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Video Playback Volume'
> > 		value.0 0
> > 		value.1 0
> > 	}
> > 	control.32 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Aux Playback Switch'
> > 		value false
> > 	}
> > 	control.33 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'Aux Playback Volume'
> > 		value.0 0
> > 		value.1 0
> > 	}
> > 	control.34 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'PCM Playback Switch'
> > 		value true
> > 	}
> > 	control.35 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 31'
> > 		iface MIXER
> > 		name 'PCM Playback Volume'
> > 		value.0 24
> > 		value.1 24
> > 	}
> > 	control.36 {
> > 		comment.access 'read write'
> > 		comment.type ENUMERATED
> > 		comment.item.0 Mic
> > 		comment.item.1 CD
> > 		comment.item.2 Video
> > 		comment.item.3 Aux
> > 		comment.item.4 Line
> > 		comment.item.5 Mix
> > 		comment.item.6 'Mix Mono'
> > 		comment.item.7 Phone
> > 		iface MIXER
> > 		name 'Capture Source'
> > 		value.0 Line
> > 		value.1 Line
> > 	}
> > 	control.37 {
> > 		comment.access 'read write'
> > 		comment.type BOOLEAN
> > 		iface MIXER
> > 		name 'Capture Switch'
> > 		value true
> > 	}
> > 	control.38 {
> > 		comment.access 'read write'
> > 		comment.type INTEGER
> > 		comment.range '0 - 15'
> > 		iface MIXER
> > 		name 'Capture Volume'
> > 		value.0 12
> > 		value.1 12
> > 	}
> > 	control.39 {
> > 		comment.access 'read write'
> > 		comment.type ENUMERATED
> > 		comment.item.0 Mix
> > 		comment.item.1 Mic
> > 		iface MIXER
> > 		name 'Mono Output Select'
> > 		value Mix
> > 	}
> > 	control.40 {
> > 		comment.access 'read write'
> > 		comment.type ENUMERATED
> > 		comment.item.0 Mic1
> > 		comment.item.1 Mic2
> > 		iface MIXER
> > 		name 'Mic Select'
> > 		value Mic1
> > 	}
> > }
>
> After eight instances of "mplayer" playing stereo music concurrently in
> my 32-bits machine and start an instance of aplay.
>
> aplay outls.wav
> Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
> Stereo
> aplay: set_params:935: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 16
> FRAME_BITS: 32
> CHANNELS: 2
> RATE: 22050
> PERIOD_TIME: (46439 46440)
> PERIOD_SIZE: 1024
> PERIOD_BYTES: 4096
> PERIODS: 11
> BUFFER_TIME: (510839 510840)
> BUFFER_SIZE: 11264
> BUFFER_BYTES: 45056
> TICK_TIME: 10000
>
>
> aplay abort as there is no more SampleRateConvertors available.
>
> There is no deadlock or hang. After the "mplayer" finish playing and
> release the SRCs, I can start another instance of ALSA application to
> play music.


I'm going to try to do the same thing with xine and CVS aplay, see what=20
happens...

--nextPart3284549.iyqC2y39OQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpbcnuBWKXETrtdcRAkTYAKCM36xB5p8EpfqK8r8ZaLnEmU+V3wCfZVxR
m1Gr/BgQrUUByGhalf1esUk=
=hOGE
-----END PGP SIGNATURE-----

--nextPart3284549.iyqC2y39OQ--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
