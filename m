From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 17:28:50 +0100
Message-ID: <20110916162850.GC23727@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<s5hwrd8jy68.wl%tiwai@suse.de> <4E736F9B.6080206@freescale.com>
	<4E7378E2.9050200@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 639FE2433D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:28:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7378E2.9050200@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 06:27:14PM +0200, Lars-Peter Clausen wrote:

> You mentioned in an earlyer mail that you can switch the sysclk rate at
> runtime. So setting the constraints based on the current sysclk rate won't
> really work. I think you need some mechanism to specify the supported rates on
> a per machine driver basis.

Yes, exactly.  It's not something the CODEC driver can do.
