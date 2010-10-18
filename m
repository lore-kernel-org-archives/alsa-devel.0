From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] sst: Intel SST audio driver
Date: Mon, 18 Oct 2010 11:24:18 +0100
Message-ID: <20101018112418.505da748@linux.intel.com>
References: <20101003112244.488282fd@linux.intel.com>
	<20101003201943.GA31764@opensource.wolfsonmicro.com>
	<20101004100424.4e5cf40c@linux.intel.com>
	<s5hr5fpur7u.wl%tiwai@suse.de>
	<20101017103626.GB6311@opensource.wolfsonmicro.com>
	<s5hk4lhul3j.wl%tiwai@suse.de>
	<20101017161808.GA4437@opensource.wolfsonmicro.com>
	<s5h39s4v6wi.wl%tiwai@suse.de>
	<20101017221126.GA11666@opensource.wolfsonmicro.com>
	<s5hwrpgt4cn.wl%tiwai@suse.de>
	<20101018072017.GA25031@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E8472437F
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 13:17:18 +0200 (CEST)
In-Reply-To: <20101018072017.GA25031@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
Cc: Takashi Iwai <tiwai@suse.de>, greg@kroah.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Because it's not using the relevant framework at all, it's gone and
> reinvented the wheel without a pressing reason to do so and this will
> be very likely to create problems if the part is at all successful.

Its more a case of predating the wheel as far as I can tell. In terms
of frameworks I don't think it matters as of itself - but once that
means you have to write two different versions of the same codec chip
driver for example yes it matters.

> This is all driver specific stuff, there's nothing that needs doing
> here immediately outside of the driver that I can spot right now.

Well our agenda right now is to strip out the crap, polish up the
various bugs found in review (and in staging its already getting a
trickle of very useful community input swatting silly error path bugs,
signed/unsigned typing etc) and then assign someone in Intel
OTC (hopefully if things go to plan someone with prior ALSA dev
experience) to make it a good ALSA citizen which probably means using
ASOC or similar.

Putting it in staging allows that work to be done in public in a
meaningful way where the code and changes get review.

Alan
