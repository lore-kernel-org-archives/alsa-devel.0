From: Daniel Mack <daniel@caiaq.de>
Subject: Re: PXA SSP - work in progress
Date: Fri, 13 Mar 2009 18:15:03 +0100
Message-ID: <20090313171503.GJ32760@buzzloop.caiaq.de>
References: <20090313143720.GC8989@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 00F49103801
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 18:15:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090313143720.GC8989@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Mar 13, 2009 at 02:37:24PM +0000, Mark Brown wrote:
> I worked a bit on the PXA SSP code last night and was able to come up
> with a configuration which uses non-network mode for I2S and works well
> on the Zylonite.  I'll post the current series I have in a followup to
> this, if you could take a look that'd be great - I haven't yet worked
> through all the testing I'd like to do.
> 
> Unfortunately it's going to have broken Daniel's configuration since I
> inverted the sense of LRCLK as the chip seemed not to generate an LRCLK
> with a non-zero frame delay; I need to check to see if this is just
> something I've overlooked.  Hopefully Daniel's system should just have
> inverted the left and right channels.

I can confirm that my board still works with your latest patches, so I'm
fine with your changes :) And indeed - the channels were inverted, I
didn't check that before as it wasn't my greatest concern ...

Thanks,
Daniel
