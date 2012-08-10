From: Dong Aisheng <b29396@freescale.com>
Subject: Re: Error with "Unsigned 8 bit, Rate 8000 Hz,
	Mono" track
Date: Fri, 10 Aug 2012 19:00:05 +0800
Message-ID: <20120810110004.GA7142@shlinux2.ap.freescale.net>
References: <CAOMZO5Dc38HSZRXFeZ-55KN83v1NNPCAAuoiFdixJ0K2dw90vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FFF2265322
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 12:46:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dc38HSZRXFeZ-55KN83v1NNPCAAuoiFdixJ0K2dw90vg@mail.gmail.com>
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
Cc: Shawn Guo <shawn.guo@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 10, 2012 at 12:25:13PM +0800, Fabio Estevam wrote:
> Hi,
> 
> Running 3.6-rc1 on a mx28evk I get the following error with this wav format:
> 
> root@freescale /home$ aplay k3b_error1.wav
> Playing WAVE 'k3b_error1.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> [  303.640000] asoc: machine hw_params failed: -22
It failed at here:
/* Sgtl5000 sysclk should be >= 8MHz and <= 27M */
if (mclk < 8000000 || mclk > 27000000)
	return -EINVAL;

Since sgtl5000 on slave mode, the mclk can only be 256*fs, 384*fs, 512*fs,
the maximum mclk of 8Khz 4096000(512 * 8000) < 8Mhz, it does not meet
the minimum clock requirement of mclk.
It looks like hw limitation on slave mode.

Will spend some time double check if any solution for this later.
If anyone else know it, please share the comments.

Regards
Dong Aisheng

> aplay: set_params:959: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  U8
> SUBFORMAT:  STD
> SAMPLE_BITS: 8
> FRAME_BITS: 8
> CHANNELS: 1
> RATE: 8000
> PERIOD_TIME: 125000
> PERIOD_SIZE: 1000
> PERIOD_BYTES: 1000
> PERIODS: 4
> BUFFER_TIME: 500000
> BUFFER_SIZE: 4000
> BUFFER_BYTES: 4000
> TICK_TIME: 0
> 
> Haven't started debugging yet, but if anyone sees something obvious,
> please let me know.
> 
> This same file plays correctly on mx31/mx27/mx51/mx6q boards.
> 
> Regards,
> 
> Fabio Estevam
> 
