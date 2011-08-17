From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix check for symmetric rate
	enforcement
Date: Wed, 17 Aug 2011 16:21:27 +0900
Message-ID: <20110817072121.GA13460@opensource.wolfsonmicro.com>
References: <20110817062753.GB31404@pengutronix.de>
	<20110817065014.GB12344@opensource.wolfsonmicro.com>
	<20110817071123.GF31404@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EA421038D4
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 09:22:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110817071123.GF31404@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Lambrecht =?iso-8859-1?Q?J=FCrgen?= <J.Lambrecht@TELEVIC.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 17, 2011 at 09:11:23AM +0200, Sascha Hauer wrote:
> On Wed, Aug 17, 2011 at 03:50:16PM +0900, Mark Brown wrote:

> > start the streams - I seem to recall the code works this way semi
> > deliberately so that we always have a rate selected; most systems only
> > ever use one rate on symmetric audio interfaces.

> I looked into it yesterday and I found no way to fix this properly :(

Yeah, it's just a fundamental API think which applications would need to
code around - they need to restart their config process if they fail to
set the params rather than treating a failure as a failure.

> With my patch applied we get the "Not enforcing symmetric rates.."
> warning each time with arecord | aplay which is not nice either.

Indeed.  We have a window where we know there's two users but don't know
what configurations they want to use.
