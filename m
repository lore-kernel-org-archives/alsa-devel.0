From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Revert "ASoC: SAMSUNG: Add I2S0
	internal dma driver"
Date: Thu, 21 Jul 2011 19:05:03 +0100
Message-ID: <4E286A4F.2060501@ti.com>
References: <1311266209-14505-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 73633103823
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 20:05:11 +0200 (CEST)
In-Reply-To: <1311266209-14505-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sangbeom Kim <sbkim73@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 21/07/11 17:36, Mark Brown wrote:
> This reverts commit d7c3e9525ac8e898f1156a1f3a7c5038f6560186 as it does
> not currently build due to missing dependencies in the Samsung tree.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/Makefile |    2 -
>  sound/soc/samsung/idma.c   |  453 --------------------------------------------
>  sound/soc/samsung/idma.h   |   26 ---
>  3 files changed, 0 insertions(+), 481 deletions(-)
>  delete mode 100644 sound/soc/samsung/idma.c
>  delete mode 100644 sound/soc/samsung/idma.h
> 

Acked-by: Liam Girdwood <lrg@ti.com>

Sangbeom, please do let us know of any dependencies in future patches.

Thanks

Liam
