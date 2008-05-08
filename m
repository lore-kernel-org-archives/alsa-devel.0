From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How are events of headphone plug/unplug handled	in
	ASOC.
Date: Thu, 8 May 2008 11:31:27 +0100
Message-ID: <20080508103127.GA10313@rakim.wolfsonmicro.main>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
	<200805080954.28299.jbe@pengutronix.de>
	<20080508093339.GA17836@rakim.wolfsonmicro.main>
	<1210242424.6288.13.camel@kandagatla-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FBAE246FC
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 12:31:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1210242424.6288.13.camel@kandagatla-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Srinivas.Kandagatla" <srinivas.kandagatla@azingo.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 08, 2008 at 03:57:04PM +0530, Srinivas.Kandagatla wrote:

> I see the background of ASOC states that it supports some mechanism for
> events from plugging/unplugging headphone.
> But I don't see this support in any of the drivers/alsa-lib or is this
> feature is yet to come in ASOC core.

There is currently no core support for this.  The machine driver needs
to listen for headphone insert events using whatever mechanism the board
supports and call snd_soc_dapm_set_endpoint() to enable and disable the
relevant jacks when the headphones are connected and disconnected.
