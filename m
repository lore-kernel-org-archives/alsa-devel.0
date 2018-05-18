From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: pcm512x: Add ACPI support
Date: Fri, 18 May 2018 11:07:26 -0500
Message-ID: <e4567264-1362-7a9d-7883-5b5dd8f96c5d@linux.intel.com>
References: <20180517225326.30881-1-pierre-louis.bossart@linux.intel.com>
 <20180518043639.GF2932@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 57E332672AF
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 18:07:29 +0200 (CEST)
In-Reply-To: <20180518043639.GF2932@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 5/17/18 11:36 PM, Vinod wrote:
> On 17-05-18, 17:53, Pierre-Louis Bossart wrote:
>> HID is assumed to be made of TI PCI ID (0x104C) + part number, so all
>> four 104C5121, 104C5122, 104C5141 104C5142 are valid.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
> 
> ...
> 
>>   static struct i2c_driver pcm512x_i2c_driver = {
>>   	.probe 		= pcm512x_i2c_probe,
>> @@ -67,7 +81,8 @@ static struct i2c_driver pcm512x_i2c_driver = {
>>   	.id_table	= pcm512x_i2c_id,
>>   	.driver		= {
>>   		.name	= "pcm512x",
>> -		.of_match_table = pcm512x_of_match,
>> +		.of_match_table = of_match_ptr(pcm512x_of_match),
> 
> this change may not be part of this and should be mentioned in the log
> 
> Also quick grep tells me kernel has both :(

I don't get your point. This is how we've added support for ACPI for 
every codec so far, and using those macros is the way to make sure the 
DT case still builds and isn't impacted.

> 
>> +		.acpi_match_table = ACPI_PTR(pcm512x_acpi_match),
>>   		.pm     = &pcm512x_pm_ops,
>>   	},
>>   };
>> -- 
>> 2.14.1
> 
