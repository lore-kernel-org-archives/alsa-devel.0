From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
 machine kcontrols.
Date: Mon, 06 Feb 2012 20:41:56 +0530
Message-ID: <1328541116.26182.99.camel@vkoul-udesk3>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
	<20120206132746.GH3070@opensource.wolfsonmicro.com>
	<1328537786.6799.16.camel@odin>
	<20120206142559.GJ3070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ADE5103B17
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 16:10:06 +0100 (CET)
In-Reply-To: <20120206142559.GJ3070@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-02-06 at 14:26 +0000, Mark Brown wrote:
> On Mon, Feb 06, 2012 at 02:16:26PM +0000, Liam Girdwood wrote:
> > On Mon, 2012-02-06 at 13:27 +0000, Mark Brown wrote:
> > > On Mon, Feb 06, 2012 at 12:25:18PM +0000, Liam Girdwood wrote:
> 
> > > > sound/soc/mid-x86/mfld_machine.c:238:	ret_val = snd_soc_add_codec_controls(codec, mfld_snd_controls,
> 
> > > This looks bogus - looks like the missing fanout mux support which we
> > > should really fix properly.
> 
> > Vinod, fyi - something for your todo list ;-) 
> 
> Well, to be fair it's a feature missing in the core.
Hopefully I got the context right :)
So a machine driver should not add codec_controls but do a
card_controls, right?

While I can't disagree that these two controls are not properly done and
ought to be in the codec file and yes :) now they are now in my
ever-increasing todo list :(

-- 
~Vinod
