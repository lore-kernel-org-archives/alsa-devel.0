From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: kirkwood: extend the kirkwood pcm/dma
	driver for	DT usage
Date: Tue, 23 Jul 2013 14:23:14 +0100
Message-ID: <20130723132314.GU24642@n2100.arm.linux.org.uk>
References: <20130723104641.6ee0b9ec@armhf>
 <20130723125756.GZ9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1E8F226501B
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:23:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130723125756.GZ9858@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 01:57:56PM +0100, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 10:46:41AM +0200, Jean-Francois Moine wrote:
> 
> > +- compatible: "marvell,mvebu-pcm-audio"
> > +
> > +Example:
> > +
> > +pcm: pcm {
> > +	compatible = "marvell,mvebu-pcm-audio";
> > +};
> 
> This device has no registers or other hardware - this looks like a stub
> device which shouldn't be visible in DT but should instead be created by
> the I2S driver - look at how most of the other DT platforms using
> dmaengine work.

There is no separate DMA engine on this platform.  dmaengine is totally
irrelevant to this hardware.
