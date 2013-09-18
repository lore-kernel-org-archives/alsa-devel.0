From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 08:10:27 -0700
Message-ID: <CAOesGMjgvfqsx=Q+qJUdWPdomAkDktd1T6=sKjANC-8SnY8VPA@mail.gmail.com>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <523955BC.2050506@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 30FF72610A6
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 17:10:28 +0200 (CEST)
Received: by mail-wi0-f180.google.com with SMTP id hj3so6638761wib.1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 08:10:27 -0700 (PDT)
In-Reply-To: <523955BC.2050506@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2013 at 12:26 AM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> On 09/18/2013 09:10 AM, Olof Johansson wrote:
>>
>> Commit 02b80773de37 (ASoC: rt5640: Add ACPI probing support.) causes
>> a warning due to unreferenced variable on non-ACPI configs such as
>> tegra_defconfig on ARM:
>>
>>    sound/soc/codecs/rt5640.c:2085:30: warning: 'rt5640_acpi_match' defined
>> but not used [-Wunused-variable]
>>
>> Signed-off-by: Olof Johansson<olof@lixom.net>
>> ---
>>   sound/soc/codecs/rt5640.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
>> index 0bfb960..a856706 100644
>> --- a/sound/soc/codecs/rt5640.c
>> +++ b/sound/soc/codecs/rt5640.c
>> @@ -2082,11 +2082,13 @@ static const struct i2c_device_id rt5640_i2c_id[]
>> = {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
>>
>> +#if CONFIG_ACPI
>>   static struct acpi_device_id rt5640_acpi_match[] = {
>>         { "INT33CA", 0 },
>>         { },
>>   };
>>   MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
>> +#endif
>
> My 1c, maybe #ifdef?

Yeah, I should have sat on this until morning, I cooked it up too late
last night. :)


-Olof
