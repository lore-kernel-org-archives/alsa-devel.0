From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 3/8] ASoC: fsl-ssi: Add imx50-ssi and
 of_device_id matching
Date: Wed, 20 Nov 2013 14:30:05 +0100
Message-ID: <20131120133005.GB10603@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-4-git-send-email-mpa@pengutronix.de>
 <20131120124500.GC22308@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 216772616E1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 14:30:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131120124500.GC22308@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

On Wed, Nov 20, 2013 at 08:45:01PM +0800, Shawn Guo wrote:
> On Wed, Nov 20, 2013 at 10:04:17AM +0100, Markus Pargmann wrote:
> > There is a small but significant difference between imx21-ssi and
> > imx50-ssi and above.
> 
> Markus,
> 
> Sorry, I did not point it out in the last review.  But SoC imx51 came
> out earlier than imx50, so I think imx51-ssi should be used instead as
> compatible.

Ah, I didn't know imx51 was released earlier. I will replace imx50-ssi
with imx51-ssi.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
