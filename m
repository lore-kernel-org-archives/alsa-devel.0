From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: p1022ds: fix incorrect
 referencing of device tree properties
Date: Thu, 9 Jun 2011 12:01:29 +0100
Message-ID: <20110609110129.GE12865@opensource.wolfsonmicro.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BFAB6103B44
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 13:01:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307563376-13055-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 08, 2011 at 03:02:55PM -0500, Timur Tabi wrote:
> Device tree integer properties are encoded in big-endian format, but some of
> the Freescale ASoC drivers were assuming that the host is in big-endian format
> as well.  Although this is true, it's better to use endian-safe accessors.
> 
> Also add a check for a failed ioremap() call in the SSI driver.

Similarly this patch appears to consist of two unrelated changes.  I'll
apply this time but please don't do this in future.

Please also include non-urgent cleanups like this after bug fixes in your
patch serieses - while the bug fixes get applied to the release branch
new features and cleanups don't but ordering the cleanups first means
the bugfixes may end up depending on them.
