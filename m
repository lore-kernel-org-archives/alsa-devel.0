From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/5] ASoC: Intel: bytcr_rt5651: filter
 codec name
Date: Mon, 18 Sep 2017 12:24:30 -0500
Message-ID: <25b22ab9-660d-5ca5-7f6d-400deb0c3bc8@linux.intel.com>
References: <20170908174356.23788-1-pierre-louis.bossart@linux.intel.com>
 <20170908174356.23788-5-pierre-louis.bossart@linux.intel.com>
 <1505718785.25945.267.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 04AFC266DBB
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 19:24:32 +0200 (CEST)
In-Reply-To: <1505718785.25945.267.camel@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 9/18/17 2:13 AM, Andy Shevchenko wrote:
> On Fri, 2017-09-08 at 12:43 -0500, Pierre-Louis Bossart wrote:
>> Use same fix as other codecs to work around BIOS/ACPI issues
>>
>>
> 
>>   {
>>   	int ret_val = 0;
>> +	struct sst_acpi_mach *mach;
>> +	const char *i2c_name = NULL;
>> +	int i;
>> +	int dai_index;
>>   	struct byt_rt5651_private *priv;
> 
> I would rather put variables in reversed xmas tree order or close to it.

yes you are right, this looks awful. I'll send a cleaned-up series.

> 
> +
>> +	/* fixup codec name based on HID */
>> +	i2c_name = sst_acpi_find_name_from_hid(mach->id);
> 
>> +	if (i2c_name != NULL) {
> 
> if (i2c_name) { ?
> 
