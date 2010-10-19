From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Mon, 18 Oct 2010 17:16:11 -0700
Message-ID: <20101019001611.GB27248@opensource.wolfsonmicro.com>
References: <20101004100424.4e5cf40c@linux.intel.com>
	<s5hr5fpur7u.wl%tiwai@suse.de>
	<20101017103626.GB6311@opensource.wolfsonmicro.com>
	<s5hk4lhul3j.wl%tiwai@suse.de>
	<20101017161808.GA4437@opensource.wolfsonmicro.com>
	<s5h39s4v6wi.wl%tiwai@suse.de>
	<20101017221126.GA11666@opensource.wolfsonmicro.com>
	<s5hwrpgt4cn.wl%tiwai@suse.de>
	<20101018072017.GA25031@opensource.wolfsonmicro.com>
	<20101018112418.505da748@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F29CA103904
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 02:16:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101018112418.505da748@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, greg@kroah.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 18, 2010 at 11:24:18AM +0100, Alan Cox wrote:
> > Because it's not using the relevant framework at all, it's gone and
> > reinvented the wheel without a pressing reason to do so and this will
> > be very likely to create problems if the part is at all successful.

> Its more a case of predating the wheel as far as I can tell. In terms

ASoC has been in mainline since 2.6.21 which I imagine predates the
Moorestown code.

> of frameworks I don't think it matters as of itself - but once that
> means you have to write two different versions of the same codec chip
> driver for example yes it matters.

Yes, exactly - this is the big problem.  It's often much worse than just
two different versions, with these things it's easy to end up having to
have versions per board.

> Putting it in staging allows that work to be done in public in a
> meaningful way where the code and changes get review.

I agree with the approach you're outlining here.
