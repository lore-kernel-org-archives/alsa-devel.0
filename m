From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/8] ASoC: Intel: move all ACPI match
 tables to common module
Date: Fri, 13 Oct 2017 19:38:46 +0300
Message-ID: <1507912726.16112.466.camel@linux.intel.com>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
 <20171012234945.30318-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B923266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 18:38:51 +0200 (CEST)
In-Reply-To: <20171012234945.30318-5-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-10-12 at 18:49 -0500, Pierre-Louis Bossart wrote:
> First step of cleaning, move all tables to soc-acpi-intel-match
> module.
> The tables remain in separate files per platform to keep them
> manageable. Skylake+ platforms are still handled elsewhere since
> there is no conflict with SOF for now, but this will have to be
> handled at a later point.
 
> +static int is_byt(void)
> +{
> +	bool status = false;
> +	static const struct x86_cpu_id cpu_ids[] = {
> +		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail
> */
> +		{}
> +	};
> +	if (x86_match_cpu(cpu_ids))
> +		status = true;
> +	return status;
> +}

I wish it would be cleaned up at some point...

P.S. Yes, I have commented on this earlier.
 
-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
