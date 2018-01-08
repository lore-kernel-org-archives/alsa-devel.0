From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 4/4] ASoC: acpi: remove hard-coded
 i2c-device name length
Date: Mon, 8 Jan 2018 14:28:23 -0600
Message-ID: <12631c8f-699c-cb2f-643f-5f4c7ab982c0@linux.intel.com>
References: <20180105205536.10366-1-pierre-louis.bossart@linux.intel.com>
 <20180105205536.10366-5-pierre-louis.bossart@linux.intel.com>
 <20180108044133.GW18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 497EC2674CE
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 21:28:25 +0100 (CET)
In-Reply-To: <20180108044133.GW18649@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, jeremy@jcline.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 1/7/18 10:41 PM, Vinod Koul wrote:
> On Fri, Jan 05, 2018 at 02:55:36PM -0600, Pierre-Louis Bossart wrote:
>> Remove hard-coded [16] array size, replace with clearer description and
>> dependency on ACPI_ID_LEN
>> No functionality change
>>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/sound/soc-acpi.h                | 3 +++
>>   sound/soc/intel/boards/bytcht_da7213.c  | 2 +-
>>   sound/soc/intel/boards/bytcht_es8316.c  | 2 +-
>>   sound/soc/intel/boards/bytcr_rt5640.c   | 2 +-
>>   sound/soc/intel/boards/bytcr_rt5651.c   | 2 +-
>>   sound/soc/intel/boards/cht_bsw_rt5645.c | 4 ++--
>>   sound/soc/intel/boards/cht_bsw_rt5672.c | 2 +-
>>   7 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
>> index d1aaf876cd26..703c78483113 100644
>> --- a/include/sound/soc-acpi.h
>> +++ b/include/sound/soc-acpi.h
>> @@ -27,6 +27,9 @@ struct snd_soc_acpi_package_context {
>>   	bool data_valid;
>>   };
>>   
>> +/* codec name is used in DAIs is i2c-<HID>:00 with HID being 8 chars */
>> +#define SND_SOC_ACPI_I2C_DEVICE_NAME_LEN (4 + ACPI_ID_LEN + 3 + 1)
> 
> nitpicking, thats a very long name :(
> 
> how about SND_ACPI_I2C_ID_LEN, we can drop SOC. And replace DEVICE_NAME with ID

Fine with me. Andy do you concur or have a more precise suggestion?
