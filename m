From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 14/40] soundwire: cadence_master: fix definitions for
 INTSTAT0/1
Date: Fri, 2 Aug 2019 17:43:48 +0530
Message-ID: <20190802121348.GP12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-15-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-15-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Two off-by-one errors: INTSTAT0 missed BIT(31) and INTSTAT1 is only
> defined on first 16 bits.

Applied, thanks

-- 
~Vinod
