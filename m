From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: add stream format parameters
 for Mytek devices
Date: Sat, 19 May 2018 17:23:30 +0900
Message-ID: <1cef1eca-3a06-e05e-765f-dfe984091085@sakamocchi.jp>
References: <20632004.ST2tKRhYS0@melvin-pc>
 <3d9fd8b0-d67e-0591-ed6d-8eec562ab58b@sakamocchi.jp>
 <2438583.1KDy1DEBS4@melvin-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 2815F2672AF
 for <alsa-devel@alsa-project.org>; Sat, 19 May 2018 10:23:34 +0200 (CEST)
In-Reply-To: <2438583.1KDy1DEBS4@melvin-pc>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Melvin Vermeeren <mail@mel.vin>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 19 2018 05:01, Melvin Vermeeren wrote:
> With lintweaker's out-of-tree USB 2.0 driver[1] it works with DoP. Due to
> latency requirements and reliability I always run over firewire however. =
I did
> some basic attempts to get it working from userspace, but I think it is n=
ot
> possible with the current snd_dice.
> =

> As for the player, I believe there are several that support it. So far I =
have
> been using MPD, which has native DSD playback[2][3].
> =

> I did attempt something cheap to see what would happen:
> =

> #define AM824_IN_PCM_FORMAT_BITS       SNDRV_PCM_FMTBIT_S32
> #define AM824_OUT_PCM_FORMAT_BITS      SNDRV_PCM_FMTBIT_S32
> =

> For these two, I appended "| SNDRV_PCM_FMTBIT_DSD_U32_LE" and some other
> variants. MPD then refuses to play because:
> =

> alsa_output: opened hw:DAC,0 type=3DHW
> alsa_output: buffer: size=3D1792..4096 time=3D10158..23220
> alsa_output: period: size=3D896..2048 time=3D5079..11610
> alsa_output: default period_time =3D buffer_time/4 =3D 23219/4 =3D 5804
> alsa_output: format=3DDSD_U32_LE (Direct Stream Digital, 4-byte (x32), li=
ttle
> endian, oldest bits in MSB)
> alsa_output: buffer_size=3D4096 period_size=3D1024
> output: opened "mpd_alsa_out" (alsa) audio_format=3Ddsd128:4
> exception: Failed to convert for "mpd_alsa_out" (alsa)
> exception: nested: PCM conversion from f to dsd is not implemented
> output: Retrying without DSD
> alsa_output: opened hw:DAC,0 type=3DHW
> alsa_output: buffer: size=3D1920..4096 time=3D10000..21334
> alsa_output: period: size=3D960..2048 time=3D5000..10667
> alsa_output: default period_time =3D buffer_time/4 =3D 21333/4 =3D 5333
> alsa_output: format=3DS32_LE (Signed 32 bit Little Endian)
> alsa_output: buffer_size=3D4096 period_size=3D1024
> output: opened "mpd_alsa_out" (alsa) audio_format=3D192000:32:4
> libsamplerate: setting samplerate conversion ratio to 0.27
> output: converting in=3Ddsd128:2 -> f=3Ddsd128:2 -> out=3D192000:32:4
> =

> I am pretty sure this happens because the DSD128 file is 2 channels, and =
MPD
> sees the output in 4 channels. It does exactly the same for DSD64. I am n=
ot
> sure how this should be handled since the channels are not actually for 4=
.0
> audio. Possibly need to expose it is a 2-channel device and in the driver=
 use
> PCM-L,PCM-R or DSD-L,DSD-R depending on the input. Could be the unit work=
s a
> bit differently then this, I will ask Mytek.
> =

> In the meanwhile, do you have any suggestions for things I could experime=
nt
> with? I am not very familiar with the ALSA tree (yet). Meanwhile I will t=
ry to
> look in MPD source code for a bit, if I could set channel mappings there =
that
> might solve it too.
>   =

> By the way, it seems that currently native 16-bit and 24-bit PCM formats =
are
> not supported since it always locks to 32-bit. I remember the "old", 2016,
> DICE driver did support 16-bit to my DAC, not sure about 24-bit. I am cur=
ious
> to why the new design is fixed to 32-bit, do you perhaps know?
> =

> [1] https://github.com/lintweaker/mytekusb2
> [2] https://www.musicpd.org/doc/user/dsd.html
> [3] https://github.com/MusicPlayerDaemon/MPD/blob/master/NEWS

This is my first time to have discussion about transmission of PDM
sample by IEC 61883-1/6[1][2] via IEEE 1394 bus. You can see details
of this protocol in a document published by 1394TA[3]. For
implementation detail, please refer to my un-upstreamed documents[4][5].

Unfortunately, at present, IEC 61883-1/6 engine in ALSA firewire stack
is designed for PCM samples and MIDI messages with ALSA PCM/MIDI
interface. I removed support 16 bit PCM sample at a commit a02cb8f8def6
('ALSA: firewire: remove support for 16 bit PCM samples in playback
substream')[6] in this point, because as long as I know all of
supported models have no features to switch bit width of
transferred/received PCM samples and my previous implementation for
16 bit sample brings zero-padding 24 bit PCM sample to the device.
(Drivers in ALSA firewire stack support SNDRV_PCM_FMTBIT_S32 with
24 bit constraint[7].)

In my opinion, it's hard to achieve it with quick hack to the engine
and ALSA Dice driver. Especially for your case, one data block for
outgoing packet to target device should include two kind data; PCM
and PDM samples. I can see output from '/proc/asound/DSD/dice' in
your previous message[8] includes below:

```
rx 0:
   iso channel: 1
   sequence start: 0
   audio channels: 4
   midi ports: 0
   names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
   ac3 caps: 00000000
```

If the 'ANALOG L/R' represent data channels for two PCM samples
and the 'DSD1281/2' represent data channels for two PDM samples,
I can assume that one data block includes two kind of samples,
thus two data streams of PCM/PDM samples should be multiplexed into
one data stream of IEC 61883-1/6 packets.

For this case, I need to implement ALSA dice driver to add two PCM
substreams in Linux system; one is for transmission of PCM samples,
another is for transmission of PDM samples for DoP-compliant
application. Unfortunately, current IEC 61883-1/6 engine in ALSA
firewire stack is not designed for this case.

As an another solution, reservation of data transmission of
IEC 61883-1/6 packet either data stream of PCM samples or data
stream of PDM samples. In this case, implementation change can be
smaller than multiplexing/demultiplexing these two data stream for
data stream of IEC 61883-1/6 packets. In this solution, from
userspace applications, two PCM substreams are available exclusively.

[1] IEC 61883-1 Consumer audio/video equipment =96
Digital interface - Part 1: General
[2] IEC 61883-6 Consumer audio/video equipment =96
Digital interface =96 Part 6: Audio and music data transmission protocol
[3] Audio and Music Data Transmission Protocol 2.2 Revision 1.1
(1394 Trade Association, Oct 2010)
http://1394ta.org/wp-content/uploads/2015/07/2009013.pdf
[4] Documentation/sound/iec61883-6/protocol.rst
https://github.com/takaswie/sound/blob/topic/iec61883-6-documentation/Docum=
entation/sound/iec61883-6/protocol.rst
[5] Documentation/sound/iec61883-6/timing-on-ieee1394.rst
https://github.com/takaswie/sound/blob/topic/iec61883-6-documentation/Docum=
entation/sound/iec61883-6/timing-on-ieee1394.rst
[6] ALSA: firewire: remove support for 16 bit PCM samples in playback =

substream
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=
=3Da02cb8f8def634159b60c3a4d6ba16e471b46e0c
[7] see amdtp_am824_add_pcm_hw_constraints()
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/=
firewire/amdtp-am824.c#n214
[8] [alsa-devel] DICE Stereo-192-DSD-DAC issues since 2016-02-08 / =

kernel >=3D ~4.6
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/125524.=
html


Regards

Takashi Sakamoto
