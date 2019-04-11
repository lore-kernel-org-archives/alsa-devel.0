From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Fix missing break in switch statement
Date: Wed, 10 Apr 2019 22:32:30 -0500
Message-ID: <4ec7c626-b012-ea5a-4162-1cbec7fc77f3@embeddedor.com>
References: <6b953e991b303a26791facbb680efe25d3cc33c3.1554951841.git.shengjiu.wang@nxp.com>
 <d211785c-1b0f-45ea-ae08-e5d92424ba1f@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d211785c-1b0f-45ea-ae08-e5d92424ba1f@embeddedor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 4/10/19 10:24 PM, Gustavo A. R. Silva wrote:
> [+cc lkml]
> 
> On 4/10/19 10:05 PM, S.j. Wang wrote:
>> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be
>> independent of each other, so replace fall-through with break.
>>
>> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> Change in v4
>> - Add Acked-by and cc stable
>> - change the subject
>>
> 
> You should preserve the changelog of what has changed in each version, not only
> the last changes, so that there is a logical flow and the maintainers do not
> have to dig up previous versions:
> 
> Changes in v3:
> - Update subject line.
> 
> Changes in v2:
> - Fix "Fixes" tag.
> 
> 
> Also, for this type of fixes, make sure to always Cc lkml: linux-kernel@vger.kernel.org
> 

See, these are all the people and lists you should Cc:

$ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback -f sound/soc/fsl/fsl_esai.c
Timur Tabi <timur@kernel.org> (maintainer:FREESCALE SOC SOUND DRIVERS)
Nicolin Chen <nicoleotsuka@gmail.com> (maintainer:FREESCALE SOC SOUND DRIVERS)
Xiubo Li <Xiubo.Lee@gmail.com> (maintainer:FREESCALE SOC SOUND DRIVERS)
Fabio Estevam <festevam@gmail.com> (reviewer:FREESCALE SOC SOUND DRIVERS)
Liam Girdwood <lgirdwood@gmail.com> (supporter:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
Mark Brown <broonie@kernel.org> (supporter:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
alsa-devel@alsa-project.org (moderated list:FREESCALE SOC SOUND DRIVERS)
linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS)
linux-kernel@vger.kernel.org (open list)

Thanks
--
Gustavo

> 
>>  sound/soc/fsl/fsl_esai.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
>> index 3623aa9a6f2e..15202a637197 100644
>> --- a/sound/soc/fsl/fsl_esai.c
>> +++ b/sound/soc/fsl/fsl_esai.c
>> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>>  		break;
>>  	case ESAI_HCKT_EXTAL:
>>  		ecr |= ESAI_ECR_ETI;
>> -		/* fall through */
>> +		break;
>>  	case ESAI_HCKR_EXTAL:
>>  		ecr |= ESAI_ECR_ERI;
>>  		break;
>>
