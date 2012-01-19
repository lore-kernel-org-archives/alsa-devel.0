From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Thu, 19 Jan 2012 15:39:46 +0000
Message-ID: <20120119153945.GF3178@opensource.wolfsonmicro.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<20120118152905.GP8732@opensource.wolfsonmicro.com>
	<4F16F6B0.7030707@ti.com>
	<20120118174648.GQ8732@opensource.wolfsonmicro.com>
	<4F17D3F5.3020901@ti.com>
	<20120119104800.GC3178@opensource.wolfsonmicro.com>
	<4F180F43.40706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96EE0103C15
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 16:39:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F180F43.40706@ti.com>
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

On Thu, Jan 19, 2012 at 01:40:35PM +0100, Peter Ujfalusi wrote:
> On 01/19/2012 11:48 AM, Mark Brown wrote:

> > I'd just replace it with a continue on sizes we don't want, much
> > simpler.

> If I can do this (bits == 24):

This mail took me a little while to parse but I think you're trying to
say you insist on the microoptimisation.  Unless you can come up with a
microoptimisation which doesn't take effort to read please write
something simple.  The reason I wasn't happy with the original patch was
that what should be a trivial bit of code took far too long to check.
Maintainability is vastly more important than microoptimising a slow
path, having to read things again later was the whole reason I didn't do
any filtering in the first place.
