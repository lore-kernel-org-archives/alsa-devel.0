From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 00/22] soundwire: code cleanup
Date: Wed, 1 May 2019 18:07:55 +0200
Message-ID: <20190501160755.GC19281@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 01, 2019 at 10:57:23AM -0500, Pierre-Louis Bossart wrote:
> SoundWire support will be provided in Linux with the Sound Open
> Firmware (SOF) on Intel platforms. Before we start adding the missing
> pieces, there are a number of warnings and style issues reported by
> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> 
> Changes since v3:
> patch 1,3,4 were merged for 5.2-rc1
> No code change, only split patch2 in 21 patches to make Vinod
> happy. Each patch only fixes a specific issue. patch 5 is now patch22
> and wasn't changed. Not sure why Vinod reported the patch didn't
> apply.
> Added Takashi's Reviewed-by tag in all patches since the code is
> exactly the same as in v3.

These all look good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Vinod, want me to just pick these up from the list as-is so we can get
them into 5.2-rc1?

thanks,

greg k-h
