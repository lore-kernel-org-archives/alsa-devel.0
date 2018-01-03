From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v6 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Wed, 3 Jan 2018 08:36:58 +0530
Message-ID: <20180103030657.GB18649@localhost>
References: <1514306696-7062-1-git-send-email-sriramx.periyasamy@intel.com>
 <1514306696-7062-2-git-send-email-sriramx.periyasamy@intel.com>
 <20180102233929.GO7997@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180102233929.GO7997@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audi o <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 02, 2018 at 03:39:29PM -0800, Stephen Boyd wrote:
> On 12/26, Sriram Periyasamy wrote:
> > diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> > new file mode 100644
> > index 000000000000..bb828f285b16
> > --- /dev/null
> > +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> > @@ -0,0 +1,432 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright(c) 2015-17 Intel Corporation
> 
> Does this also go into the // part? I thought just the tag was
> with // comment style.

Apparently that seems to be the latest recommendation. Tag plus copyright.

-- 
~Vinod
