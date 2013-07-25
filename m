From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] ASoc: kirkwood: merge kirkwood-i2c and
	kirkwood-dma
Date: Thu, 25 Jul 2013 23:58:16 +0100
Message-ID: <20130725225816.GG24642@n2100.arm.linux.org.uk>
References: <20130725111428.419ee278@armhf>
 <20130725191604.GQ9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 88F7E2610AF
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 00:58:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130725191604.GQ9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 08:16:04PM +0100, Mark Brown wrote:
> On Thu, Jul 25, 2013 at 11:14:28AM +0200, Jean-Francois Moine wrote:
> > To avoid the declaration of a 'kirkwood-pcm-audio' device in the DT,
> > this patch merges the kirkwood-i2c and kirkwood-dma drivers into one
> > module.
> 
> This seems mostly fine, though it may be best to keep kirkwood-dma as a
> separate module for the benefit of the S/PDIF support when it gets added
> - I had a look at the implementation Russell has and it looks like it
> can be added as a separate interface.

You wouldn't want I2S and SPDIF to be separate modules though - they're
the same hardware but different output stream formatters attached to the
DMA FIFO output.  Don't forget the requirements concerning the simultaneous
use of I2S and SPDIF - these "output formatters" must both be enabled and
disabled in unison when concurrent use is required - both bits must be
set or cleared together with a single register write.

> > -	.platform_name = "kirkwood-pcm-audio",
> > +	.platform_name = "kirkwood-i2s",
> 
> Should the name be done as dev_name() for the interface (I don't know if
> there is ever more than one)?

Getting away from "kirkwood-i2s" would be sensible, because it may not be
just "i2s" in this hardware block.  The documentation calls this an "audio
controller" but I guess "kirkwood-pcm" would be a reasonable compromise,
even though it has a separate AC'97 block which could also be construed
as being "pcm".

The AC'97 block uses a separate peripheral DMA controller and so wouldn't
make use of kirkwood-dma.c either.
