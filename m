From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Mon, 5 May 2008 14:12:17 +0100
Message-ID: <20080505131216.GA5217@rakim.wolfsonmicro.main>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
	<200805051455.05277.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2777410380E
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 15:12:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805051455.05277.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 05, 2008 at 02:55:04PM +0200, Juergen Beisert wrote:

> Hmm, how far away is ASoC v2 from mainline? When I start to develop the driver 
> right now, what version I should use?

Depends on how quickly you want to get it into the mainline.  Developing
for v1 would be the most conservative choice and let you get stuff in as
soon as possible without being held up by v2 but it would mean that
you'd be working with the ASoC v1 interfaces and that someone will have
to convert to v2 at some point.

The idea is that ASoC v2 itself should be starting to make its way into
mainline during 2.6.27 but there's no guarantees that it'll make it
then.
