From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC TDM channel re-mapping
Date: Mon, 17 Oct 2016 18:53:52 +0200
Message-ID: <d8b134c7-e871-39ed-defc-8a3c7875d56f@metafoo.de>
References: <20161017083634.GD13157@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A88AF266C21
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 18:53:53 +0200 (CEST)
In-Reply-To: <20161017083634.GD13157@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Edward Cragg <edward.cragg@codethink.co.uk>, alsa-devel@alsa-project.org
Cc: ts001-ct@extlists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

On 10/17/2016 10:36 AM, Edward Cragg wrote:
> Hi,
> 
> We have an ASoC driver in which we have added support for TDM over an I2S
> interface.
> 
> We would like to have the capability of re-mapping the channel ordering, for
> which i know there is a callback in place to start this process,
> set_channel_map.
> 
> The only backend implementation of this is using the ALSA API and the .copy
> handler in an ALSA PCM driver to mutate data copied out of ALSA before it's
> DMA'd to hardware. This is in sound/soc/blackfin/bf5xx-i2s-pcm.c
> 
> The problem we have is that the driver we're using currently uses a dmaengine
> based PCM driver, and i'm not sure whether this is compatible with using the
> .copy callback, without reimplementing the driver entirely as an ALSA PCM
> driver.
> 
> Since there aren't very many examples in mainline, I was hoping to ask for
> advice for the best way of doing this.
> 
> I wondered:
> 
>  - Would it be possible to add a functional copy callback using a dmaengine
>    based PCM driver?
>  - Otherwise, would there be a good way to implement channel remapping in a
>    TDM frame using the dmaengine based PCM driver?
>    or
>  - Would the best way indeed be to reimplement the PCM driver as a normal ALSA
>    PCM driver?

Does your hardware support re-mapping? Or is this something you want to do
in the same style as the blackfin driver by having the kernel shuffle all
the samples around? If it is the later I'd recommend to implement this in
userspace. The general idea for kernel drivers is to advertise the hardware
capabilities, but not go beyond them and emulate missing functionality since
this can have unexpected performance impacts. (And yes, the Blackfin driver
should have never been implemented the way it is)
