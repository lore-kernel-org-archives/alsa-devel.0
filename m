From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [alsa-devel] [PATCH][next] ASoC: Intel: bytcht_es8316: make
 mic_name static, reduces object code size
Date: Thu, 24 Jan 2019 17:29:21 +0000
Message-ID: <3924961d-1687-0553-09ea-6f515dee7d40@canonical.com>
References: <20190124170621.7583-1-colin.king@canonical.com>
 <08226544-958f-cf49-2a39-2a281f792954@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08226544-958f-cf49-2a39-2a281f792954@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 24/01/2019 17:27, Pierre-Louis Bossart wrote:
> 
>> diff --git a/sound/soc/intel/boards/bytcht_es8316.c
>> b/sound/soc/intel/boards/bytcht_es8316.c
>> index fa9c4cf97686..1364e4e601d8 100644
>> --- a/sound/soc/intel/boards/bytcht_es8316.c
>> +++ b/sound/soc/intel/boards/bytcht_es8316.c
>> @@ -437,7 +437,7 @@ static const struct acpi_gpio_mapping
>> byt_cht_es8316_gpios[] = {
>>     static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>>   {
>> -    const char * const mic_name[] = { "in1", "in2" };
>> +    static const char * const mic_name[] = { "in1", "in2" };
>>       struct byt_cht_es8316_private *priv;
>>       struct device *dev = &pdev->dev;
>>       struct snd_soc_acpi_mach *mach;
> 
> We have the same code pattern in two other files, so if we care about
> this we should fix it across the board(s), no?
> 
> bytcht_es8316.c:    const char * const mic_name[] = { "in1", "in2" };
> bytcr_rt5640.c:    const char * const map_name[] = { "dmic1", "dmic2",
> "in1", "in3" };
> bytcr_rt5651.c:    const char * const mic_name[] = { "dmic", "in1",
> "in2", "in12" };
> 
Good point, will resend.

Colin
