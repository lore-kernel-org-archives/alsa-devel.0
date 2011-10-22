From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Sat, 22 Oct 2011 22:47:20 +0530
Message-ID: <1319303840.9355.22.camel@vkoul-udesk3>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
	<20111022094552.GA3382@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 86B5F103867
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 19:26:34 +0200 (CEST)
In-Reply-To: <20111022094552.GA3382@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-10-22 at 10:45 +0100, Mark Brown wrote:
> On Fri, Oct 21, 2011 at 04:28:44PM +0530, Babu, Ramesh wrote:
> 
> > If it is a board specific requirement, then would it make sense to have it in
> > dai_link as per Peter Ujfaulsi's RFC [1].
> 
> Possibly for your case - the case this was originally written for was
> rather different, the CODEC has issues which mean it always needs to
> skip the delay so having to specify this for every single board is going
> to be repetitive.
> 
> > In general, how this kind of situation is handled?
> 
> Usually by keeping the clocks available.
That does not seem to be possible here :(

The codec takes the clock from modem. The codec doesn't have control
over it. The voice call termination kills the clock and the DAPM power
down produces noticeable artifacts.

Since this is board property, machine driver should tell DAPM to power
down immediately for this DAI alone. That of course allows us to reap
benefits of DAPM not power cycling codec during close/open.

-- 
~Vinod
