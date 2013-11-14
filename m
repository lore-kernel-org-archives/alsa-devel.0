From: Matt Flax <flatmax@flatmax.org>
Subject: Re: SPI PCM capture device examples please
Date: Thu, 14 Nov 2013 12:01:17 +1100
Message-ID: <528420DD.6070506@flatmax.org>
References: <52836B6B.3070703@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by alsa0.perex.cz (Postfix) with ESMTP id C460326167D
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 02:02:30 +0100 (CET)
In-Reply-To: <52836B6B.3070703@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I guess that IIO support for ASLA is not on the cards ?

Matt

On 13/11/13 23:07, Matt Flax wrote:
> Hi there,
>
> Is it possible to write an ALSA driver for a device which already has 
> an SPI driver ?
>
> I have been trying to look for examples in the ALSA kernel source 
> tree, however all the drivers I have looked at use SPI to control the 
> codecs .... there must be an example where the codec uses SPI for PCM 
> data ?
>
> If someone is aware of any codecs which use SPI for PCM data can you 
> please link me to the example driver code ?
>
> The device I am interested in operates in slave SPI mode and only has 
> ADCs, so it only has one input SPI line (and other necessary lines, 
> such as clk). Its data sample rates are up to 1 M Hz.
>
> Here is a link to the SPI driver in question :
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/ad7476.c?id=HEAD 
>
>
> thanks
> Matt
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
