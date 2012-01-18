From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 15:29:05 +0000
Message-ID: <20120118152905.GP8732@opensource.wolfsonmicro.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14E002465C
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:29:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
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

On Wed, Jan 18, 2012 at 04:05:14PM +0100, Peter Ujfalusi wrote:

> Converted to use while loop.
> We run the loop as long as the sample size is bigger than the requested
> msbits.

I'm not sure this is actually a legibility improvement, if anything it's
probably less clear than the original as now the setup of the loop is
spread even further around the function.

> Most of the drivers require 24/32 configuration, so not point of looping
> for smaller sample sizes.

Performance isn't really a concern in this path unless we do something
totally insane.  Thinking time on the part of the reader needs to be
considered too...
