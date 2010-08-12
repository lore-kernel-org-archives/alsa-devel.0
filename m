From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Problem with MX27 ASoC audio
Date: Thu, 12 Aug 2010 14:56:25 +0200
Message-ID: <20100812125625.GA27749@pengutronix.de>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4085B103801
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 14:56:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 12, 2010 at 06:15:47PM +0800, Randolph Chung wrote:
> I have a target that uses iMX27(L) + tlv320aic3x. The kernel tree is
> HEAD of linux-arm from about a week ago.
> 
> Simple playback and recording (using aplay and arecord) work fine.
> However, I've run into a strange problem when both playback and
> capture streams are opened at the same time.
> 
> Consider the attached test program. The capture device is setup with a
> period time of 10ms, and the program reads samples in a loop. The
> expected result is that I get a sample every 10ms. This works fine if
> the playback device is *not* opened (more specifically, if the
> hw_params are not set). However if the playback device is opened (#if
> 1 code) then I get samples every 20ms, which seems very wrong.
> 
> I have tried using both DMA and FIQ ssi-pcm interfaces and both give
> the same strange result. With the FIQ driver, if I instrument the
> timer callback, the timer triggers every 10ms but there is only enough
> data every 20ms.
> 
> The codec is being driven with a 13MHz MCLK (output from MX27) and the
> BCLK and WCLK come from the codec. They seem to have the correct
> rates.
> 
> Any ideas? Can anybody else with MX27 hardware verify if my test
> program also fails on their target?

You should check the return values of the snd_pcm_hw_params_* functions.
At least snd_pcm_hw_params_set_channels fails because we currently only
support two channels. I'm not sure whether we can support one channel
mode without changes to the driver.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
