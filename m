From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: Adding wm8962 support to mx6qsabresd
Date: Thu, 20 Dec 2012 14:21:45 +0800
Message-ID: <20121220062144.GB24134@S2101-09.ap.freescale.net>
References: <CAOMZO5BLH-r77EMduGz7jOQVQcFyvW721UEiHY+sE1d7T4mwVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E3426265018
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 07:21:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOMZO5BLH-r77EMduGz7jOQVQcFyvW721UEiHY+sE1d7T4mwVA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Gary Zhang <b13634@freescale.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Fabio,

FSL internal development team has got it work on kernel 3.5.  You can
talk to Gary (Cc-ed) for details and upstreaming plan.

Shawn

On Wed, Dec 19, 2012 at 02:33:58PM -0200, Fabio Estevam wrote:
> Hi,
> 
> I am working on adding audio support to mx6qsabresd board, which
> contains a wm8962 codec.
> 
> Here is the log with debug information turned on that I am getting so far:
> 
> wm8962 0-001a: customer id 0 revision D
> wm8962 0-001a: read 25 => 8
> wm8962 0-001a: read 25 => 8
> wm8962 0-001a: read 25 => 8
> wm8962 0-001a: read 25 => 8
> wm8962 0-001a: read 26 => 8
> wm8962 0-001a: read 26 => 8
> wm8962 0-001a: read 26 => 8
> wm8962 0-001a: read 26 => 8
> wm8962 0-001a: read 22 => 9
> wm8962 0-001a: read 22 => 9
> wm8962 0-001a: read 22 => 9
> wm8962 0-001a: read 22 => 9
> wm8962 0-001a: read 22 => 9
> wm8962 0-001a: read 22 => 9
> wm8962 0-001a: read 3a => 0
> wm8962 0-001a: read 3a => 0
> wm8962 0-001a: read 39 => 0
> wm8962 0-001a: read 39 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 64 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 65 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 69 => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 6a => 0
> wm8962 0-001a: read 200 => ffffffff
> wm8962 0-001a: read 201 => 0
> wm8962 0-001a: read 202 => 0
> wm8962 0-001a: read 203 => ffffffff
> wm8962 0-001a: read 204 => 8100
> wm8962 0-001a: read 205 => 8100
> wm8962 0-001a: DMIC not in use, disabling
> input: WM8962 Beep Generator as
> /devices/soc.0/2100000.aips-bus/21a0000.i2c/i2c-0/0-001a/input/input0
> wm8962 0-001a: read 31 => ffffffff
> wm8962 0-001a: read 31 => ffffffff
> wm8962 0-001a: read 1a => 0
> wm8962 0-001a: read 1a => 0
> wm8962 0-001a: read 63 => 0
> wm8962 0-001a: read 63 => 0
> wm8962 0-001a: read 1a => 0
> wm8962 0-001a: read 1a => 0
> wm8962 0-001a: read 63 => 0
> wm8962 0-001a: read 63 => 0
> wm8962 0-001a: read 1a => 0
> wm8962 0-001a: read 1a => 0
> wm8962 0-001a: read 19 => 0
> wm8962 0-001a: read 19 => 0
> wm8962 0-001a: read 19 => 0
> wm8962 0-001a: read 19 => 0
> wm8962 0-001a: read 19 => 0
> wm8962 0-001a: read 26 => 8
> wm8962 0-001a: read 25 => 8
> wm8962 0-001a: read 30 => ffffffff
> wm8962 0-001a: read 30 => ffffffff
> wm8962 0-001a: read 300 => 1c00
> wm8962 0-001a: read 17 => 160
> wm8962 0-001a: read 48 => 0
> wm8962 0-001a: read 8 => ffffffff
> wm8962 0-001a: read 52 => 4
> wm8962 0-001a: read 19 => 0
> wm8962 0-001a: write a0 = 149
> wm8962 0-001a: write a1 = 271
> wm8962 0-001a: write a2 = 7
> wm8962 0-001a: FLL configured for 24000000Hz->11289600Hz
> wm8962 0-001a: No audio clocks configured
> ...
> imx-wm8962 sound.14:  wm8962 <-> 2028000.ssi mapping ok
> 
> root@freescale /home$ ./aplay Front_Left.wav
> wm8962 0-001a: hw_params set BCLK 1411200Hz LRCLK 44100Hz
> wm8962 0-001a: wm8962->sysclk_rate = 11289600
> wm8962 0-001a: wm8962->lrclk = 44100
> wm8962 0-001a: Selected sysclk ratio 256
> wm8962 0-001a: read 4 => ffffffff
> wm8962 0-001a: Failed to read DSPCLK: -1
> wm8962 0-001a: read 3 => 100
> wm8962 0-001a: write 3 = 100
> wm8962 0-001a: ASoC: POST_PMU: HPOUTR PGA event failed: -5
> wm8962 0-001a: read 29 => 100
> wm8962 0-001a: write 29 = 100
> wm8962 0-001a: ASoC: POST_PMU: SPKOUTR PGA event failed: -5
> wm8962 0-001a: read 2 => 100
> wm8962 0-001a: write 2 = 100
> wm8962 0-001a: ASoC: POST_PMU: HPOUTL PGA event failed: -5
> wm8962 0-001a: read 28 => 100
> wm8962 0-001a: write 28 = 100
> wm8962 0-001a: ASoC: POST_PMU: SPKOUTL PGA event failed: -5
> wm8962 0-001a: read 42 => ffffffff
> wm8962 0-001a: Failed to read DCS status: -1
> wm8962 0-001a: DC servo complete after 1ms
> Playing WAVE 'Front_Left.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
> 
> Any idea of why register 4 and 42 read fails?
> wm8962 0-001a: read 4 => ffffffff
> wm8962 0-001a: Failed to read DSPCLK: -1
> 
> wm8962 0-001a: read 42 => ffffffff
> wm8962 0-001a: Failed to read DCS status: -1
> 
> Any suggestion is appreciated.
> 
> Thanks,
> 
> Fabio Estevam
