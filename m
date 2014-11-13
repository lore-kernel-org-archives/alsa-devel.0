From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Low sample rates for SGTL5000 on i.MX28
Date: Thu, 13 Nov 2014 21:34:02 -0200
Message-ID: <CAOMZO5ADTTgcvQY=HMt0dk2bAaO23YeBQBbwBzV5HyPOSUu=bQ@mail.gmail.com>
References: <546450E5.9090203@beamcommunications.com>
 <CAOMZO5BAaL8cP+7NetvNyEiGfokiyLWdpXw3r=AJspLj1dfzxw@mail.gmail.com>
 <54653283.5070404@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 389CC2661AE
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 00:34:03 +0100 (CET)
Received: by mail-lb0-f182.google.com with SMTP id f15so13191776lbj.13
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 15:34:02 -0800 (PST)
In-Reply-To: <54653283.5070404@beamcommunications.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2014 at 8:36 PM, Craig McQueen
<craig.mcqueen@beamcommunications.com> wrote:

> If you're playing a mono file successfully, then you must be going through
> an ALSA plugin that does some sort of rate/format/channel conversion. That
> depends on what's in asoundrc. Please try it with the -D hw:0,0 parameter
> and a stereo file.

That's interesting: I can play your three wav files if I run "aplay
file.wav" on mx28evk.

However, if I pass -D hw:0,0 I get different results:

aplay -D hw:0,0 stereo_16k.wav
Playing WAVE 'stereo_16k.wav' : Signed 16 bit Little Endian, Rate
16000 Hz, Stereo

also works, but:

root@freescale /home$  aplay -D hw:0,0 stereo_8k.wav
Playing WAVE 'stereo_8k.wav' : Signed 16[ 1023.301833] sgtl5000 0-000a: Invalid
mclk frequency: 4.096MHz
 bit Little Endian, Rate[ 1023.309341] mxs-sgtl5000 sound: ASoC: machine hw_para
ms failed: -22
 8000 Hz, Stereo
aplay: set_params:1123: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 4000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 16000
TICK_TIME: 0

Not sure why 'aplay -D hw:0,0 stereo_8k.wav' works and 'aplay
stereo_8k.wav' succeeds.
