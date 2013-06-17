From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v8 00/11] ASoC: fsl-ssi: ac97-slave support
Date: Sun, 16 Jun 2013 23:05:53 -0500
Message-ID: <51BE8B21.8050605@tabi.org>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id 1C68E261663
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 06:05:59 +0200 (CEST)
In-Reply-To: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> Hi,
>
> This series adds DT support for phycore-ac97. Beside ac97 support, the series
> adds imx-pcm-fiq and generic DMA bindings to fsl-ssi.
>
> In version 8 I fixed the build issues by seperating the DT capable ac97 phycore
> driver from the old driver.

FYI, I get some warnings applying this patchset:

Applying: ASoC: Add phycore-ac97-dt driver
/home/b04825/git/linux.alsa2/.git/rebase-apply/patch:375: new blank line 
at EOF.
+
warning: 1 line adds whitespace errors.
Applying: ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
Applying: ASoC: fsl: Move fsl-ssi binding doc to sound/
Applying: ASoC: fsl: Update fsl-ssi binding doc
/home/b04825/git/linux.alsa2/.git/rebase-apply/patch:33: space before tab 
in indent.
   		    Only necessary for some boards with incompatible
warning: 1 line adds whitespace errors.

-- 
Timur Tabi
