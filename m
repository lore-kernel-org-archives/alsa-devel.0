From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/1] ASoC: stm32: add of dependency for
 stm32 drivers
Date: Thu, 1 Feb 2018 13:19:28 +0000
Message-ID: <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
References: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
 <20180201091012.GA10746@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 638CF266D71
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 14:19:30 +0100 (CET)
In-Reply-To: <20180201091012.GA10746@lenoch>
Content-Language: en-US
Content-ID: <18AFC50D9BD39642A7707A77A16E5836@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

hello,

On 02/01/2018 10:10 AM, Ladislav Michl wrote:
> On Thu, Feb 01, 2018 at 09:54:41AM +0100, Olivier Moysan wrote:
>> Add of dependency for STM32 ASoC drivers.
>> DFSDM of dependency is already inherited
>> from STM32_DFSDM_ADC dependency.
>>
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>   sound/soc/stm/Kconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
>> index 3ad881f..b5375f9 100644
>> --- a/sound/soc/stm/Kconfig
>> +++ b/sound/soc/stm/Kconfig
>> @@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
>>   config SND_SOC_STM32_SAI
>>   	tristate "STM32 SAI interface (Serial Audio Interface) support"
>>   	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on OF
> 
> depends on (ARCH_STM32 && OF) || COMPILE_TEST ?
> 

I can find in many configs "depends on OF && (ARCH_X || COMPILE_TEST)"
This seems reasonable to me, as the driver always requires OF 
dependency, regardless the compilation context.
In fact, I cannot see why OF would not have to be selected
for COMPILE_TEST.

BRs

>>   	depends on SND_SOC
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>> @@ -12,6 +13,7 @@ config SND_SOC_STM32_SAI
>>   config SND_SOC_STM32_I2S
>>   	tristate "STM32 I2S interface (SPI/I2S block) support"
>>   	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on OF
>>   	depends on SND_SOC
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>> @@ -21,6 +23,7 @@ config SND_SOC_STM32_I2S
>>   config SND_SOC_STM32_SPDIFRX
>>   	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
>>   	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on OF
>>   	depends on SND_SOC
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>> -- 
>> 1.9.1
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
