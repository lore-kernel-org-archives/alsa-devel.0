From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: OMAP: Don't try to set
 unsupported OMAP_DMA_DATA_BURST_16 on OMAP1
Date: Fri, 6 Nov 2009 11:17:50 +0000
Message-ID: <20091106111750.GA9479@rakim.wolfsonmicro.main>
References: <200910212035.42245.jkrzyszt@tis.icnet.pl>
	<200910212310.05087.jkrzyszt@tis.icnet.pl>
	<20091022105040.GA18862@rakim.wolfsonmicro.main>
	<200911051903.46185.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEF49245B2
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 12:17:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200911051903.46185.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 07:03:43PM +0100, Janusz Krzysztofik wrote:

> Shouldn't this one go into 2.6.32 as a fix? It corrects the problem of ASoC 
> not working on OMAP1 at all. I can't see it in -rc6.

Please say in your patch if something is intended for anything other
than the development release.  The patch has been applied, but for
2.6.33.  I'll cherry pick it over.
