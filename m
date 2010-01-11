From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver as
 using symmetric rates
Date: Mon, 11 Jan 2010 16:25:08 +0000
Message-ID: <20100111162508.GB26771@rakim.wolfsonmicro.main>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100111112047.GT6923@pengutronix.de>
	<20100111113631.GE3440@sirena.org.uk>
	<eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
	<4B4B48FA.6070402@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EA9F10381F
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 17:25:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B4B48FA.6070402@freescale.com>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, javier Martin <javier.martin@vista-silicon.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 11, 2010 at 09:51:22AM -0600, Timur Tabi wrote:

> I think the default should be synchronous unless asynchronous support
> is specified.

I tend to agree for the i.MX hardware - for the ones I've looked at each
external SSI port is four wire so you need to hook up two to achieve a
six wire configuration that can do asymmetry so a direct hookup between
the external port and the SSI controller seems fairly natural.  It's
also the situation for all the default hookups the silicon provides.
