From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/3] soundwire: debugfs support for 5.4
Date: Fri, 16 Aug 2019 15:13:08 +0530
Message-ID: <20190816094308.GA12733@vkoul-mobl.Dlink>
References: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org

On 12-08-19, 18:59, Pierre-Louis Bossart wrote:
> This patchset enables debugfs support and corrects all the feedback
> provided on an earlier RFC ('soundwire: updates for 5.4')
> 
> There is one remaining hard-coded value in intel.c that will need to
> be fixed in a follow-up patchset not specific to debugfs: we need to
> remove hard-coded Intel-specific configurations from cadence_master.c
> (PDI offsets, etc).
> 
> Changes since v1 (Feedback from GKH)
> Handle debugfs in a more self-contained way (no dentry as return or parameter)
> Used CONFIG_DEBUG_FS in structures and code to make it easier to
> remove if need be.
> No functional change for register dumps.
> 
> Changes since RFC (Feedback from GKH, Vinod, Guennadi, Cezary, Sanyog):
> removed error checks
> used DEFINE_SHOW_ATTRIBUTE and seq_file
> fixed copyright dates
> fixed SPDX license info to use GPL2.0 only
> fixed Makefile to include debugfs only if CONFIG_DEBUG_FS is selected
> used static inlines for fallback compilation
> removed intermediate variables
> removed hard-coded constants in loops (used registers offsets and
> hardware capabilities)
> squashed patch 3

These looks good but failed to apply. Please rebase on soundwire-next
and resend

Thanks

-- 
~Vinod
