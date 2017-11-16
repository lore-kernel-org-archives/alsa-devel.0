From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 07/14] regmap: Add SoundWire bus support
Date: Thu, 16 Nov 2017 18:32:35 +0530
Message-ID: <20171116130235.GT3187@localhost>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-8-git-send-email-vinod.koul@intel.com>
 <20171116120437.h2ghxvwpsd6ovdhe@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171116120437.h2ghxvwpsd6ovdhe@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 12:04:37PM +0000, Mark Brown wrote:
> On Fri, Nov 10, 2017 at 05:19:09PM +0530, Vinod Koul wrote:
> 
> > +EXPORT_SYMBOL(__regmap_init_sdw);
> 
> We still have plain EXPORT_SYMBOL() on the regmap exports...

Hi Mark,

I assumed after Alan's clarification that it is okay to do so. Let me know if
you feel otherwise

Thanks
-- 
~Vinod
