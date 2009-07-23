From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Allow passing platform_data to devices
 attached to AC97 bus
Date: Thu, 23 Jul 2009 11:31:25 +0100
Message-ID: <20090723103125.GC6673@rakim.wolfsonmicro.main>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907212151.05301.marek.vasut@gmail.com>
	<20090722104029.GC21171@rakim.wolfsonmicro.main>
	<200907221259.13644.marek.vasut@gmail.com>
	<20090723101654.GA6673@rakim.wolfsonmicro.main>
	<s5h7hxzzo9y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A445E1039E5
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 12:31:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7hxzzo9y.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 12:28:41PM +0200, Takashi Iwai wrote:

> Feel free to take it into your tree.  The core (ac97) change is used
> only by ASoC as now, and above all, it doesn't break anything else.

OK, applied now.
