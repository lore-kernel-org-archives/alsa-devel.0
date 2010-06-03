From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] imx-ssi.c: add new choices to
 platform configuration
Date: Thu, 3 Jun 2010 17:52:53 +0100
Message-ID: <20100603165252.GD2762@rakim.wolfsonmicro.main>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<20100601180527.GC10031@sirena.org.uk>
	<20100603081926.GT26820@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D312C2438B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 18:52:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100603081926.GT26820@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 10:19:26AM +0200, Sascha Hauer wrote:
> On Tue, Jun 01, 2010 at 07:05:28PM +0100, Mark Brown wrote:

> > Sascha, any comments on the first couple of patches here?

> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied both, though I had to hand edit the Makefile and Kconfig for the
machine driver - not sure what it was generated against but it didn't
seem terribly mainline.
