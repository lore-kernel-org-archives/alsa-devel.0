From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/8] ASoC: ACPI: add new fields for SOF
 support
Date: Fri, 13 Oct 2017 12:17:32 -0500
Message-ID: <ade9cab2-7ae2-5d42-d640-86ce2e637d45@linux.intel.com>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
 <20171012234945.30318-4-pierre-louis.bossart@linux.intel.com>
 <1507912517.16112.463.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 29EE7266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 19:17:44 +0200 (CEST)
In-Reply-To: <1507912517.16112.463.camel@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 10/13/17 11:35 AM, Andy Shevchenko wrote:
> On Thu, 2017-10-12 at 18:49 -0500, Pierre-Louis Bossart wrote:
> 
>> - * @fw_filename: firmware file name.
>> + * @fw_filename: firmware file name. Used when SOF is not enabled.
> 
>> + * @sof_fw_filename: Sound Open Firmware file name, if enabled
>> + * @sof_tplg_filename: Sound Open Firmware topology file name, if
>> enabled
> 
> Naming looks a bit awkward to me, though I would like to bring something
> else here, i.e. unifying those firmwares somehow here.
> 
> It might be dealt with using two different (embedded) structs, e.g.
> 
> enum fw_type fw_type;
> union {
>   struct regular_fw fw;
>   struct sof_fw sof;
> }
> 
> It looks for me slightly cleaner to this struct than bring everything
> inside it.
> 
> What do you think?

It'll be up to users/distributions to select if they want the existing 
drivers, or the SOF-based ones. I don't see how a union might accomplish 
this - maybe I missed your point completely.
We wanted to store all the information required for both cases in one 
structure tied to a specific HID. The fields for the existing solutions 
were kept as is (except for the type renaming), and SOF stuff was added 
as extensions.


> 
>> +	const char *sof_fw_filename;
>> +	const char *sof_tplg_filename;
>> +	const char *asoc_plat_name;
>> +	struct platform_device * (*new_mach_data)(void *pdata);
> 
