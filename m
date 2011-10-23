From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Sun, 23 Oct 2011 16:00:30 +0200
Message-ID: <20111023140029.GA23045@opensource.wolfsonmicro.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
	<20111022094552.GA3382@opensource.wolfsonmicro.com>
	<1319303840.9355.22.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B924246FE
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Oct 2011 16:00:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319303840.9355.22.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 22, 2011 at 10:47:20PM +0530, Vinod Koul wrote:
> On Sat, 2011-10-22 at 10:45 +0100, Mark Brown wrote:

> > Usually by keeping the clocks available.

> That does not seem to be possible here :(

Well, I'm sure you can remonstrate with your baseband vendor.  :)

> Since this is board property, machine driver should tell DAPM to power
> down immediately for this DAI alone. That of course allows us to reap
> benefits of DAPM not power cycling codec during close/open.

For this issue adding control in the dai_link is probably good.
