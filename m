From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 11/11] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Tue, 07 Jul 2009 12:14:17 -0700
Message-ID: <4A539E89.5090907@boundarydevices.com>
References: <1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-12-git-send-email-troy.kisky@boundarydevices.com>	<20090705130352.GE5334@sirena.org.uk>	<4A52A081.9070003@boundarydevices.com>	<20090707093132.GB14393@rakim.wolfsonmicro.main>
	<4A539CDE.20508@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id A257524441
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 21:14:18 +0200 (CEST)
In-Reply-To: <4A539CDE.20508@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Troy Kisky wrote:
> Mark Brown wrote:
> 
> Even when using SDRAM, there is still another advantage to double buffering.
> That is tolerating very long interrupt latency on dma completion. The current
> code sets up the next periods dma transfer on dma completion. This could easily
> lead to underruns. So, even in this case, I think double buffering is worth
> the extra dma engine copy.
> 
I overstated my case, it still would not "easily" happen.
