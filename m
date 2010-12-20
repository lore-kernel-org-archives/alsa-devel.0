From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] ASoC: SMDK6450: Enable I2S device
Date: Mon, 20 Dec 2010 13:43:21 +0000
Message-ID: <20101220134321.GG26706@rakim.wolfsonmicro.main>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
	<1292810751-30064-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58F5E245C1
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 14:43:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292810751-30064-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi@opensource.wolfsonmicro.com, "Brar <jassisinghbrar"@gmail.com
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 11:05:51AM +0900, Jassi@opensource.wolfsonmicro.com wrote:

>  config ASOC_SAMSUNG_SMDK_WM8580
>  	tristate "SoC I2S Audio support for WM8580 on SMDK"
> -	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440)
> +	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450)

Might be worth adding a HAS_SMDK_WM8580 or something that the machines
can select otherwise this line couldget very long.
