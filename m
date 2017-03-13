From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/5] ASoC: da7213: add ACPI support
Date: Mon, 13 Mar 2017 14:07:55 -0500
Message-ID: <5c0818d5-13c3-10e5-71da-7e7ec6ab3d3d@linux.intel.com>
References: <1489105142-25878-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1489105142-25878-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <2E89032DDAA8B9408CB92943514A03370142A9AD76@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 323FF266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 20:08:00 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03370142A9AD76@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 3/13/17 11:10 AM, Adam Thomson wrote:
> On 10 March 2017 00:19, Pierre-Louis Bossart wrote:
>
>> Add DLGS7212 and DLGS7213 HID
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>  sound/soc/codecs/da7213.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
>> index 12da558..6dd7578 100644
>> --- a/sound/soc/codecs/da7213.c
>> +++ b/sound/soc/codecs/da7213.c
>> @@ -12,6 +12,7 @@
>>   * option) any later version.
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>>  #include <linux/i2c.h>
>> @@ -1528,12 +1529,23 @@ static int da7213_set_bias_level(struct snd_soc_codec
>> *codec,
>>  	return 0;
>>  }
>>
>> +#if defined(CONFIG_OF)
>>  /* DT */
>>  static const struct of_device_id da7213_of_match[] = {
>>  	{ .compatible = "dlg,da7213", },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(of, da7213_of_match);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id da7213_acpi_match[] = {
>> +	{ "DLGS7212", 0},
>> +	{ "DLGS7213", 0},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, da7213_acpi_match);
>> +#endif
>
> The #ifdefs aren't strictly necessary here so might be cleaner to remove them.

Looks like Mark applied the patch already. We've had all sort of reports 
in the past that everything need to build without ACPI so I prefer to 
err on the cautious side.

>
>>
>>  static enum da7213_micbias_voltage
>>  	da7213_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
>> @@ -1844,6 +1856,7 @@ static struct i2c_driver da7213_i2c_driver = {
>>  	.driver = {
>>  		.name = "da7213",
>>  		.of_match_table = of_match_ptr(da7213_of_match),
>> +		.acpi_match_table = ACPI_PTR(da7213_acpi_match),
>>  	},
>>  	.probe		= da7213_i2c_probe,
>>  	.remove		= da7213_remove,
>> --
>> 2.7.4
>
> As a general comment, it would be nice if the current of_property_read_* calls
> could be converted to device_property_read_* calls instead, so both ACPI and DT
> initialisation of bindings is supported.

It's something we can test with the MinnowBoard by just adding _DSD 
properties to the ACPI definitions. But I am not too hot on doing this 
myself since I have no ARM platform to test for non-regressions.
