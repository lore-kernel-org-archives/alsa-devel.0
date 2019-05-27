From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 00/15] soundwire: corrections to ACPI/DisCo/Intel
 support
Date: Mon, 27 May 2019 10:53:56 +0530
Message-ID: <20190527052356.GA15118@vkoul-mobl>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

On 22-05-19, 14:47, Pierre-Louis Bossart wrote:
> Now that we are done with cleanups, we can start fixing the code with
> actual semantic or functional changes.
> 
> This patchset corrects issues with Intel BIOS and hardware properties
> that prevented a successful init, aligns the code with the MIPI DisCo
> spec, adds rate-limiting for frequent errors and adds checks on number
> of links and PDIs.
> 
> With all these changes, the hardware can be initialized correctly and
> modules can be added/removed without issues on WhiskyLake and
> IceLake.
> 
> Parts of this code was initially written by my Intel colleagues Vinod
> Koul, Sanyog Kale, Shreyas Nc and Hardik Shah, who are either no
> longer with Intel or no longer involved in SoundWire development. When
> relevant, I explictly added a note in commit messages to give them
> credit for their hard work, but I removed their signed-off-by tags to
> avoid email bounces and avoid spamming them forever with SoundWire
> patches.

Applied all, thanks
-- 
~Vinod
