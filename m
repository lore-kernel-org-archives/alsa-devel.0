From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Mon, 24 Oct 2011 08:25:10 +0530
Message-ID: <1319424910.9355.25.camel@vkoul-udesk3>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
	<20111022094552.GA3382@opensource.wolfsonmicro.com>
	<1319303840.9355.22.camel@vkoul-udesk3>
	<20111023140029.GA23045@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id E4F6724465
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 05:04:43 +0200 (CEST)
In-Reply-To: <20111023140029.GA23045@opensource.wolfsonmicro.com>
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

On Sun, 2011-10-23 at 16:00 +0200, Mark Brown wrote:
> 
> > Since this is board property, machine driver should tell DAPM to
> power
> > down immediately for this DAI alone. That of course allows us to
> reap
> > benefits of DAPM not power cycling codec during close/open.
> 
> For this issue adding control in the dai_link is probably good. 
Yes meant dia_link :)


-- 
~Vinod
