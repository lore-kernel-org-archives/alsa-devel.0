From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 17:46:48 +0000
Message-ID: <20120118174648.GQ8732@opensource.wolfsonmicro.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<20120118152905.GP8732@opensource.wolfsonmicro.com>
	<4F16F6B0.7030707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C9BC243DE
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 18:46:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F16F6B0.7030707@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 05:43:28PM +0100, Peter Ujfalusi wrote:
> On 01/18/2012 04:29 PM, Mark Brown wrote:
> > I'm not sure this is actually a legibility improvement, if anything it's
> > probably less clear than the original as now the setup of the loop is
> > spread even further around the function.

> Would it make it clearer if I set i to 0 right before the while?

That'd help a bit.  Though I'd just go with a for loop, the while
clearly doesn't look any better - I was just suggesting it without
actually having tried writing it out.

> > Performance isn't really a concern in this path unless we do something
> > totally insane.  Thinking time on the part of the reader needs to be
> > considered too...

> Sure it is not a concern. These small 'Performance isn't really a
> concern in this path' at the end ads up that we need faster CPUs to have
> the same perceived perfomrance.

Yeah, but if that percieved performance is already instantaneous there's
no need to worry :)  My first thought would've been to just continue on
sample rates we don't like rather than trying to break out of an
iteration of 4 steps early.
