From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Revert "ASoC: tlv320dac33: Use core to
 set the msbits constraint"
Date: Thu, 19 Jan 2012 19:07:01 +0000
Message-ID: <20120119190701.GN3178@opensource.wolfsonmicro.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
	<1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
	<20120119182602.GM3178@opensource.wolfsonmicro.com>
	<4F1861E6.1000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 866F82436F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 20:07:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F1861E6.1000700@ti.com>
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

On Thu, Jan 19, 2012 at 07:33:10PM +0100, Peter Ujfalusi wrote:

> It might not bother you that we are wasting CPU cycles for nothing, but
> it annoys me.
> This is the reason we need to update the CPUs every 2 years.

> Please take this series. I'm not going to allow that the TI drivers will
> waste CPU cycles (for nothing).

Please take a step back (I know I'm rather annoyed and am trying to do
so myself), none of this is getting us anywhere.

We've got real CPU consumption problems in ASoC - the DAPM algorithm is
the biggest one, even with the work I did recently to mitigate against
it it's still got the ability to explode dramatically to the point where
it's user visible as the worst case is well over O(n^2).  There's plenty
of low hanging fruit that it'd be much better to spend time on here - as
a quick example every time we start or stop a stream we do a linear
search of all DAPM widgets looking for those that might be affected
based on a string match in order to kick DAPM for them.  That's O(n) in
the number of widgets in the card plus the strcmp() costs.

We'll all get *much* more benefit from working on improvements of things
like that (and on the memory consumption which isn't great either and
probably manages to burn measurable CPU cycles due to cache misses) than
we ever will from anything we do with this code.
