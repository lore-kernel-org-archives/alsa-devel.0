From: Eduard Hasenleithner <ehasenle@spamcop.net>
Subject: ice1712 pro mode and alsaplayer
Date: 05 Jul 2003 22:09:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057435751.13735.45.camel@boundary.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TglCiGlVP2t63ga37p7J"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-TglCiGlVP2t63ga37p7J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello.

While searching the mailing list I found another person than me having
problems with playback on a DMX 6fire card. I assume that this problem
with the 6fire card should be present with every envy24 card in
professional mode, so I have used this general subject. So here is a
small symptom description with my theory about it. When starting
alsaplayer without any parameters an (error-) log appears (see log1.txt)

>From the error messages we can see that alsaplayer tries two times to
setup playback and fails both times on set_periods, one time with value
13 and one time with value 7. But when I start alsaplayer with the
"-g 6" option playback works and a different log output is present (see
log2.txt)

So, alsaplayer still fails with set_periods to value 13 for a reason
that I do not know, because I have forced alsaplayer to use the value 6.
It appears that the "[" and "]" means that the borders are inclusive and
that "(" and ")" means that the borders are exclusive. Although 13 and 7
are exclusive alsaplayer tries to use these values. Maybe this is a bug
in alsaplayer.

To my surprise, in professional mode the 1712 chip is only capable of
playback of all 10 output channels at once with each using 32bit on the
bus regardless of the number of channels and sample bits of the source
format. Since buffer_bytes_max is set to 256k we get:

                 playback buffer  256k
/    (channels*byte_per_channel)    40
/ period bytes set by alsaplayer  1024
= max. num of periods              6.4

So the maximum number of periods is 6!

To conclude, I have two main concerns:
1. Alsaplayer should be able to set the num. of periods correctly to 6.
Maybe I am wrong in this mailing list for mentioning this.
2. With the ice1712, 256k of buffer memory and assuming 44.1kSps only
0.13 seconds of playback can be stored in the driver buffer. I noticed a
lot of xrun when doing background tasks while listening to music or when
only watching a video. What can be done about this?
	- Implement a pre-buffer in kernel with the source bitrate
          and number of channels?
        - increase the kernel buffer. But then only for one second
          1.8M of kernel ram are needed!

This is my software setup:
SuSE 8.2
 alsaplayer 0.99.74
 alsa 0.9.0.cvs20030217 (lib,...)

I want to hear your opinions!
Greetings,
Eduard.

PS: One funny thing is that using oss emulation the problem with the
0.13s buffer is still present, but oss setup works without glitches
(e.g. xmms).

--=-TglCiGlVP2t63ga37p7J
Content-Disposition: attachment; filename=log1.txt
Content-Type: text/plain; name=log1.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

eduard@boundary:~/News/jpop> alsaplayer aiko\ -\ Chiisana\ marui\ koujitsu\ -\ 01\ -\ Orange\ na\ Mangetsu.mp3 --verbose
AlsaPlayer 0.99.74
(C) 1999-2003 Andy Lo A Foe <andy@alsaplayer.org> and others.
Output plugin: ALSA output v1.9.0beta12
error on set_periods (13)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (11609 11610)
PERIOD_SIZE: 512
PERIOD_BYTES: 2048
PERIODS: [1 13)
BUFFER_TIME: (11609 148595)
BUFFER_SIZE: [512 6553]
BUFFER_BYTES: [2048 26212]
TICK_TIME: 10000
error on set_periods (7)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: [1 7)
BUFFER_TIME: (23219 148595)
BUFFER_SIZE: [1024 6553]
BUFFER_BYTES: [4096 26212]
TICK_TIME: 10000
failed to configure output device...trying OSS
error opening /dev/dsp
Failed to register plugin: /usr/lib/alsaplayer/output/liboss_out.so
failed to load output plugin (alsa). exitting...

--=-TglCiGlVP2t63ga37p7J
Content-Disposition: attachment; filename=log2.txt
Content-Type: text/plain; name=log2.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

eduard@boundary:~/News/jpop> alsaplayer -g 6 aiko\ -\ Chiisana\ marui\ koujitsu\ -\ 01\ -\ Orange\ na\ Mangetsu.mp3 --verbose
AlsaPlayer 0.99.74
(C) 1999-2003 Andy Lo A Foe <andy@alsaplayer.org> and others.
Output plugin: ALSA output v1.9.0beta12
error on set_periods (13)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (11609 11610)
PERIOD_SIZE: 512
PERIOD_BYTES: 2048
PERIODS: [1 13)
BUFFER_TIME: (11609 148595)
BUFFER_SIZE: [512 6553]
BUFFER_BYTES: [2048 26212]
TICK_TIME: 10000
Loading reader plugin: File reader v1.1
Loading reader plugin: HTTP reader v1.2
Loading Input plugin: MikMod player v1.0
Loading Input plugin: WAV player v1.01
Loading Input plugin: MAD MPEG audio plugin v0.99
Loading Input plugin: Ogg Vorbis player v1.2
Loading Input plugin: flac player v1.1
Loading Input plugin: CDDA player v1.2
Loading Input plugin: libsndfile plugin v0.1
Loading Input plugin: Audio File Library player v0.2.1
Interface plugin: GTK+ interface v1.2

--=-TglCiGlVP2t63ga37p7J--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
