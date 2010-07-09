From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Fri, 09 Jul 2010 10:06:56 +0900
Message-ID: <4C367630.3090607@samsung.com>
References: <4C355AC2.8090502@samsung.com>
	<AANLkTikHkQfmD5GPL9D-kbL7SuNksNA9tbhvoDqBeuur@mail.gmail.com>
	<4C358807.1000502@samsung.com>
	<AANLkTinKT2LvSrfcI2-aw2iXnnCe1R_jCfq09rxlNa3x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FC2024404
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 03:06:59 +0200 (CEST)
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L59000TJN3KUH90@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 09 Jul 2010 10:06:56 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5900E5UN3KGI@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 09 Jul 2010 10:06:56 +0900 (KST)
In-reply-to: <AANLkTinKT2LvSrfcI2-aw2iXnnCe1R_jCfq09rxlNa3x@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
 > The gpio config stuff needs to be removed from the CPU driver. It was pending
> due to fear of cross-tree merge issues. The platform specific code to do the
> same is already upstream now.

What is "platform specific code to the same" ?

> One engineer in my team is already looking into it while testing
> Liam's multi-codec
> changes.
> 
>>> Please try to use the existing sound/soc/s3c24xx/s3c64xx-i2s-v4.c
> 'try to' is the key word here. The driver is not expected to work rightaway.
> One might need to make some changes to the CPU driver to just make it
> work on platforms with very similar IP.

Do you mean that I should implement i2sv5 drvier refer to the 
sound/soc/s3c24xx/s3c64xx-i2s-v4.c after completing cross-tree merge issue? 

Thank you,
Chanwoo Choi
