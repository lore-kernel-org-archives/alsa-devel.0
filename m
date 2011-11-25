From: =?ks_c_5601-1987?B?sei787n8?= <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Convert Samsung directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 14:22:39 +0900
Message-ID: <000b01ccab32$3fdfae40$bf9f0ac0$@com>
References: <1322088856-1920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 520DE103DFD
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 06:22:57 +0100 (CET)
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LV70083YAXNV4N0@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 25 Nov 2011 14:22:39 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LV700AYTAXRT730@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Fri, 25 Nov 2011 14:22:39 +0900 (KST)
In-reply-to: <1322088856-1920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 07:54:45 AM , Mark Brown wrote:

> Saves some boilerplate code.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/ac97.c                       |   12 +-----------
>  sound/soc/samsung/dma.c                        |   12 +-----------
>  sound/soc/samsung/i2s.c                        |   12 +-----------
>  sound/soc/samsung/idma.c                       |   12 +-----------
>  sound/soc/samsung/lowland.c                    |   12 +-----------
>  sound/soc/samsung/pcm.c                        |   12 +-----------
>  sound/soc/samsung/s3c2412-i2s.c                |   12 +-----------
>  sound/soc/samsung/s3c24xx-i2s.c                |   12 +-----------
>  sound/soc/samsung/s3c24xx_simtec_hermes.c      |   16 ++--------------
>  sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |   16 ++--------------
>  sound/soc/samsung/s3c24xx_uda134x.c            |   14 +-------------
>  sound/soc/samsung/smdk_wm8580pcm.c             |   14 +-------------
>  sound/soc/samsung/spdif.c                      |   12 +-----------
>  sound/soc/samsung/speyside.c                   |   12 +-----------
>  sound/soc/samsung/speyside_wm8962.c            |   12 +-----------
>  15 files changed, 17 insertions(+), 175 deletions(-)

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom
