From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] soundwire: debugfs support for 5.4
Date: Tue, 13 Aug 2019 08:06:55 +0200
Message-ID: <20190813060655.GF6670@kroah.com>
References: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 12, 2019 at 06:59:39PM -0500, Pierre-Louis Bossart wrote:
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

Looks much better:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
