From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/5] ASoC: SOF: Intel: SoundWire initial
 integration
Date: Thu, 22 Aug 2019 17:19:29 +0200
Message-ID: <20190822151928.GB1200@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

In patch 4/5 I forgot to mention superfluous braces around dev_err() 
in sdw_config_stream() and sdw_free_stream(). Otherwise for the series:

Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Thanks
Guennadi

On Wed, Aug 21, 2019 at 03:17:15PM -0500, Pierre-Louis Bossart wrote:
> This RFC is the companion of the other RFC 'soundwire: intel: simplify
> DAI/PDI handling​'. Our purpose at this point is to gather feedback on
> the interfaces between the Intel SOF parts and the SoundWire code.
> 
> The suggested solution is a simple init/release inserted at
> probe/remove and resume/suspend, as well as two callbacks for the SOF
> driver to generate IPC configurations with the firmware. That level of
> separation completely hides the details of the SoundWire DAIs and will
> allow for 'transparent' multi-cpu DAI support, which will be handled
> in the machine driver and the soundwire DAIs.
> 
> This solution was tested on IceLake and CometLake, and captures the
> feedback from SOF contributors on an initial integration that was
> deemed too complicated (and rightly so).
> 
> Pierre-Louis Bossart (5):
>   ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
>   ASoC: SOF: Intel: hda: add helper to initialize SoundWire IP
>   ASoC: SOF: Intel: hda: add SoundWire IP support
>   ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
>   ASoC: SOF: Intel: add support for SoundWire suspend/resume
> 
>  include/sound/sof/dai-intel.h |  18 ++--
>  sound/soc/sof/intel/hda-dsp.c |  11 +++
>  sound/soc/sof/intel/hda.c     | 157 ++++++++++++++++++++++++++++++++++
>  sound/soc/sof/intel/hda.h     |  11 +++
>  4 files changed, 188 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 3b3aaa017e8072b1bfddda92be296b3463d870be
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
