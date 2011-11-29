From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Fix __iomem annotation for IDMA
	registers
Date: Wed, 30 Nov 2011 08:48:56 +0900
Message-ID: <00c701ccaef1$75232290$5f6967b0$@com>
References: <1322429769-1045-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id C860510393B
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 00:49:00 +0100 (CET)
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LVG00IU04SLD050@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 30 Nov 2011 08:48:54 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LVG0088N4TILK50@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Wed, 30 Nov 2011 08:48:54 +0900 (KST)
In-reply-to: <1322429769-1045-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 06:36 AM , Mark Brown wrote:
> We always store the register address as __iomem but pass it around as a
> plain void * which upsets sparse.

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom
