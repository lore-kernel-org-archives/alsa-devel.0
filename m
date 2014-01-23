From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Use gpio_is_valid()
Date: Thu, 23 Jan 2014 15:44:03 +0100
Message-ID: <20140123144403.GG25016@pengutronix.de>
References: <1390418657-5373-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4ADF4262618
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 15:44:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1390418657-5373-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Wed, Jan 22, 2014 at 05:24:17PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We could use gpio_is_valid() for doing the sanity check on the GPIO number.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This looks like the same patch as [1].

[1] http://thread.gmane.org/gmane.linux.alsa.devel/117668/focus=117669

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
