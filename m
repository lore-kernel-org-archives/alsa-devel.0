From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Thu, 23 Apr 2015 22:06:03 +0900
Message-ID: <CAJ0eYfWsg3TNER07ENFg+z2nPgD_Wd50Gtt5HiJNdbZfDcKodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f45.google.com (mail-vn0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B34C0261A03
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 15:06:05 +0200 (CEST)
Received: by vnbf129 with SMTP id f129so1178446vnb.9
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 06:06:04 -0700 (PDT)
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

Clemens wrote:

> You should not write an .asoundrc.
> You should replace "hw" with "plughw" in the device name.

Somewhat different messages, but still aborts immediately.
(There is a relay click sound from Orpheus, as it always does before
playing music,
so it is getting slightly better..)

% ls -l .asound*
-rw-rw-r-- 1 user1 user1 65 Apr 23 21:48 .asoundrc-nogo

% grep asound /usr/share/alsa/alsa.conf
"/etc/asound.conf"
"~/.asoundrc"

% sudo ls -l /etc/asound.conf
ls: cannot access /etc/asound.conf: No such file or directory

% aplay -D plughw:2,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 0

% aplay -D plughw:2 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 4
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 0

% aplay -D default:2,0 test.wav
ALSA lib conf.c:4705:(snd_config_expand) Unknown parameters 2,0
ALSA lib pcm.c:2239:(snd_pcm_open_noupdate) Unknown PCM default:2,0
aplay: main:722: audio open error: Invalid argument

% aplay -D default:2 test.wav
ALSA lib conf.c:4705:(snd_config_expand) Unknown parameters 2
ALSA lib pcm.c:2239:(snd_pcm_open_noupdate) Unknown PCM default:2
aplay: main:722: audio open error: Invalid argument

Regards,
Mike Ood
