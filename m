From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 06/11] ASoC: fsl-ssi: Setup generic imx dma params
Date: Sat, 13 Apr 2013 15:52:31 +0200
Message-ID: <20130413135231.GC4573@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-7-git-send-email-mpa@pengutronix.de>
 <5162306B.6090207@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5162306B.6090207@tabi.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 07, 2013 at 09:50:19PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >-		ret = of_property_read_u32_array(pdev->dev.of_node,
> >-					"fsl,ssi-dma-events", dma_events, 2);
> 
> Does this mean that the "fsl,ssi-dma-events" property is no longer used?

Yes, I just realized that it would break all platforms that do not have
a DMA driver with generic bindings yet. So I will instead still check
for this property in case 'dmas' is not set.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
