From: Jyri Sarha <oku@iki.fi>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Thu, 12 Sep 2013 14:34:13 +0300
Message-ID: <62c9342f91e99fa5d421a7ad29fbf354@kapsi.fi>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
 <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
 <20130912110800.GI29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kapsi.fi (mail.kapsi.fi [217.30.184.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 6160C261675
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:34:17 +0200 (CEST)
In-Reply-To: <20130912110800.GI29403@sirena.org.uk>
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
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, Joel Fernandes <joelf@ti.com>, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 2013-09-12 14:08, Mark Brown wrote:
> On Wed, Sep 11, 2013 at 02:48:19PM +0300, Jyri Sarha wrote:
...
> However, after taking a another look at the added DT bindings, I think
> we could survive with mcasp dma register addresses only for now. To my
> understanding those are anyway need in mcasp node. In DT boot the
> mcasp EDMA event queue could be hardcoded to the highest priority for
> now.
> 
> How does this sound?
> 
> I'm not clear what that means in concrete terms, sorry.  Do you mean 
> you
> can just use the existing register ranges for the McASP?  Please bear 
> in
> mind that I don't really know anything about this hardware.

The bottom line of my suggestion is only to add the dma register 
location
to reg-property, since that info is needed in the mcasp node also in the
future dmaengine_pcm-implementation.

The driver implementation would still remain pretty much the same. The 
McASP
code would - instead of adding new properties to DT - use sensible 
hard-coded
default event queue selection (= dma priority selection) for now.

Best regards,
Jyri
