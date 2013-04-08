From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 08/11] ASoC: fsl-ssi: imx ac97 support
Date: Sun, 07 Apr 2013 21:49:03 -0500
Message-ID: <5162301F.9090000@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-9-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id 012D626528F
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 04:49:06 +0200 (CEST)
In-Reply-To: <1365362721-3731-9-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> This patch copies some parts from imx-ssi to support AC97 on
> imx27-pca100 and imx27-pcm043. It is activated with a new fsl,imx-ac97
> bool property. It was tested on imx27-pca100.

I'm not crazy about this patch -- it seems a bit hackish.  There are too 
many "if (imx_ac97)" clauses.  Large pieces of code that don't appear to 
be related to AC97 are indented in an if-clause.  I especially don't like 
the "If we use AC97, the registers are already setup correctly".

-- 
Timur Tabi
