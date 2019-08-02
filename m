From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RFC PATCH 18/40] soundwire: bus: split handling of Device0
 events
Date: Fri, 2 Aug 2019 22:29:52 +0530
Message-ID: <20190802165952.GV12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-19-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-19-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Assigning a device number to a Slave will result in additional events
> when it reports its status in a PING frame. There is no point in
> dealing with all the other devices in a loop, this can be done when a
> non-device0 event happens.

Applied, thanks

-- 
~Vinod
