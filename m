From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ASoC: fsl_asrc: protect macro argument
Date: Wed, 06 Dec 2017 14:53:39 +0100
Message-ID: <b96fa8a745e7d6e9de8bb70d0f335648@agner.ch>
References: <20170807063657.12581-1-stefan@agner.ch>
 <20170807070806.GA8208@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807070806.GA8208@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 2017-08-07 09:08, Nicolin Chen wrote:
> On Sun, Aug 06, 2017 at 11:36:57PM -0700, Stefan Agner wrote:
>> Protect macro argument with parentheses to avoid ambiguity.
>> This fixes a warning seen with clang:
>>   warning: logical not is only applied to the left hand side of this comparison
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Mark, you seem to have merged other patches for this driver, can you
merge this one too?

--
Stefan

> 
> Thanks
> 
>> ---
>>  sound/soc/fsl/fsl_asrc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
>> index 0f163abe4ba3..ec33dab4b909 100644
>> --- a/sound/soc/fsl/fsl_asrc.h
>> +++ b/sound/soc/fsl/fsl_asrc.h
>> @@ -57,7 +57,7 @@
>>  #define REG_ASRDOC			0x74
>>  #define REG_ASRDI(i)			(REG_ASRDIA + (i << 3))
>>  #define REG_ASRDO(i)			(REG_ASRDOA + (i << 3))
>> -#define REG_ASRDx(x, i)			(x == IN ? REG_ASRDI(i) : REG_ASRDO(i))
>> +#define REG_ASRDx(x, i)			((x) == IN ? REG_ASRDI(i) : REG_ASRDO(i))
>>
>>  #define REG_ASRIDRHA			0x80
>>  #define REG_ASRIDRLA			0x84
>> --
>> 2.13.3
>>
