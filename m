From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PalmTX aSoC sound support
Date: Mon, 7 Jul 2008 13:29:25 +0100
Message-ID: <20080707122925.GD19240@rakim.wolfsonmicro.main>
References: <200807042126.29154.marek.vasut@gmail.com>
	<20080704202615.GB20719@sirena.org.uk>
	<200807050019.08444.marek.vasut@gmail.com>
	<200807050717.41965.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53EA024562
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 14:29:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807050717.41965.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 05, 2008 at 07:17:41AM +0200, Marek Vasut wrote:

> even better version of the previous one

> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

It might be best to merge this via the ARM tree since it depends on the
machine support which is still pending but the Kconfig should prevent
anyone actually trying to build it until that happens.
