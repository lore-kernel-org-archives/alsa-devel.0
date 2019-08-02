From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 11/40] soundwire: cadence_master: simplify bus clash
 interrupt clear
Date: Fri, 2 Aug 2019 17:37:51 +0530
Message-ID: <20190802120751.GM12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-12-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-12-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> The bus clash interrupts are generated when the status is one, and
> also cleared by writing a one. It's overkill/useless to use an OR when
> the bit is already set.

IIRC we were supposed to have different variable and that was the reason
for setting, yes should be removed.

I have applied this one as well

-- 
~Vinod
