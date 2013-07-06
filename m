From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for
	imx-pcm-fiq
Date: Sat, 6 Jul 2013 19:13:23 +0200
Message-ID: <20130706171323.GG16871@s25.your-server.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
 <20130703160637.GQ27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 12A0B265090
 for <alsa-devel@alsa-project.org>; Sat,  6 Jul 2013 19:13:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130703160637.GQ27646@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Jul 03, 2013 at 05:06:37PM +0100, Mark Brown wrote:
> On Thu, Jun 20, 2013 at 03:20:23PM +0200, Markus Pargmann wrote:
> 
> > +	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
> > +
> 
> This binding should be documented.  I'm not sure it really needs to be
> a binding, though - is it not possible for the driver to just figure out
> that DMA won't work automatically (for example by looking at the CODEC
> in use)?  I'm not sure this is a good name either, it should be saying
> why the FIQ is needed rather than saying that we should use the FIQ.

I think fsl_ssi_startup is the first function in which we know which
codec is connected to fsl-ssi. There we have access to the pcm runtime,
which stores the codec used. But that is too late for the ssi setup.

I could use of_find_compatible_node to search for the wm9712 codec, but
that would assume that there is only one codec attached to the system.

Perhaps "fsl,fiq-filter-codec-stream" is a better name for the binding?

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
