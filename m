From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: x86: Add Atom PMC platform clocks
Date: Fri, 2 Sep 2016 17:31:46 -0700
Message-ID: <20160903003146.GO12510@codeaurora.org>
References: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160831003722.GH12510@codeaurora.org>
 <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
 <20160831170858.GA6560@sirena.org.uk>
 <9df1be06-8415-8cff-9468-0c4938f6e0fc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id A49A62673BF
 for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2016 02:31:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9df1be06-8415-8cff-9468-0c4938f6e0fc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, irina.tirdea@intel.com, tiwai@suse.de, mturquette@baylibre.com, Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/01, Pierre-Louis Bossart wrote:
> On 8/31/16 12:08 PM, Mark Brown wrote:
> >On Tue, Aug 30, 2016 at 08:35:55PM -0500, Pierre-Louis Bossart wrote:
> >>On 8/30/16 7:37 PM, Stephen Boyd wrote:
> >
> >>>It's sad that this can't be compiled on any platform. Has there
> >>>been any move towards making this into a regmap provider so that
> >>>this clk driver can use cross platform regmap APIs instead? Or
> >
> >>it's not clear to me what cross-platform goals you are hinting at and what
> >>the concern is. We can add more framework stuff and make the code more
> >>elegant but at the end of the day we will write in a very limited set of
> >>registers (2 for audio - on/off and 19.2/25MHz selection) and the use of
> >>this functionality is restricted to Baytrail and Cherrytrail.
> >
> >If code can be compiled on a wide range of platforms then that means
> >that it's much easier to get build coverage of the code.  This is
> >helpful for anyone doing any kind of cross tree updates - things like
> >updating APIs for example.  The fewer configurations they have to touch
> >to get everything built the easier it is for them.
> 
> ok, we can add a dummy pmc_write/read for non atom platforms so that
> changes in the clock framework API can be handled without
> configuration.
> Using regmap to hide the IPC requests to the PCM seems a bit
> over-engineered - we are talking about 2 registers per clock - and
> bring limited benefits.

Sure regmap may not be helpful. Even passing the iomem pointer
through platform data and then using readl/writel would be good
though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
