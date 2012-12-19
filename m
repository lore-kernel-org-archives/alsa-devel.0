From: Fabio Estevam <festevam@gmail.com>
Subject: Adding wm8962 support to mx6qsabresd
Date: Wed, 19 Dec 2012 14:33:58 -0200
Message-ID: <CAOMZO5BLH-r77EMduGz7jOQVQcFyvW721UEiHY+sE1d7T4mwVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id D38F42650A4
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 17:33:59 +0100 (CET)
Received: by mail-ob0-f172.google.com with SMTP id za17so2218660obc.3
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 08:33:58 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I am working on adding audio support to mx6qsabresd board, which
contains a wm8962 codec.

Here is the log with debug information turned on that I am getting so far:

wm8962 0-001a: customer id 0 revision D
wm8962 0-001a: read 25 => 8
wm8962 0-001a: read 25 => 8
wm8962 0-001a: read 25 => 8
wm8962 0-001a: read 25 => 8
wm8962 0-001a: read 26 => 8
wm8962 0-001a: read 26 => 8
wm8962 0-001a: read 26 => 8
wm8962 0-001a: read 26 => 8
wm8962 0-001a: read 22 => 9
wm8962 0-001a: read 22 => 9
wm8962 0-001a: read 22 => 9
wm8962 0-001a: read 22 => 9
wm8962 0-001a: read 22 => 9
wm8962 0-001a: read 22 => 9
wm8962 0-001a: read 3a => 0
wm8962 0-001a: read 3a => 0
wm8962 0-001a: read 39 => 0
wm8962 0-001a: read 39 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 64 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 65 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 69 => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 6a => 0
wm8962 0-001a: read 200 => ffffffff
wm8962 0-001a: read 201 => 0
wm8962 0-001a: read 202 => 0
wm8962 0-001a: read 203 => ffffffff
wm8962 0-001a: read 204 => 8100
wm8962 0-001a: read 205 => 8100
wm8962 0-001a: DMIC not in use, disabling
input: WM8962 Beep Generator as
/devices/soc.0/2100000.aips-bus/21a0000.i2c/i2c-0/0-001a/input/input0
wm8962 0-001a: read 31 => ffffffff
wm8962 0-001a: read 31 => ffffffff
wm8962 0-001a: read 1a => 0
wm8962 0-001a: read 1a => 0
wm8962 0-001a: read 63 => 0
wm8962 0-001a: read 63 => 0
wm8962 0-001a: read 1a => 0
wm8962 0-001a: read 1a => 0
wm8962 0-001a: read 63 => 0
wm8962 0-001a: read 63 => 0
wm8962 0-001a: read 1a => 0
wm8962 0-001a: read 1a => 0
wm8962 0-001a: read 19 => 0
wm8962 0-001a: read 19 => 0
wm8962 0-001a: read 19 => 0
wm8962 0-001a: read 19 => 0
wm8962 0-001a: read 19 => 0
wm8962 0-001a: read 26 => 8
wm8962 0-001a: read 25 => 8
wm8962 0-001a: read 30 => ffffffff
wm8962 0-001a: read 30 => ffffffff
wm8962 0-001a: read 300 => 1c00
wm8962 0-001a: read 17 => 160
wm8962 0-001a: read 48 => 0
wm8962 0-001a: read 8 => ffffffff
wm8962 0-001a: read 52 => 4
wm8962 0-001a: read 19 => 0
wm8962 0-001a: write a0 = 149
wm8962 0-001a: write a1 = 271
wm8962 0-001a: write a2 = 7
wm8962 0-001a: FLL configured for 24000000Hz->11289600Hz
wm8962 0-001a: No audio clocks configured
...
imx-wm8962 sound.14:  wm8962 <-> 2028000.ssi mapping ok

root@freescale /home$ ./aplay Front_Left.wav
wm8962 0-001a: hw_params set BCLK 1411200Hz LRCLK 44100Hz
wm8962 0-001a: wm8962->sysclk_rate = 11289600
wm8962 0-001a: wm8962->lrclk = 44100
wm8962 0-001a: Selected sysclk ratio 256
wm8962 0-001a: read 4 => ffffffff
wm8962 0-001a: Failed to read DSPCLK: -1
wm8962 0-001a: read 3 => 100
wm8962 0-001a: write 3 = 100
wm8962 0-001a: ASoC: POST_PMU: HPOUTR PGA event failed: -5
wm8962 0-001a: read 29 => 100
wm8962 0-001a: write 29 = 100
wm8962 0-001a: ASoC: POST_PMU: SPKOUTR PGA event failed: -5
wm8962 0-001a: read 2 => 100
wm8962 0-001a: write 2 = 100
wm8962 0-001a: ASoC: POST_PMU: HPOUTL PGA event failed: -5
wm8962 0-001a: read 28 => 100
wm8962 0-001a: write 28 = 100
wm8962 0-001a: ASoC: POST_PMU: SPKOUTL PGA event failed: -5
wm8962 0-001a: read 42 => ffffffff
wm8962 0-001a: Failed to read DCS status: -1
wm8962 0-001a: DC servo complete after 1ms
Playing WAVE 'Front_Left.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono

Any idea of why register 4 and 42 read fails?
wm8962 0-001a: read 4 => ffffffff
wm8962 0-001a: Failed to read DSPCLK: -1

wm8962 0-001a: read 42 => ffffffff
wm8962 0-001a: Failed to read DCS status: -1

Any suggestion is appreciated.

Thanks,

Fabio Estevam
