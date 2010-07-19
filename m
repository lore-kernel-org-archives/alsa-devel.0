From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:?DB_RANGE
 mapping fixes
Date: Mon, 19 Jul 2010 09:51:41 +0100
Message-ID: <20100719085140.GA15693@rakim.wolfsonmicro.main>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<201007161405.40985.peter.ujfalusi@nokia.com>
	<20100716123325.GA18152@rakim.wolfsonmicro.main>
	<201007190857.05339.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4C80243BA
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 10:51:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201007190857.05339.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 19, 2010 at 08:57:05AM +0300, Peter Ujfalusi wrote:
> On Friday 16 July 2010 15:33:25 ext Mark Brown wrote:

> > Isn't this going to get messy when the increments don't line up so that
> > it's easy to overlap the start of one range with the beginning of the
> > next?

> Well, I assume however writes the driver knows how to build up a lookup table 
> which is consistent, so I don't really see a problem.

The problem I see is if the hardware step sizes result in discontinuties
in the scale so you can't easily join the top end of one set of values
with the bottom end of another you're pretty stuck - joining the ranges
up will only work if they can be made to overlap which isn't always
going to be the case.

For example, something like:

1: 0
2: 2
3: 4
4: 5
5: 7
6: 9

(a bit artificial but you get the idea) is going to be a bit tricky.

> I'll post patches against alsa-lib to fix the _DB_RANGE handling. It will take 
> some time to understand, and fix the code + testing it.

Thanks.
