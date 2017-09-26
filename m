From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 3/8] ASoC: ACPI: add new fields for SOF
 support
Date: Tue, 26 Sep 2017 14:14:04 -0500
Message-ID: <70aa79ad-b21e-c92d-e723-7ec3fc3abe33@linux.intel.com>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
 <20170908205702.1985-4-pierre-louis.bossart@linux.intel.com>
 <20170926041808.GK30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B325C267190
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 21:14:07 +0200 (CEST)
In-Reply-To: <20170926041808.GK30097@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 9/25/17 11:18 PM, Vinod Koul wrote:
> On Fri, Sep 08, 2017 at 03:56:57PM -0500, Pierre-Louis Bossart wrote:
>> To prepare for SOF integration, we need new fields in the machine table.
>> It is intended that the same table is used for both closed-source and
>> open-source firmware to avoid repeating ACPI-related information
>> multiple times
>> No functional change
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/sound/soc-acpi.h | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
>> index 75fb32e..3e61f93 100644
>> --- a/include/sound/soc-acpi.h
>> +++ b/include/sound/soc-acpi.h
>> @@ -60,12 +60,29 @@ struct snd_soc_acpi_mach {
>>   	const char *drv_name;
>>   	/* firmware file name */
>>   	const char *fw_filename;
>> -
>>   	/* board name */
>>   	const char *board;
>>   	struct snd_soc_acpi_mach * (*machine_quirk)(void *arg);
>>   	const void *quirk_data;
>> +
>> +	/* intended for platform data or machine specific-ops */
>>   	void *pdata;
>> +
>> +	/* SOF firmware file name */
>> +	const char *sof_fw_filename;
>> +	/* SOF default topology */
>> +	const char *sof_tplg_filename;
>> +
>> +	/* ASoC platform name - used for binding machine drivers if non NULL */
>> +	const char *asoc_plat_name;
>> +
>> +	/* machine driver private data fixup */
>> +	struct platform_device * (*new_mach_data)(void *pdata);
> 
> good comments, can we move them to kernel-doc style please

ok

>> +
>> +	/* FIXME: is this needed, was only used for BYTCR-detection
>> +	   int (*confirm_mach)(struct device *dev,
>> +	   const struct sof_dev_desc **desc);
>> +	*/
> 
> this is dummy, lets remove it and add when required

ok
