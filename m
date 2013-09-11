From: Jyri Sarha <oku@iki.fi>
Subject: Re: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA
 related properties from DT
Date: Wed, 11 Sep 2013 14:48:19 +0300
Message-ID: <d56ff517b8d6e29af7639665bb17c1bb@kapsi.fi>
References: <cover.1378738436.git.jsarha@ti.com>
 <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
 <20130909152559.GM29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kapsi.fi (mail.kapsi.fi [217.30.184.167])
 by alsa0.perex.cz (Postfix) with ESMTP id C64D7260890
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 13:48:22 +0200 (CEST)
In-Reply-To: <20130909152559.GM29403@sirena.org.uk>
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

On 2013-09-09 18:25, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 06:12:14PM +0300, oku@iki.fi wrote:
> From: Jyri Sarha <jsarha@ti.com>
> 
> This patch adds new DMA related properties to mcasp DT bindings. The
> new properties may not be needed after davinci audio is updated to use
> dmaengine.
> 
> How hard is it going to be to convert to dmaengine or to open code
> something that works with the standard bindings even if the
> implementation is open coded?  I'm not enthusiastic about adding
> temporary bindings, I'm not sure the DT maintainers would be either.

I have not studied the code enough to give a good work estimate about
the conversion, but at least the current EDMA driver would need cyclic
mode to be implemented before the conversion would be possible. It may
also be difficult to make sure all the old davinci HW using the same
code would still work after the change. In any case I do not think the
conversion is going to be made anytime soon (read: in time for v3.13).

However, after taking a another look at the added DT bindings, I think
we could survive with mcasp dma register addresses only for now. To my
understanding those are anyway need in mcasp node. In DT boot the
mcasp EDMA event queue could be hardcoded to the highest priority for
now.

How does this sound?

Best regards,
Jyri
