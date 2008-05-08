From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [ALSA] soc - fsl_ssi.c fix "BUG:
	scheduling while	atomic"
Date: Thu, 08 May 2008 14:43:51 -0500
Message-ID: <482357F7.60602@freescale.com>
References: <20080508160112.GA17085@polina.dev.rtsoft.ru>
	<48235248.70305@freescale.com>
	<20080508194146.GA5816@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DE8B24786
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 21:43:56 +0200 (CEST)
In-Reply-To: <20080508194146.GA5816@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: avorontsov@ru.mvista.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Anton Vorontsov wrote:

> Are there any drawbacks of mdelay'ing? 

All I remember is that without the delay, it wouldn't work.  But that was a long
time ago, and I never revisited the issue, even after the silicon was updated.

> Since some silicons need this
> we'd better leave it then.

The 1.0 silicon is dead and won't work with this driver anyway.  We should still
leave it in for now, but I plan on doing thorough testing without it.  If the
driver still works, I'll remove it for ASoC V2.

-- 
Timur Tabi
Linux kernel developer at Freescale
