From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add signal generator widget type
Date: Thu, 1 Dec 2011 15:59:56 +0000
Message-ID: <20111201155956.GA18120@opensource.wolfsonmicro.com>
References: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1322753220.4712.2.camel@odin>
	<20111201153050.GA28076@sirena.org.uk>
	<1322754914.4712.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2203724142
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 17:00:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322754914.4712.5.camel@odin>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 01, 2011 at 03:55:14PM +0000, Liam Girdwood wrote:
> On Thu, 2011-12-01 at 15:30 +0000, Mark Brown wrote:

> > It's a signal source - in terms of the DAPM graph and figuring out a
> > route from an input to an output it's an input.

> Ah, OK - I'm thinking here of an internal signal generator (i.e. coming
> from within platform/codec). e.g. we could add a simple sine wave
> generator to OMAP4 ABE for test/debug purposes.

Yeah, that's exactly the sort of thing that this is for in the first
instance (though in the WM8962 case it's a bit more fully featured than
that).  If they are output widgets DAPM looks for something to input
data to them, can't find one and does the wrong thing.
