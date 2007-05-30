From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Wed, 30 May 2007 13:28:40 +0100
Message-ID: <1180528120.29590.42.camel@a10072.wolfsonmicro.main>
References: <46531097.5040600@freescale.com>
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
	<465B716F.7090908@freescale.com>
	<1180428790.5816.76.camel@a10072.wolfsonmicro.main>
	<465C6C81.2060105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FD324466
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 14:28:42 +0200 (CEST)
In-Reply-To: <465C6C81.2060105@freescale.com>
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

On Tue, 2007-05-29 at 13:10 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > Some codecs can only support a small range of sample rates e.g. 8k &
> > 48k, whilst your controller may support more. This just makes sure the
> > audio is set a rate the codec can handle, otherwise audio quality will
> > probably suffer.
> 
> What about boards where the codec does *not* dictate the available sample rates?  That is, 
> what if the SOC can't generate the frequencies necessary to drive the codec at all the 
> rates it supports?  The codec driver would then need to be told by the machine driver 
> which sample rates are going to be used.  When the codec driver is initialized, it needs 
> to set the snd_soc_codec.dai field to point to the codec's DAI, and that structure 
> contains the list of supported sample rates.
> 

ASoC creates a bitmask of supported sample rates from the DMA, I2S
controller and codec and then AND's them together. It then checks the
requested rate, etc against this bitmask before proceeding. This way the
whole audio system dictates the supported rate and not any single
component.

Liam
