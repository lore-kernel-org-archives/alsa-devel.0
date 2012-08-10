From: Fabio Estevam <festevam@gmail.com>
Subject: Error with "Unsigned 8 bit, Rate 8000 Hz, Mono" track
Date: Fri, 10 Aug 2012 01:25:13 -0300
Message-ID: <CAOMZO5Dc38HSZRXFeZ-55KN83v1NNPCAAuoiFdixJ0K2dw90vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 472682664A3
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 05:55:28 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so1576015obb.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 21:25:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Running 3.6-rc1 on a mx28evk I get the following error with this wav format:

root@freescale /home$ aplay k3b_error1.wav
Playing WAVE 'k3b_error1.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
[  303.640000] asoc: machine hw_params failed: -22
aplay: set_params:959: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 1000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 4000
TICK_TIME: 0

Haven't started debugging yet, but if anyone sees something obvious,
please let me know.

This same file plays correctly on mx31/mx27/mx51/mx6q boards.

Regards,

Fabio Estevam
