From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: fix uninitialized variable
Date: Wed, 4 Aug 2010 14:15:25 +0100
Message-ID: <20100804131525.GA32504@rakim.wolfsonmicro.main>
References: <20100804090223.GA5864@sirena.org.uk>
	<20100804125949.14F2A2DA0B@viridian.itc.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFA96245F6
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 15:15:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100804125949.14F2A2DA0B@viridian.itc.virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@viridian.itc.virginia.edu>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2010 at 08:59:49AM -0400, Bill Pemberton wrote:

> > No, just stomping over the variable to shut up the warning doesn't
> > improve anything at all.  You need to make sure that the compiler can
> > actually follow the control flow to see that the data is always
> > initialised rather than disabling the check and missing any actual
> > issues.

> I did, hence the comment in the commit that the variable is
> initialized by fll_factors().

You're completely missing the point here.  What I said was that you need
to make sure that the *compiler* can actually follow the control flow.
You've not done that, you've stomped over the warning to shut both this
and any valid warnings related to the structure up.
