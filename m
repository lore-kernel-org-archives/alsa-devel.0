From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
Date: Mon, 8 Jul 2013 09:19:24 +0200
Message-ID: <20130708071924.GP16871@s25.your-server.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
 <20130703161727.GS27646@sirena.org.uk>
 <20130707071949.GH16871@s25.your-server.de>
 <CAOMZO5CLWfoQE-9srT8e2kLn3A=iHhk-TbXytV+pdZVaaHwoNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 14110265230
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 09:19:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CLWfoQE-9srT8e2kLn3A=iHhk-TbXytV+pdZVaaHwoNg@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Sun, Jul 07, 2013 at 10:16:30AM -0300, Fabio Estevam wrote:
> Hi Markus,
> 
> On Sun, Jul 7, 2013 at 4:19 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > There are no pinctrl driver for imx27(pca100) or imx35(pcm043). The
> 
> For mx35 pinctrl driver is at drivers/pinctrl/pinctrl-imx35.c
> 

Thank you.

I will create some pinctrl bindings for pcm043. But I am not sure what
to do with pca100 reset functions.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
