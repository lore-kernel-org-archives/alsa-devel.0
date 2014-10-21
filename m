From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/2] ARM: pxa: spitz: register spitz-audio
	device
Date: Tue, 21 Oct 2014 23:35:43 +0400
Message-ID: <CALT56yOzXrfMx7JdCOU3jUqbKV4EqTpVf4bg6c0doZCSAV-1Vw@mail.gmail.com>
References: <1413881664-24870-1-git-send-email-dbaryshkov@gmail.com>
 <87d29l1h5p.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id ED3A0260600
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 21:35:45 +0200 (CEST)
Received: by mail-ig0-f179.google.com with SMTP id h18so2070124igc.0
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:35:44 -0700 (PDT)
In-Reply-To: <87d29l1h5p.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hello,

2014-10-21 21:12 GMT+04:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
> Hi Dmitry,
>
>> Register spitz-audio device to be used by ASoC driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  arch/arm/mach-pxa/spitz.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
>> index 840c3a4..a9f971f 100644
>> --- a/arch/arm/mach-pxa/spitz.c
>> +++ b/arch/arm/mach-pxa/spitz.c
>> @@ -924,6 +924,23 @@ static inline void spitz_i2c_init(void) {}
>>  #endif
>>
>>  /******************************************************************************
>> + * Audio devices
>> + ******************************************************************************/
>> +#if defined(CONFIG_SND_PXA2XX_SOC_SPITZ) || defined(SND_PXA2XX_SOC_SPITZ_MODULE)
>> +static struct platform_device spitz_audio_device = {
>> +     .name   = "spitz-audio",
>> +     .id     = -1,
>> +};
>> +
>> +static inline void spitz_audio_init(void)
>> +{
>> +     platform_device_register(&spitz_audio_device);
>> +}
>> +#else
>> +static inline void spitz_audio_init(void) {}
>> +#endif
>
> Couldn't you eliminate the "#if defined" line , and "#else ... #endif" ?
>
> I mean that spitz_audio_init() would always register the spitz_audio_device,
> regardless of the config. The config would build or not build the sound soc
> platform driver. Would that be alright for all your usecases ?

Yes, of course. I just tried to mimic the style of the rest of the file.

I will resubmit the patch shortly.

-- 
With best wishes
Dmitry
