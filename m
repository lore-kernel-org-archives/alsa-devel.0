From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Thu, 19 Jan 2012 10:48:00 +0000
Message-ID: <20120119104800.GC3178@opensource.wolfsonmicro.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<20120118152905.GP8732@opensource.wolfsonmicro.com>
	<4F16F6B0.7030707@ti.com>
	<20120118174648.GQ8732@opensource.wolfsonmicro.com>
	<4F17D3F5.3020901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E9A62462E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 11:48:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F17D3F5.3020901@ti.com>
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

On Thu, Jan 19, 2012 at 09:27:33AM +0100, Peter Ujfalusi wrote:

> Are you going to take the for version of patch, or should I resend it?
> I can add a comment to explain that we bail out, and not checking the
> sample sizes lower than the requested msbits, if it helps.

I'd just replace it with a continue on sizes we don't want, much
simpler.
