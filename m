From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/8] ASoC: ACPI: add new fields for SOF
	support
Date: Fri, 13 Oct 2017 19:35:17 +0300
Message-ID: <1507912517.16112.463.camel@linux.intel.com>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
 <20171012234945.30318-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id A0E11266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 18:35:30 +0200 (CEST)
In-Reply-To: <20171012234945.30318-4-pierre-louis.bossart@linux.intel.com>
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

> - * @fw_filename: firmware file name.
> + * @fw_filename: firmware file name. Used when SOF is not enabled.

> + * @sof_fw_filename: Sound Open Firmware file name, if enabled
> + * @sof_tplg_filename: Sound Open Firmware topology file name, if
> enabled

Naming looks a bit awkward to me, though I would like to bring something
else here, i.e. unifying those firmwares somehow here.

It might be dealt with using two different (embedded) structs, e.g.

enum fw_type fw_type;
union {
 struct regular_fw fw;
 struct sof_fw sof;
}

It looks for me slightly cleaner to this struct than bring everything
inside it.

What do you think?

> +	const char *sof_fw_filename;
> +	const char *sof_tplg_filename;
> +	const char *asoc_plat_name;
> +	struct platform_device * (*new_mach_data)(void *pdata);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
