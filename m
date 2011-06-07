From: Timur Tabi <timur@freescale.com>
Subject: Re: Something broke in snd_soc_pcm_stream
Date: Tue, 7 Jun 2011 17:20:25 -0500
Message-ID: <4DEEA429.6040605@freescale.com>
References: <4DEE98C8.2010706@freescale.com>
	<20110607214442.GB7712@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from CH1EHSOBE013.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id CCC2D103803
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 00:20:31 +0200 (CEST)
In-Reply-To: <20110607214442.GB7712@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> I don't think this is a bug in the core, relying on the having things
> partially initialised in a particular order seems overly fragile -
> better to check for the thing you're actually looking for.  There wasn't
> a deliberate change I can think of here, though.

I think it's because you test the codec_dai in soc_new_pcm(), which seems weird.
 I put some printks in this function, and this is what I got:

soc_new_pcm:2132 codec_dai=e6998840
soc_new_pcm:2133 codec_dai->driver->playback.channels_min=2
soc_new_pcm:2134 codec_dai->driver->capture.channels_min=0
soc_new_pcm:2136 cpu_dai->driver->playback.channels_min=2
soc_new_pcm:2137 cpu_dai->driver->capture.channels_min=2
soc_new_pcm:2144 playback=1
soc_new_pcm:2145 capture=0
soc_new_pcm:2173 platform->driver->pcm_new=c0329fd0
soc_new_pcm:2176
fsl_dma_new:305 dai->driver->playback.channels_min=2
fsl_dma_new:306 dai->driver->capture.channels_min=2
fsl_dma_new:329 pcm=e69aae00
fsl_dma_new:330 pcm->streams[1].substream=  (null)

It just so happens that on the the P1022, the CPU does support both directions
in its DAI, but the codec (WM8776) supports only one direction per DAI.  So I
suspect that you shouldn't be testing codec_dai either, because it assumes that
the codec is the only arbiter on which direction a given dai-group supports.

Anyway, I changed my driver to test for the actual pointer, and it works.  You
might want to consider doing the same in soc_pcm_new().

-- 
Timur Tabi
Linux kernel developer at Freescale
