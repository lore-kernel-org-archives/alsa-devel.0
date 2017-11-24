From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 08/13] regmap: add SLIMbus support
Date: Fri, 24 Nov 2017 14:39:47 +0000
Message-ID: <a1d79f5e-882f-b761-ebfd-d3354e1b8fe2@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-9-srinivas.kandagatla@linaro.org>
 <20171123074925.hk3omwaqkg7swwmw@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id DCFF426742C
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 15:39:49 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id r68so23184752wmr.1
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 06:39:49 -0800 (PST)
Received: from [192.168.0.18]
 (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
 by smtp.googlemail.com with ESMTPSA id w10sm15064901edj.11.2017.11.24.06.39.48
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Nov 2017 06:39:48 -0800 (PST)
In-Reply-To: <20171123074925.hk3omwaqkg7swwmw@localhost.localdomain>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the Review,

On 23/11/17 07:49, Charles Keepax wrote:
> On Wed, Nov 15, 2017 at 02:10:38PM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to read/write slimbus value elements.
>> Currently it only supports byte read/write. Adding this support in
>> regmap would give codec drivers more flexibility when there are more
>> than 2 control interfaces like slimbus, i2c.
>>
>> Without this patch each codec driver has to directly call slimbus value
>> element apis, and this could would get messy once we want to add i2c
>> interface to it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> +
>> +static int regmap_slimbus_byte_reg_read(void *context, unsigned int reg,
>> +					unsigned int *val)
>> +{
>> +	struct slim_device *sdev = context;
>> +	int v;
>> +
>> +	if (!sdev)
>> +		return 0;
> 
> Is there a specific reason we are checking the context here? The
> other regmap buses don't both and whilst I don't mind checking
> shouldn't we return an error if we don't have a context rather
> than pretending to succeed?
looks like over done here, I will fix it in next version.

> 
>> +
>> +	v = slim_readb(sdev, reg);
>> +
>> +	if (v < 0)
>> +		return v;
>> +
>> +	*val = v;
>> +
>> +	return 0;
>> +}
>> +
>> +static int regmap_slimbus_byte_reg_write(void *context, unsigned int reg,
>> +					 unsigned int val)
>> +{
>> +	struct slim_device *sdev = context;
>> +
>> +	if (!sdev)
>> +		return 0;
> 
> ditto.
> 
> Thanks,
> Charles
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
