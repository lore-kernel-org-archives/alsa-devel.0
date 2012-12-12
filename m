From: Damien Zammit <damien.zammit@gmail.com>
Subject: Bug in aplay?
Date: Wed, 12 Dec 2012 22:01:38 +1100
Message-ID: <CABXa2sHAWX-q=tpMdLqJSXbu-kNeuuhhPY5UQ41qKQ+SisD=Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4833F261605
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 12:01:39 +0100 (CET)
Received: by mail-oa0-f51.google.com with SMTP id n12so514003oag.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:01:38 -0800 (PST)
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

Hi,
I think i found a small bug in alsa utility "aplay".

If you have a sound device that supports the S24_3BE format natively,
and you have a wav file of the same format, aplay will not play it
because it detects the wrong format and assumes it is default format.
(ie 8000Hz Mono 1 channel).
I compiled my own version of aplay and it works because I hacked the
default format to match this format, but it is not the ideal solution.

pi@raspberrypi ~ $ aplay --version
aplay: version 1.0.25 by Jaroslav Kysela <perex@perex.cz>

pi@raspberrypi ~ $ aplay -D hw:1 48000-S24_3BE.wav
Playing raw data '48000-S24_3BE.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: set_params:1081: Sample format non available
Available formats:
- S24_3BE

My version:
pi@raspberrypi ~ $ ./aplay -D hw:1 48000-S24_3BE.wav
Playing raw data '48000-S24_3BE.wav' : Signed 24 bit Big Endian in
3bytes, Rate 48000 Hz, Stereo
aplay: set_params:1145: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S24_3BE
SUBFORMAT:  STD
SAMPLE_BITS: 24
FRAME_BITS: 48
CHANNELS: 2
RATE: 48000
PERIOD_TIME: 125000
PERIOD_SIZE: 6000
PERIOD_BYTES: 36000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 24000
BUFFER_BYTES: 144000
TICK_TIME: 0
pi@raspberrypi ~ $

This is making it tricky for me to use my sound card.  For some reason
it works better with jackd.  The error above is also a mystery to me,
but it seems to be detecting the format better.

Regards,
Damien
