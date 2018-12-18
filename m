From: Mantas Gridinas <mgridinas@gmail.com>
Subject: Regarding snd_soc_googlevoicechat_soundcard drivers
 and arecord on Raspberry PI
Date: Tue, 18 Dec 2018 16:08:33 +0200
Message-ID: <CAE9hW8SQC+NWQquh6Mgk2sVvvNdBjVfDBm5ie1KB6i0EbPDbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
 [209.85.166.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 63E532677C8
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 15:08:35 +0100 (CET)
Received: by mail-io1-f54.google.com with SMTP id x6so12825578ioa.9
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 06:08:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

I've been looking into how to record audio using arecord and the following
audio card extension for Raspberry PI
https://pinout.xyz/pinout/raspiaudio_audio_speakers_mic#. The guide in it
seems to install snd_soc_googlevoicechat_soundcard driver and after
recording for some minutes it throws this error:

Dec 18 15:32:17 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c: snd_pcm_avail() returned
a value that is exceptionally large: 7022640 bytes (18288 ms).
Dec 18 15:32:17 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c: Most likely this is a bug
in the ALSA driver 'snd_soc_googlevoicehat_soundcard'. Please report
this issue to the ALSA developers.
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c: snd_pcm_dump():
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c: Hardware PCM card 0
'snd_rpi_googlevoicehat_soundcar' device 0 subdevice 0
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c: Its setup is:
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   stream       : PLAYBACK
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   access       :
MMAP_INTERLEAVED
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   format       : S32_LE
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   subformat    : STD
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   channels     : 2
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   rate         : 48000
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   exact rate   : 48000
(48000/1)
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   msbits       : 32
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   buffer_size  : 65536
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   period_size  : 32768
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   period_time  : 682666
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   tstamp_mode  : ENABLE
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   tstamp_type  :
MONOTONIC
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   period_step  : 1
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   avail_min    : 65345
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   period_event : 0
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   start_threshold  : -1
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   stop_threshold   :
1073741824
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   silence_threshold: 0
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   silence_size : 0
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   boundary     :
1073741824
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   appl_ptr     : 7938534
Dec 18 15:32:22 homepie pulseaudio[8048]: [alsa-sink-Google voiceHAT
SoundCard HiFi voicehat-hifi-0] alsa-util.c:   hw_ptr       : 8750828

And I start the recording with the following command
arecord -c 2 -r 48000 -f s32_le

AlsaInfo output is available at
http://www.alsa-project.org/db/?f=17a71c8e22f097d844906274a0bd78dbf124513c.
Although after inspecting the provided log it seems that the Raspberry
PI board is not included in the DMI, which is supposed to be BCM2835.
I can't say anything else on on other details.
