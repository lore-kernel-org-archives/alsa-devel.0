From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: Intel: use common helpers to
 detect CPUs
Date: Wed, 19 Jun 2019 13:52:57 +0200
Message-ID: <8710d43c-4612-14ab-46e4-4f95ceb4c70b@linux.intel.com>
References: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
 <7ceb9ba8-74d9-4985-e760-40003dfbef3e@intel.com>
 <20190619110826.GC9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63891F808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 13:53:00 +0200 (CEST)
In-Reply-To: <20190619110826.GC9224@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>
List-Id: alsa-devel@alsa-project.org


>>> Add common helpers to provide same functionality in a cleaner
>>> way. This will also help support the DMI-based quirks being introduced
>>> to handle SOF/SST autodetection.
> 
>>> +#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> 
> We have macros for this in intel-family.h.

Andy, just to double-check, were you referring to the following macro?
#define INTEL_CPU_FAM6(_model, _driver_data)

Thanks!
