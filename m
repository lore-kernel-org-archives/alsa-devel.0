From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 6/7] ASoC: Intel: boards: align Kconfig
 configurations for HiFi2
Date: Mon, 20 Nov 2017 10:27:19 -0600
Message-ID: <cc11a11c-9bdf-6df5-f48b-07cfa1ddcbcd@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-7-pierre-louis.bossart@linux.intel.com>
 <1511024900.25007.315.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D7CAF266F52
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 17:27:22 +0100 (CET)
In-Reply-To: <1511024900.25007.315.camel@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org



On 11/18/2017 11:08 AM, Andy Shevchenko wrote:
> On Fri, 2017-11-17 at 18:02 -0600, Pierre-Louis Bossart wrote:
>> Make sure all the configs are aligned
>> Also add the missing dependencies on SOC_ACPI stuff used to fix
>> DAI names based on HID.
>>
>> FIXME: not sure why X86_INTEL_LPSS is needed in a machine
>> driver config, should it be back to X86 everywhere?
>>
> X86_INTEL_LPSS makes sense only for Haswell, Broadwell, BayTrail and
> CherryTrail (more precisely for PCH inside those SoCs).
>
> Basically it enables few peripheral drivers in case they are enumerated
> via ACPI (SPI, I2C, UART, PWM, SDHCI) on SoCs listed above.
>
> Hope this would help how to deal with the option in ASoC case.
>
Yes, and my proposal would be to move this dependency where applicable 
in the sound/soc/intel Kconfig. the board-level dependency should only 
be I2C or SPI - or both in some cases, there is no reason to have 
something SoC-dependent at the machine level, and those cases would be 
filtered out anyway.
