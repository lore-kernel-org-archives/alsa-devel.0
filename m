From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] ASoC: Revert "ASoC: SAMSUNG: Add I2S0
	internal dma driver"
Date: Thu, 11 Aug 2011 15:24:36 +0900
Message-ID: <014501cc57ef$5ab76370$10262a50$%kim@samsung.com>
References: <1311266209-14505-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<039f01cc4828$34618600$9d249200$@com>
	<20110722095407.GH23192@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 5277D243FA
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 08:24:48 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LPR00A6Q336SVE0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 11 Aug 2011 15:24:42 +0900 (KST)
Received: from kgenekim ([12.23.119.139])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LPR00HGB355YA@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 11 Aug 2011 15:24:42 +0900 (KST)
In-reply-to: <20110722095407.GH23192@opensource.wolfsonmicro.com>
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
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Sangbeom Kim' <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, 'Jassi Brar' <jassisinghbrar@gmail.com>, 'Liam Girdwood' <lrg@ti.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> 
> On Fri, Jul 22, 2011 at 01:31:19PM +0900, Sangbeom Kim wrote:
> 
> > Currently, There is no topic branch for idma on Kukjin's tree.
> > So If you need it, You need to merge next-samsung-devel branch on
Kukjin's
> > tree.
> > But It have many other Samsung stuff.
> > What should I do?
> 
> Since it's already in git history I'll try to remember to reapply it
> after -rc1 is out and Kukjin's tree has been merged over.

Hi Mark,

Now, happens following with some Samsung's defconfigs...

sound/soc/samsung/i2s.c:24: fatal error: idma.h: No such file or directory
compilation terminated.
make[3]: *** [sound/soc/samsung/i2s.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2

So it's time to re-apply it in your tree and would be nice to me if you
could make some branch for it so that I can merge it to test  with other
Samsung stuff until being it in mainline.

And is it possible to apply for v3.1? Because this should be in mainline
v3.1 stable for working Samsung i2s.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
