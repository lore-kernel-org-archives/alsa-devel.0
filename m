From: Alexander Samad <alex@samad.com.au>
Subject: Re: [Alsa-user] [PATCH] emu10k1 multichannel support
Date: Thu, 20 Jan 2005 06:51:54 +1100
Message-ID: <20050119195154.GR27550@samad.com.au>
References: <1106091073.24484.60.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1106091073.24484.60.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Interested in this, been trying to get multi channel output from audigy2
card


I tried the quick start but it seemed to fail

multimedia:~# jackd -R -v -d alsa -P hw:0,3 -C hw:0,2 -S
getting driver descriptor from /usr/lib/libjack0.80.0-0/jack_alsa.so
getting driver descriptor from /usr/lib/libjack0.80.0-0/jack_dummy.so
getting driver descriptor from /usr/lib/libjack0.80.0-0/jack_oss.so
jackd 0.99.0
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

registered builtin port type 32 bit float mono audio
running with uid=3D0 and euid=3D0, will not try to use capabilites
loading driver ..
new client: alsa_pcm, id =3D 1 type 1 @ 0x80578b0 fd =3D -1
creating alsa driver ...
hw:0,3|hw:0,2|1024|2|48000|0|0|nomon|swmeter|-|16bit
ALSA lib pcm_hw.c:1172:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed:
No such device
ALSA: Cannot open PCM device alsa_pcm for playback. Falling back to
capture-only mode
control device hw:0
configuring for 48000Hz, period =3D 1024 frames, buffer =3D 2 periods
new buffer size 1024
registered port alsa_pcm:capture_1, offset =3D 4096
registered port alsa_pcm:capture_2, offset =3D 8192
++ jack_rechain_graph():
client alsa_pcm: internal client, execution_order=3D0.
-- jack_rechain_graph()
13828 waiting for signals
load =3D 0.0141 max usecs: 6.000, spare =3D 21327.000
jack main caught signal 2
stopping driver
detaching driver
unloading driver
freeing shared port segments
stopping server thread
stopping watchdog thread
freeing engine shared memory
max usecs: 6.000, engine deleted




This is the output from aplay -l
multimedia:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Audigy2Value [Sound Blaster Audigy2_Value], device 0: emu10k1
[EMU10K1]
  Subdevices: 32/32
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
  Subdevice #8: subdevice #8
  Subdevice #9: subdevice #9
  Subdevice #10: subdevice #10
  Subdevice #11: subdevice #11
  Subdevice #12: subdevice #12
  Subdevice #13: subdevice #13
  Subdevice #14: subdevice #14
  Subdevice #15: subdevice #15
  Subdevice #16: subdevice #16
  Subdevice #17: subdevice #17
  Subdevice #18: subdevice #18
  Subdevice #19: subdevice #19
  Subdevice #20: subdevice #20
  Subdevice #21: subdevice #21
  Subdevice #22: subdevice #22
  Subdevice #23: subdevice #23
  Subdevice #24: subdevice #24
  Subdevice #25: subdevice #25
  Subdevice #26: subdevice #26
  Subdevice #27: subdevice #27
  Subdevice #28: subdevice #28
  Subdevice #29: subdevice #29
  Subdevice #30: subdevice #30
  Subdevice #31: subdevice #31
card 0: Audigy2Value [Sound Blaster Audigy2_Value], device 2: emu10k1
efx [EMU10K1 EFX]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 1: I82801BAICH2 [Intel 82801BA-ICH2], device 0: Intel ICH [Intel
82801BA-ICH2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


cat /proc/asound/cards
0 [Audigy2Value   ]: Audigy2 - Sound Blaster Audigy2_Value
                     Sound Blaster Audigy2_Value (rev.0,
serial:0x10011102) at 0xc000, irq 18
1 [I82801BAICH2   ]: ICH - Intel 82801BA-ICH2
                     Intel 82801BA-ICH2 with ALC200/200P at 0xdc00, irq
17


multimedia:~# cat /proc/asound/version=20
Advanced Linux Sound Architecture Driver Version 1.0.8.
Compiled on Jan 19 2005 for kernel 2.6.9-6-ntf.

multimedia:~# cat /proc/asound/devices=20
  4: [0- 0]: hardware dependent
  9: [0- 1]: raw midi
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
 57: [1- 1]: digital audio capture
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl

i have had a play around with .asoundrc but to no avail I can still only
see 2 channels on the card!

Alex


On Tue, Jan 18, 2005 at 06:31:12PM -0500, Lee Revell wrote:
> As promised, here's an updated patch to add real multichannel playback
> support (and improved multichannel capture) to the emu10k1 driver.
>=20
> http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v001.patch
>=20
> Please test it and report any problems.  I am especially interested in
> any regressions that impact regular PCM playback (the hw:0,0 device).
>=20
> QuickStart:
>=20
> $ jackd -R -v -d alsa -P hw:0,3 -C hw:0,2 -S
>=20
> This also adds some new register info including a per channel half loop
> interrupt that I have discovered by reverse engineering the Windows
> drivers.
>=20
> Improvements over previous versions:
>=20
>  - Routes the 16 channels to the 16 FX buses by default.
>=20
>  - Enables the first 16 FX capture outputs by default, required for=20
> full duplex operation at latencies lower than 512 frames.
>=20
>  - Rewrote the voice allocator to use a more efficient round=20
> robin algorithm, eliminating the need to reserve the
> first 16 voices for the multichannel device.  The next free voice=20
> is maintained in the card record and the search starts from there.
>=20
>  - Use an extra voice for playback timing rather than the EFX capture
> interrupt.  I was only ever able to get that to work at 64 frames.  Also
> there are definite advantages to being able to use the capture and
> playback devices independently.
>=20
>  - Use the newly discovered per-channel half loop interrupt source for
> the extra voice rather than the channel loop interrupts.  For unknown
> reasons, this works better for multichannel playback, and does not seem
> to affect regular PCM playback at all.
>=20
> TODO:
>=20
>  - Fix the send routing and volume controls for the multichannel device.
> The current (copy and paste) solution assumes either one or two voices
> per PCM.  So the default settings work fine but changing them with the
> mixer is likely to have unpredictable effects. =20
>=20
>  - EFX capture should capture output channels 16-32 (mostly unused now)
> by default, so that we only capture the sources the user has connected
> to the multichannel recording inputs in the DSP manager.  Typically FX
> buses 0-15 would be connected directly to FX outputs 16-32 so the
> capture channels would correspond directly to the playback channels.  In
> order for this to work the default DSP configuration has to be changed
> slightly.
>=20
> I tested this and it works well with 16in/16out at 128, 256, 512 frames.
> 32 and 64 should work too but I can't test as I'm running a stock 2.6.10
> kernel for now ;-).  You can check that the routing is correct by
> connecting a JACK client to the playback ports corresponding to the FX
> buses described in Documentation/Audigy-mixer.txt and
> Documentation/SB-Live-mixer.txt, and verifying that the output appears
> on that channel (the FX buses are numbered from 0 but JACK numbers
> clients from 1).  For example (from SB-Live-mixer.txt):
>=20
>     name=3D'Music Playback Volume',index=3D0
>=20
>     This control is used to attenuate samples for left and right MIDI FX-=
bus
>     accumulators. ALSA uses accumulators 4 and 5 for left and right MIDI =
samples.
>     The result samples are forwarded to the front DAC PCM slots of the AC=
97 codec.
>=20
> So "alsaplayer -o jack -d alsa_pcm:playback_5,alsa_pcm:playback_6"
> should output to FX buses 4 and 5, which you can test by lowering the
> 'Music' control in alsamixer.  With an SBLive, use ports 1 and 2 for the
> front channels, 3 and 4 for the rear channels.  The Audigy uses
> different channels, see the above docs for more info.
>=20
> In addition to multichannel recording applications, this should also be
> useful for OpenAL implementations, which are currently restricted to
> using 21 sources due to the use of an extra voice per stereo PCM.  This
> should allow up to 63 sources.
>=20
> Lee
>=20
>=20
>=20
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
>=20

--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB7rpakZz88chpJ2MRAjCnAJ9zPGL+LYYEdFIxqMuZlLX6FJmhIwCgq8Xw
9mtjFHt3DIedEWRhCgOPqVA=
=XoKK
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
