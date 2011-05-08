From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: OMAP: Add CPU DAI driver for HDMI
Date: Sun, 8 May 2011 16:56:28 +0100
Message-ID: <20110508155628.GA32214@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-5-git-send-email-ricardo.neri@ti.com>
	<20110505082253.GF11744@opensource.wolfsonmicro.com>
	<1304624105.1900.41.camel@sagan>
	<20110506132133.GM23729@opensource.wolfsonmicro.com>
	<1304813117.11941.197.camel@sagan>
	<20110508103402.GA12921@opensource.wolfsonmicro.com>
	<4DC67AFC.5040607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71437103804
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 17:56:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC67AFC.5040607@ti.com>
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

On Sun, May 08, 2011 at 12:14:04PM +0100, Liam Girdwood wrote:
> On 08/05/11 11:34, Mark Brown wrote:

> > I repeat my question - why do you need to check this?  You'll get errors
> > but you're generating an error anyway so it's not clear what the urgency
> > is.

> I think the problem here is that the errors are fatal data aborts here
> when L3 DSS access is disabled.

So it'll segfault or something instead of just not transferring data or
whatever?
