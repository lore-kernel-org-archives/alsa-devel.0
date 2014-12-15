From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 1/3] ASoC: codecs: wm8904: add dt ids table
Date: Mon, 15 Dec 2014 11:28:20 +0800
Message-ID: <548E5554.6050900@atmel.com>
References: <1418267681-4091-1-git-send-email-voice.shen@atmel.com> <20141212132321.GI11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20141212132321.GI11764@sirena.org.uk>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Alexander Morozov <linux@meltdown.ru>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 12/12/2014 09:23 PM, Mark Brown wrote:
> On Thu, Dec 11, 2014 at 11:14:39AM +0800, Bo Shen wrote:
>
>> +static const struct of_device_id wm8904_of_match[] = {
>> +	{ .compatible = "wlf,wm8904", },
>> +	{ .compatible = "wlf,wm8912", },
>> +	{ .compatible = "wlf,wm8918", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, wm8904_of_match);
>> +
>>   static struct i2c_driver wm8904_i2c_driver = {
>>   	.driver = {
>>   		.name = "wm8904",
>>   		.owner = THIS_MODULE,
>> +		.of_match_table = wm8904_of_match,
>
> I'm not seeing anything here that ensures that devtype is set correctly
> when probing using the OF IDs - currently we rely on i2c->driver_data.
>

I will add it in v2 patch.
Thanks.

Best Regards,
Bo Shen
