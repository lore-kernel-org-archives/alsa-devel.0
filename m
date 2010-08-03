From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM
	ordering problem
Date: Tue, 3 Aug 2010 16:02:54 +0100
Message-ID: <20100803150254.GF25306@rakim.wolfsonmicro.main>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	<201008030915.37405.peter.ujfalusi@nokia.com>
	<20100803083944.GB25306@rakim.wolfsonmicro.main>
	<201008031209.25585.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 567A2244D4
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 17:02:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008031209.25585.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 03, 2010 at 12:09:10PM +0300, Peter Ujfalusi wrote:
> On Tuesday 03 August 2010 11:39:44 ext Mark Brown wrote:

> > I think there's something useful we can do with DAPM here (independantly
> > of anything in TWL4030), probably involving splitting up the routing
> > change walk to run power down first and then power up but the current
> > patch feels like it's going to cause at least as many problems as it
> > solves.

> I tend to agree. The patch for the core is quite dramatic change, and it can 
> introduce other types of problems.
> But... It would make the actual register write sequence consistent in all cases.

The power and route configuration settings aren't really part of the
same sequence, though - other widgets can also trigger power changes,
and obviously a route change need not imply a power change.
