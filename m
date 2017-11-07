From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 3/3] ASoC: rt5645: Wait for 400msec before
 concluding on value of RT5645_VENDOR_ID2
Date: Tue, 7 Nov 2017 12:42:40 +0530
Message-ID: <8dadcaa1-8712-2f56-14bf-0d070c8c76b9@amd.com>
References: <1509741345-1589-1-git-send-email-alexander.deucher@amd.com>
 <1509741345-1589-4-git-send-email-alexander.deucher@amd.com>
 <20171106162422.vhurovalfxztf6ma@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0066.outbound.protection.outlook.com [104.47.38.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A6A4266E15
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 08:13:07 +0100 (CET)
In-Reply-To: <20171106162422.vhurovalfxztf6ma@sirena.co.uk>
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
To: Mark Brown <broonie@kernel.org>, Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, Bard Liao <bardliao@realtek.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org



On 11/6/2017 9:54 PM, Mark Brown wrote:
> On Fri, Nov 03, 2017 at 04:35:45PM -0400, Alex Deucher wrote:
> 
>> Minimum time required between power On of codec and read
>> of RT5645_VENDOR_ID2 is 400msec. We should wait and attempt
>> before erroring out.
> 
> So the description says we have to wait 400ms before attempting a
> read...

Yes, that's true.

> 
>> BUG=b:66978383
> 
> What does this mean?

A bug ID. Removing it in V2.

> 
>> @@ -3786,6 +3789,15 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>>   	}
>>   	regmap_read(regmap, RT5645_VENDOR_ID2, &val);
>>   
>> +	/*
>> +	 * Read for 400msec, as it is the interval required between
>> +	 * read and power On.
>> +	 */
>> +	while (val != RT5645_DEVICE_ID && val != RT5650_DEVICE_ID && --timeout) {
>> +		msleep(1);
>> +		regmap_read(regmap, RT5645_VENDOR_ID2, &val);
>> +	}
>> +
> 
> ...but what we actually do is try to read up to 400 times starting well
> before that 400ms is up.  This directly contradicts what the commit
> message said we needed, may take a lot longer if the chip misbehaves on
> the I2C bus while it's not ready (which wouldn't be that much of a
> surprise), might lead to us reporting before the chip is really stable
> (if the read happens to work while the chip isn't yet stable) and could
> cause lots of noise on the console if the I2C controller gets upset.
> What are we actually waiting for here?
> 

In my understanding if we get RT5645 or RT5650 DEVICE ID from register 
RT5645_VENDOR_ID2 then that means the chip is stable.

> If we really need 400ms of dead reckoning time (which is a lot for a
> modern chip, that feels more like a VMID ramp) then it's going to be
> safer to just do that.
> 

Agreed, will just sleep for 400ms before reading the register value.
