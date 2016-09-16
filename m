From: Juan Pedro =?utf-8?Q?Bol=C3=ADvar?= Puente <raskolnikov@gnu.org>
Subject: Re: Novation Twitch broken on Linux 4.7?
Date: Fri, 16 Sep 2016 20:33:52 +0200
Message-ID: <87poo3u227.fsf@gnu.org>
References: <87lgys0wq2.fsf@gnu.org> <1609161626200.3103@stax.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8893535451011985730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eggs.gnu.org (eggs.gnu.org [208.118.235.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E05266957
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 20:34:38 +0200 (CEST)
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raskolnikov@gnu.org>) id 1bkxy8-0000YY-6Z
 for alsa-devel@alsa-project.org; Fri, 16 Sep 2016 14:34:37 -0400
In-Reply-To: <1609161626200.3103@stax.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@xwax.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============8893535451011985730==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Mark Hills <mark@xwax.org> writes:

> On Fri, 16 Sep 2016, Juan Pedro Bol=C3=ADvar Puente wrote:
>
>> I am trying to use again my Novation Twitch after some time, and audio
>> playback is not working anymore.  I have tried with Jackd and various
>> other programs, and it seems to always fail to install the hardware
>> params.
>
> [...]
>
> If it doesn't work then maybe the attached alsacap.c is useful and you
> could post the output back (and CC alsa-devel); it should show us the
> advertised rates and formats.

Here is the ouput:

$ ./alsacap

    *** Scanning for playback devices ***
    ...
    Card 1, ID `Twitch', name `Twitch'
      Device 0, ID `USB Audio', name `USB Audio', 1 subdevices (1 available)
        4 channels, sampling rate 44100..48000 Hz
        Sample formats: S24_3LE
          Subdevice 0, name `subdevice #0'

$ ./alsacap -d hw:Twitch

    *** Exploring configuration space of device `hw:Twitch' for playback ***
    4 channels
    Sampling rate 44100..48000 Hz
    Sample formats: S24_3LE
    Significant bits: 24

For people reading this message for the first time in `alsa-devel`, here
are the error output of various commands when trying to use the device:

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

    MPlayer 1.3.0 (Debian), built with gcc-5.4.0 (C) 2000-2016 MPlayer Team
    Playing test.mp3.
    ...
    [AO_ALSA] Format s16le is not supported by hardware, trying default.
    [AO_ALSA] Unable to set format: Invalid argument
    Failed to initialize audio driver 'alsa:device=3Dhw=3DTwitch'

$ mplayer -ao alsa:device=3Dplughw=3DTwitch test.mp3

    MPlayer 1.3.0 (Debian), built with gcc-5.4.0 (C) 2000-2016 MPlayer Team
    Playing test.mp3.
    ...
    [AO_ALSA] alsa-lib: pcm_hw.c:603:(snd_pcm_hw_prepare)
SNDRV_PCM_IOCTL_PREPARE failed (-32): Broken pipe
    [AO_ALSA] alsa-lib: pcm_direct.c:1054:(snd1_pcm_direct_initialize_slave)
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
    configuring for 48000Hz, period =3D 1024 frames (21.3 ms), buffer =3D 2
periods
    ALSA: final selected sample format for playback: 24bit little-endian in
3bytes format
    ALSA: use 2 periods for playback
    ALSA: cannot set hardware parameters for playback
    ALSA: cannot configure playback channel

Thanks a lot!

=2D-
                                 =E2=88=BF=E2=88=BF=E2=88=BF=E2=88=BF
                         https://sinusoid.es
                                 =E2=88=BF=E2=88=BF=E2=88=BF=E2=88=BF

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX3DsQAAoJEFKbqWJpCnCxKcsQAI6qsAfdWoZcO6JadCkviTod
2KI9fwKQHK6mK1BmeTG8Eme1qIokAE4xkf8fsbNJTKMOnL4JEKKntSjJ+7D9nDbe
Klth0oWEy/UJ/A+9eY4d+hveGcfQ+lG29eiOGsKYk0PmBdbSrcX5qteCyswSIAAr
vNi66CzGV58B0+/HhbTqVBSgOoFCXxkXuHJ7X1rM68sinR3PPj3KQn+f6ZL2xqL9
xBXuOuoaYbikSMay2vrLHwySXNJQJrSTsT+CzrISfdUFrfcnADPAoF3aMo427Rbe
pc8ahRLRBYR7aVScLo3IKjt7Wap9T5ZWU5q9+HGJFVBmUYeZ1g1+2GzeGLkEZo4X
/WLDYNVD8tJk/z9s+a9bIkwIkUeDVPHNkIeGGh5ptbAqo8GgoJQVCLmhX8QsJdcr
FwnlJ93nZj7E0q5uiqu49qkaz3f+gJQDnr9+yeib2o5jDHjHXrmcspwB9m0usHE2
hRa4TP8JhfjX5s5rX+VOf2QjmKTrDg28UqP6+PNuupNgdfkibDWDFOLKhxLMB6Ay
5hQS7iGHwtn27ASa/5Ta/T0PjAbpiUhiLlOqOEdkY7UiQBRROSUa8kt9y9U24wcV
0jnsV4g3o2WW8hnE/CXyOD6sp65M50EmwP75s7CCvHGIr/ViywcknCDOUNXRGE5S
58pBkkyewuElGNWhDDGA
=lFa3
-----END PGP SIGNATURE-----
--=-=-=--

--===============8893535451011985730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8893535451011985730==--
