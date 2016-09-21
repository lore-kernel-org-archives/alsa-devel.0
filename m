From: Juan Pedro =?utf-8?Q?Bol=C3=ADvar?= Puente <raskolnikov@gnu.org>
Subject: usb: Novation Twitch not working on Linux 4.7
Date: Wed, 21 Sep 2016 12:42:42 +0200
Message-ID: <87intpbkkd.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8046650496552372103=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eggs.gnu.org (eggs.gnu.org [208.118.235.92])
 by alsa0.perex.cz (Postfix) with ESMTP id B53822606F7
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 12:42:48 +0200 (CEST)
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raskolnikov@gnu.org>) id 1bmezG-0007OQ-P7
 for alsa-devel@alsa-project.org; Wed, 21 Sep 2016 06:42:48 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Hills <mark@xwax.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--===============8046650496552372103==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I am trying to use again my Novation Twitch after some time, and audio
playback is not working anymore.  I have tried with Jackd and various
other programs, and it seems to always fail to install the hardware
params.  Note that before it fails, I do get to hear a little noise in
the monitor output.  Here is console the output of various programs.

Note that, I am using Linux 4.7.0-1-amd64 as distributed with Debian
Sid.

Here is the output of some commands:

  $ ./alsacap

      *** Scanning for playback devices ***
      ...
      Card 1, ID `Twitch', name `Twitch'
        Device 0, ID `USB Audio', name `USB Audio', 1 subdevices (1 availab=
le)
          4 channels, sampling rate 44100..48000 Hz
          Sample formats: S24_3LE
            Subdevice 0, name `subdevice #0'

  $ ./alsacap -d hw:Twitch

      *** Exploring configuration space of device `hw:Twitch' for playback =
***
      4 channels
      Sampling rate 44100..48000 Hz
      Sample formats: S24_3LE
      Significant bits: 24

  $ aplay -D hw:Twitch -f S24_3LE -c 4 -r 44100 test.wav

      Playing raw data 'prueba.wav' : Signed 24 bit Little Endian in
      3bytes, Rate 44100 Hz, Channels 4
      aplay: set_params:1361: Unable to install hw params:
      ACCESS:  RW_INTERLEAVED
      FORMAT:  S24_3LE
      SUBFORMAT:  STD
      SAMPLE_BITS: 24
      FRAME_BITS: 96
      CHANNELS: 4
      RATE: 44100
      PERIOD_TIME: (125011 125012)
      PERIOD_SIZE: 5513
      PERIOD_BYTES: 66156
      PERIODS: (3 4)
      BUFFER_TIME: 500000
      BUFFER_SIZE: 22050
      BUFFER_BYTES: 264600
      TICK_TIME: 0

  $ mplayer -ao alsa:device=3Dhw=3DTwitch test.mp3

      MPlayer 1.3.0 (Debian), built with gcc-5.4.0 (C) 2000-2016 MPlayer Te=
am
      Playing test.mp3.
      ...
      [AO_ALSA] Format s16le is not supported by hardware, trying default.
      [AO_ALSA] Unable to set format: Invalid argument
      Failed to initialize audio driver 'alsa:device=3Dhw=3DTwitch'

  $ mplayer -ao alsa:device=3Dplughw=3DTwitch test.mp3

      MPlayer 1.3.0 (Debian), built with gcc-5.4.0 (C) 2000-2016 MPlayer Te=
am
      Playing test.mp3.
      ...
      [AO_ALSA] alsa-lib: pcm_hw.c:603:(snd_pcm_hw_prepare)
  SNDRV_PCM_IOCTL_PREPARE failed (-32): Broken pipe
      [AO_ALSA] alsa-lib: pcm_direct.c:1054:(snd1_pcm_direct_initialize_sla=
ve)
  unable to install hw params
      [AO_ALSA] alsa-lib: pcm_dmix.c:1053:(snd_pcm_dmix_open) unable to
  initialize slave
      [AO_ALSA] Playback open error: Broken pipe
      Failed to initialize audio driver 'alsa:device=3Dhw=3DTwitch'

  $ jackd -n twitch -d alsa -d hw:Twitch

      jackdmp 1.9.11
      ...
      creating alsa driver ...
  hw:Twitch|hw:Twitch|1024|2|48000|0|0|nomon|swmeter|-|32bit
      Using ALSA driver USB-Audio running on card 1 - Novation Twitch at
  usb-0000:00:1d.0-1.2, full speed
      ALSA: Cannot open PCM device alsa_pcm for capture. Falling back to
  playback-only mode
      configuring for 48000Hz, period =3D 1024 frames (21.3 ms), buffer =3D=
 2
  periods
      ALSA: final selected sample format for playback: 24bit little-endian =
in
  3bytes format
      ALSA: use 2 periods for playback
      ALSA: cannot set hardware parameters for playback
      ALSA: cannot configure playback channel

Am I doing something wrong?  Is it really broken?
=20=20
Thanks a lot!

JP

=2D-
                                 =E2=88=BF=E2=88=BF=E2=88=BF=E2=88=BF
                         https://sinusoid.es
                                 =E2=88=BF=E2=88=BF=E2=88=BF=E2=88=BF

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX4mQiAAoJEFKbqWJpCnCxAcwQANFmLX7dUmXFe9bbzv3DsKcs
3CIv6cJWLawZCtYM4Bza+gD8JnY/ykH3HpMHASlb9JJ1M7aoGccvlvjFH9eTvxS0
SBGKRsUF2Tdm3u9wlUtDS8mNYB1QZ5rV+yM8gIJltDfVJ1SyOOa0hmmKL6/oLXHN
AWpUjqgZEVKsziPiCO8vy3IHoknnMwJYSlHvYGKdi3NFhgltgmBXyeFMiZZJm/8B
dVbAlTiaO4pSkgnDR2JwCUzhfM58S0beS4USkTIa/cgw+/k9I779F9ZyY7pxdBFu
EC+PlyCoAyjQs0oKvoLXJ+V9Y+ARlxzWN10aJvjEgi4BHlVZtCiJDH5smhoPaL/t
FpgRjboUr2mD+Hz4NMGrB41OCLcZ/XJF334+LwTK3/riXjnDurZ6VAOmz1jutaCG
lFR8WysnlvTYvFE5hl+aHlXHz061EShYLG2zmxuhzdp4anrP3HyK4r9JQ3tX0dd3
KOpn+n00Q/gdSZ+PhxJO9SFPA5UMq9rypDIRweIUVM3VUOf7VP4opSHXh/39gpon
grquIeWnP1Ui3PouprxBbyL+QWMMewmsdqZTZruY8ebcZio/QTk7SEcHpOcfpdA2
FLWMIet0aB+QIn7YBiS1+Kq/YoYGO7gFnpljEgSWypB8BXuSRC1MH5KAoPGtpBb4
GmRY2uDbMeWQuHRzPSIX
=hFvm
-----END PGP SIGNATURE-----
--=-=-=--

--===============8046650496552372103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8046650496552372103==--
