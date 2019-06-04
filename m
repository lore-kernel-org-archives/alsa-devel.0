From: Willem Romkes <willemromkes@rose-es.nl>
Subject: Re: atmel SSC DSP A mode
Date: Tue, 04 Jun 2019 09:15:28 +0200
Message-ID: <089a90e9c111e7a8bdd2b0d57ce05ea4@rose-es.nl>
References: <8d2cb6d3212c82c5b1430dc5e13c79c1@rose-es.nl>
 <155857e2-1fbd-f154-5316-a4426a74b7b4@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filter04.hostcontrol.com (filter04.hostcontrol.com
 [5.157.86.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8203F80054
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 09:15:36 +0200 (CEST)
In-Reply-To: <155857e2-1fbd-f154-5316-a4426a74b7b4@microchip.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Codrin.Ciubotariu@microchip.com
Cc: alsa-devel@alsa-project.org, nicolas.ferre@atmel.com
List-Id: alsa-devel@alsa-project.org

Hi Codrin, 

Thank you for responding. 

We are using the tlv320aic3107 with the tlv320aic3x codec driver. You
are correct that we could use DSP B mode. but the atmel_ssc_dai driver
doesn't support DSP B mode. On the other hand, the tlv320aic3x driver
does support DSP A mode where it just applies an offset of one bit. 

I have continued investigating this issue and I think the whole issue is
caused by our soundcard driver setting the SND_SOC_DAIFMT_IB_NF in the
DAI format, which is correct if I refer to figure 25 of the tlv320aic33
datasheet and the tlv320aic3x driver. The atmel_ssc_dai driver however
doesn't check on this and has the clock settings hard-coded and in the
current master branch it expects you to use SND_SOC_DAIFMT_NB_NF
instead. It would be a good idea to add support for the different
SND_SOC_DAIFMT_xB_xF DAI formats to the atmel_ssc_dai driver.

Best regards, 

---
Willem Romkes
 Rose Engineering Services 

 		M
 		06-48013381

 		E
 		willemromkes@rose-es.nl

 		I
 		www.rose-es.nl

On 03-06-2019 18:05, Codrin.Ciubotariu@microchip.com wrote:

> On 03.06.2019 13:19, Willem Romkes wrote: 
> 
>> *
>> *
>> 
>> Hi,
>> 
>> We are using linux-at91 and lately I have been working on adding support 
>> for a custom soundcard, a dual tlv320aic3x codec on SAMA5D3 platform. 
>> This soundcard uses DSP A mode.
>> 
>> We are facing audio issues: When we playback a WAV file with a sine 
>> wave, the codec outputs far from a clean sine wave. The problem I think 
>> is that the CKI settings for the TMCR register isn't set correctly. 
>> see commit 20cf2603b122bf71fb54def1de6a2ad73d5ddb0b
>> Author: Bo Shen <voice.shen@atmel.com>
>> Date:   Fri Jan 30 17:38:42 2015 +0800
>> 
>> ASoC: atmel_ssc_dai: fix the setting for DSP mode
>> 
>> When SCC work in DSP A mode, the data outputs/inputs are shift out on
>> falling edge, the frame sync are sample on the rising edge.
>> 
>> Reported-by: Songjun Wu <songjun.wu@atmel.com>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> 
>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c 
>> b/sound/soc/atmel/atmel_ssc_dai.c
>> index e691aab..35e44e4 100644
>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>> @@ -502,7 +502,7 @@ static int atmel_ssc_hw_params(struct 
>> snd_pcm_substream *substream,
>> rcmr =    SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
>> | SSC_BF(RCMR_STTDLY, 1)
>> | SSC_BF(RCMR_START, SSC_START_RISING_RF)
>> -                       | SSC_BF(RCMR_CKI, SSC_CKI_RISING)
>> +                       | SSC_BF(RCMR_CKI, SSC_CKI_FALLING)
>> | SSC_BF(RCMR_CKO, SSC_CKO_NONE)
>> | SSC_BF(RCMR_CKS, SSC_CKS_DIV);
>> 
>> @@ -517,7 +517,7 @@ static int atmel_ssc_hw_params(struct 
>> snd_pcm_substream *substream,
>> tcmr =    SSC_BF(TCMR_PERIOD, ssc_p->tcmr_period)
>> | SSC_BF(TCMR_STTDLY, 1)
>> | SSC_BF(TCMR_START, SSC_START_RISING_RF)
>> -                       | SSC_BF(TCMR_CKI, SSC_CKI_RISING)
>> +                       | SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
>> | SSC_BF(TCMR_CKO, SSC_CKO_CONTINUOUS)
>> | SSC_BF(TCMR_CKS, SSC_CKS_DIV);
>> 
>> @@ -546,7 +546,7 @@ static int atmel_ssc_hw_params(struct 
>> snd_pcm_substream *substream,
>> rcmr =    SSC_BF(RCMR_PERIOD, 0)
>> | SSC_BF(RCMR_STTDLY, START_DELAY)
>> | SSC_BF(RCMR_START, SSC_START_RISING_RF)
>> -                       | SSC_BF(RCMR_CKI, SSC_CKI_RISING)
>> +                       | SSC_BF(RCMR_CKI, SSC_CKI_FALLING)
>> | SSC_BF(RCMR_CKO, SSC_CKO_NONE)
>> | SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
>> SSC_CKS_PIN : SSC_CKS_CLOCK);
>> 
>> For both the TCMR and RCMR the CKI is set to SSC_CKI_FALLING, but I 
>> think for the TCMR the CKI should be set to SSC_CKI_RISING. See datasheet:
>> 
>> TCMR CKI: "1: The data outputs (Data and Frame Sync signals) are shifted 
>> out on Transmit Clock rising edge. The Frame sync signal
>> input is sampled on Transmit clock falling edge."
>> 
>> RCMR CKI: "0: The data inputs (Data and Frame Sync signals) are sampled 
>> on Receive Clock falling edge. The Frame Sync signal out-
>> put is shifted out on Receive Clock rising edge."
>> 
>> Setting the CKI in TCMR to SSC_CKI_RISING to fixes our issues.
> 
> Hi Willem,
> 
> It this DS of the codec you are using?
> http://www.ti.com/lit/ds/symlink/tlv320aic33.pd [1] 
> 
> Are you using the DSP mode described in figure 25 DSP Serial Bus Mode 
> Operation? If yes, then you should use the DSP_B mode...
> 
> Thanks and best regards,
> Codrin
 

Links:
------
[1] http://www.ti.com/lit/ds/symlink/tlv320aic33.pdf
