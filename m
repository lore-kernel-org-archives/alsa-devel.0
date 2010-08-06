From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: S3C64XX: Add ADC source clock
	setting
Date: Fri, 6 Aug 2010 11:26:19 +0100
Message-ID: <20100806102619.GC398@rakim.wolfsonmicro.main>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054064-4730-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 05DDD24159
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 12:26:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281054064-4730-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 06, 2010 at 09:21:04AM +0900, Seungwhan Youn wrote:
> This patch adds ADC source clock setting to set wm8580 use ADC
> source clock to ADC_MCLK.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  sound/soc/s3c24xx/smdk64xx_wm8580.c |    6 ++++++

This isn't a patch for S3C64xx, this is a patch for the SMDK boards.
