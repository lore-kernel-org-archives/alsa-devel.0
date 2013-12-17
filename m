From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 10:16:13 +0800
Message-ID: <20131217021610.GA7172@S2101-09.ap.freescale.net>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 54212260816
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 03:15:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131217015939.GM3185@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 17, 2013 at 01:59:39AM +0000, Mark Brown wrote:
> On Mon, Dec 16, 2013 at 07:29:12PM +0800, Shawn Guo wrote:
> > On Mon, Dec 16, 2013 at 03:31:29AM +0000, Li.Xiubo@freescale.com wrote:
> 
> [Deferring probe in non-DT cases]
> > > Where should this special handling be dealt with ? Is here or regulator_get_optional()
> > > will be better ?
> 
> > Anyway, this is another issue which should be addressed in regulator
> > core, IMO.
> 
> It's something that the platform needs to address - the core has no way
> of figuring out what devices might register in future if the platform
> doesn't tell them.

Okay.  But is there an established means for platform to tell that?

Shawn

> With DT we can do that because you can't create a
> device without providing information about what supplies will be made
> avaialable, other systems may be able to do the same thing.
