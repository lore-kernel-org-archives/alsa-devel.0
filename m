From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH 1/5] ASoC: Convert H1940 to table based init
Date: Mon, 10 Oct 2011 19:03:34 +0900
Message-ID: <016001cc8733$df55dd50$9e0197f0$@com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 128B22448E
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 12:03:41 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LSU000N9H9TH0X0@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 10 Oct 2011 19:03:35 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.120.118])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LSU003JKH9ZJ830@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Mon, 10 Oct 2011 19:03:35 +0900 (KST)
In-reply-to: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Sun, Oct 09, 2011 at 07:28PM, Mark Brown wrote:
Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Minor question:
Is there any reason for adding new line?
> +
> +	.dapm_widgets = uda1380_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(uda1380_dapm_widgets),
> +	.dapm_routes = audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(audio_map),
>  };
> 
>  static int __init h1940_init(void)
> --
> 1.7.6.3
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
