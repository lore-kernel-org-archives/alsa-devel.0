From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix Analog capture path
	for AUXR
Date: Tue, 19 May 2009 10:57:22 +0100
Message-ID: <20090519095722.GA26649@rakim.wolfsonmicro.main>
References: <1242719463-17508-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242719463-17508-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090519085006.GA24884@rakim.wolfsonmicro.main>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056A1739@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0203246C1
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 11:57:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056A1739@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2009 at 03:18:09PM +0530, Aggarwal, Anuj wrote:
> What should be the quickest way to merge all the ASoC patches which have come after my 2.6.29-rc3 release? I have a found a solution for my tuck noise problem now but cannot apply the patch as it is, because the tip has moved ahead from my baseline by several commits. I cannot move my baseline so have to pull only sound/soc related patches.

> Is there any repository where I will find only asoc related patches? Or what should be the ideal way to handle this?

You want the topic/asoc branch of:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

That'll have some additional stuff from mainline due to some merge ups
of ALSA-wide stuff but it should all be safe given that it's targetting
2.6.30.
