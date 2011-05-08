From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Mon, 9 May 2011 01:41:45 +0200
Message-ID: <20110508234145.GB20411@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
	<1304624105.1900.41.camel@sagan>
	<20110506132133.GM23729@opensource.wolfsonmicro.com>
	<1304813117.11941.197.camel@sagan>
	<20110508103402.GA12921@opensource.wolfsonmicro.com>
	<4DC67AFC.5040607@ti.com>
	<20110508155628.GA32214@opensource.wolfsonmicro.com>
	<4DC6F2A9.8070804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F5391037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 01:41:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC6F2A9.8070804@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "Neri, Ricardo" <ricardo.neri@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, May 08, 2011 at 08:44:41PM +0100, Liam Girdwood wrote:
> On 08/05/11 16:56, Mark Brown wrote:

> > So it'll segfault or something instead of just not transferring data or
> > whatever?

> Yep, it will cause a CPU data abort exception in this case.

OK, that makes things clearer.  It'd still be good to postpone the check
for as long as possible, just in case things get racy - currently it
feels too early in the process - but having the check makes sense.
