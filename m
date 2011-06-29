From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] ASoC: Rename WM8915 to WM8996
Date: Wed, 29 Jun 2011 16:30:55 +0900
Message-ID: <07ce01cc362e$7fac3710$7f04a530$%kim@samsung.com>
References: <1309317832-24241-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id A23771038AD
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 09:31:09 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LNJ00NEIJIP20R0@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 29 Jun 2011 16:31:02 +0900 (KST)
Received: from kgenekim ([12.23.119.139])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LNJ000VDJJQ8N@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 29 Jun 2011 16:31:02 +0900 (KST)
In-reply-to: <1309317832-24241-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Mark Brown wrote:
> 
> For marketing reasons the part will be called WM8996. In order to avoid
> user confusion rename the driver to reflect this.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> The cross tree issues make this difficult to merge as there's
> dependencies in both ASoC and Samsung trees - Kukjin, would you be OK
> with merging this via ALSA late on in the merge window after both
> Samsung and ASoC trees have merged?
> 
Yes, it's ok to me :)

As a note, basically my tree will be sent to upstream via rmk during merge
window so I'm not sure when it is merged.

> I will have a go at constructing some branches which do the right thing
> and can be merged now (so a base rename patch then a merge of that into
> ASoC which deals with all the work that has been done in the driver this
> release cycle) but I wanted to get this first option out there now.
> 
>  arch/arm/mach-s3c64xx/mach-crag6410.c |   18 +-

If required,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
