From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Update CS4270 driver to ASoC V2
Date: Tue, 29 Apr 2008 09:58:04 +0100
Message-ID: <20080429085804.GA27000@rakim.wolfsonmicro.main>
References: <1209414144-16010-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B362524721
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Apr 2008 10:58:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1209414144-16010-1-git-send-email-timur@freescale.com>
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 28, 2008 at 03:22:24PM -0500, Timur Tabi wrote:

> Update the CS4270 ASoC codec driver to support ASoC V2.  A side-effect is the
> the removal of partial-support for stand-alone mode (no I2C interface).
> However, this change also makes the driver into a cross-platform new-style I2C
> driver.

Thanks, applied to asoc-v2-dev.
