From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Revert "ASoC: SAMSUNG: Add I2S0
	internal dma driver"
Date: Fri, 22 Jul 2011 13:31:19 +0900
Message-ID: <039f01cc4828$34618600$9d249200$@com>
References: <1311266209-14505-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 933FA1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 06:31:23 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LOP00208WK8BEK0@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 22 Jul 2011 13:31:20 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.119.77])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LOP00LYGWK81X@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 22 Jul 2011 13:31:20 +0900 (KST)
In-reply-to: <1311266209-14505-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>
Cc: =?ks_c_5601-1987?B?J7HosbnB+Cc=?= <kgene.kim@samsung.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 22/07/11 1:37 AM, Mark Brown wrote: 
> This reverts commit d7c3e9525ac8e898f1156a1f3a7c5038f6560186 as it does
> not currently build due to missing dependencies in the Samsung tree.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

(Cc'ed Kukjin Kim on this)

I'm sorry that I  missed the clarification of code dependency.
I will try to clarify code dependency in the next time.

idma code have dependency on 
ARM: SAMSUNG: Add IRQ_I2S0 definition
(commit ID: 2d21237e38120c2dfbc047b39aa2a56df67bdeec)
ARM: SAMSUNG: Add platform device for idma 
(commit ID: 2839cc1e7e1f260afc5cf9fb6be5b6c3e9d85fea)

Above 2 commits had already merged on Kukjin kim's tree and then
Merged on arm-soc.
Currently, There is no topic branch for idma on Kukjin's tree.
So If you need it, You need to merge next-samsung-devel branch on  Kukjin's
tree.
But It have many other Samsung stuff.
What should I do?

Thanks,
SB Kim
