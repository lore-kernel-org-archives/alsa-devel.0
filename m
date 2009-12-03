From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: OMAP mcbsp: dai->dev is missing warning
Date: Thu, 3 Dec 2009 10:18:46 +0000
Message-ID: <20091203101846.GA13165@rakim.wolfsonmicro.main>
References: <200912031145.47139.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82F9F243E2
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 11:18:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200912031145.47139.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 03, 2009 at 11:45:47AM +0200, Peter Ujfalusi wrote:

> Recently the following warnings appeared during the bootup on OMAP platforms:

For fairly large definitions of recent :)

> At the moment the platform device/driver is not used for the 
> sound/soc/omap/omap-mcbsp, it is used for the arch/arm/plat-omap/mcbsp.c, so we 
> really don't have possibility at the moment to provide a valid dai->dev for ASoC 
> at the moment.

You could presumably get the plat-omap code to tell the ASoC code what
the dev is and use that?  When the board driver code loads it could ask
the McBSP ASoC driver to register the required ports.

> Mark: Do you have some estimates, when the dai->dev will become mandatory?

Not firm.  I would hope to start using it for things like suspend/resume
sequencing before 2.6.34 but it's not likely to be mandatory then.  To a
certain extent it depends on getting the major platforms converted over.
