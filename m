From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Question on snd_soc_dai_link
Date: Mon, 28 May 2007 13:19:37 +0100
Message-ID: <1180354777.5816.39.camel@a10072.wolfsonmicro.main>
References: <46575B3E.2020603@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 16E632471F
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 14:19:39 +0200 (CEST)
In-Reply-To: <46575B3E.2020603@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-05-25 at 16:55 -0500, Timur Tabi wrote:
> I have a question about these DAI structs for ASoC.
> 
> Let's take eti_b1_wm8731.c as an example.  It contains this structure:
> 
> static struct snd_soc_dai_link eti_b1_dai = {
> 	.name = "WM8731",
> 	.stream_name = "WM8731",
> 	.cpu_dai = &at91_i2s_dai[1],
> 	.codec_dai = &wm8731_dai,
> 	.init = eti_b1_wm8731_init,
> 	.ops = &eti_b1_ops,
> };
> 
> Notice that the .cpu_dai field is hard-coded to use the 2nd I2S device on the AT91.
> 
> The problem I'm having with this approach is that everything is hard-coded.  On PowerPC, 
> this approach doesn't work well, because we have a "device tree" that dictates what 
> devices are present on the SOC.
> 

Fwiw, ASoC was designed to only handle static DAI mappings between a
codec and SoC CPU. This is because the audio codec was never intended to
physically change DAI at runtime or be probed (most codecs don't support
any device readback). The DAI mapping between CPU and codec was constant
and always known to the machine driver.

Although, I can now see the need for a more dynamic approach for PowerPC
based systems. Btw, I'm not very familiar with PowerPC, would you be
able to point me at some example "device tree" initialisation code.

Liam
