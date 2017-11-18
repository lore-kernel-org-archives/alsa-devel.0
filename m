From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 6/7] ASoC: Intel: boards: align Kconfig
 configurations for HiFi2
Date: Sat, 18 Nov 2017 19:08:20 +0200
Message-ID: <1511024900.25007.315.camel@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DEE9266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 18:08:24 +0100 (CET)
In-Reply-To: <20171118000202.22302-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-11-17 at 18:02 -0600, Pierre-Louis Bossart wrote:
> Make sure all the configs are aligned
> Also add the missing dependencies on SOC_ACPI stuff used to fix
> DAI names based on HID.
> 

> FIXME: not sure why X86_INTEL_LPSS is needed in a machine
> driver config, should it be back to X86 everywhere?
> 

X86_INTEL_LPSS makes sense only for Haswell, Broadwell, BayTrail and
CherryTrail (more precisely for PCH inside those SoCs).

Basically it enables few peripheral drivers in case they are enumerated
via ACPI (SPI, I2C, UART, PWM, SDHCI) on SoCs listed above.

Hope this would help how to deal with the option in ASoC case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
