From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 02/14] ASoC: SOF: Add Sound Open
 Firmware KControl support
Date: Wed, 12 Dec 2018 00:23:08 +0200
Message-ID: <20181211222308.GH10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20181211212318.28644-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 11, 2018 at 03:23:06PM -0600, Pierre-Louis Bossart wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> SOF exposes regular ALSA Kcontrols that are defined by topology. This
> patch converts the Kcontrol IO to DSP IPC.
> 
> The current implementation is not optimal and can be improved:
> a) for every get/put the host wakes up the DSP and generates an
> IPC. The kernel should cache the values and generate an IPC only when
> strictly necessary.
> b) the firmware can be implemented to only instantiate the pipelines
> and related control-related parts that are needed at a given time, and
> power-gate the relevant SRAM blocks.
> 
> The development tasks for these two improvements has started, once
> validated they willl be provided in an update.

> +	max_size = (be->max < max_size) ? be->max : max_size;

min() / max() ?

-- 
With Best Regards,
Andy Shevchenko
