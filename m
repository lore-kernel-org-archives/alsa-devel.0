From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 3/3] ASoC: OMAP: Enhance OMAP1510 DMA
	progress software counter
Date: Mon, 10 Aug 2009 11:43:25 +0200
Message-ID: <200908101143.26542.jkrzyszt@tis.icnet.pl>
References: <200908101050.08074.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D88C02476D
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 11:44:00 +0200 (CEST)
In-Reply-To: <200908101050.08074.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Monday 10 August 2009 10:50:06 Janusz Krzysztofik wrote:
> Enhance period index accuracy, particularly just before buffer rewind, by
> making use of DMA interrupt status flags in addition to simply counting
> interrupts

Sorry, this one is still buggy an can break other OMAP models. Please, do not 
apply, but wait for next version. However, comments are welcome.

The bug hits when multiple interrupt flags are set in parallel.

Thanks,
Janusz
