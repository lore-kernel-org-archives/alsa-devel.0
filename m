From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v7] regmap: Add SoundWire bus support
Date: Mon, 8 Jan 2018 15:40:22 +0530
Message-ID: <20180108101022.GA18649@localhost>
References: <1515220810-20009-1-git-send-email-vinod.koul@intel.com>
 <f65b7be1-14d8-2d67-34d8-c5752f24d84e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f65b7be1-14d8-2d67-34d8-c5752f24d84e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark <broonie@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, ALSA <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 08, 2018 at 10:02:35AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 06/01/18 06:40, Vinod Koul wrote:
> >+
> >+config REGMAP_HWSPINLOCK
> >+	bool
> >+
> Does this belong to this patch?

Ah crap, I rebased on regmap-next and looks like this crept up while
rebasing, thanks for spotting, will fix and update

-- 
~Vinod
