From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/9] ASoC: Intel: Fix nested/unnecessary
 Kconfig dependencies
Date: Wed, 03 Jan 2018 18:56:58 +0200
Message-ID: <1514998618.7000.584.camel@linux.intel.com>
References: <20180103165022.4984-1-pierre-louis.bossart@linux.intel.com>
 <20180103165022.4984-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DF2D2676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 18:04:34 +0100 (CET)
In-Reply-To: <20180103165022.4984-6-pierre-louis.bossart@linux.intel.com>
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

On Wed, 2018-01-03 at 10:50 -0600, Pierre-Louis Bossart wrote:

> 
>  	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms
> (Baytrail, Cherrytrail)"
>  	depends on X86 && ACPI
>  	select SND_SST_IPC_ACPI
> +	select IOSF_MBI
>  	select SND_SOC_COMPRESS
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	help

A nitpick: perhaps not to split SND_* list of options and put IOSF_MBI
selection last?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
