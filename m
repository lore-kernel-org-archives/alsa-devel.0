From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [INTERNAL][PATCH 4/7] ASoC: stm32: sai: fix stop
 management in isr
Date: Thu, 2 Nov 2017 16:38:36 +0000
Message-ID: <dcb5104f-2d32-f51b-16ba-4cdb9f4c5e59@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
 <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
 <s5hmv4ekjr4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 40E2E266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 17:38:38 +0100 (CET)
In-Reply-To: <s5hmv4ekjr4.wl-tiwai@suse.de>
Content-Language: en-US
Content-ID: <172B85CB8331A3469F89F22D57732EF8@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Sorry for late answer. I was OoO.
Ok, I will add a protection on sai->substream accesses.

Best regards
Olivier


On 10/26/2017 05:32 PM, Takashi Iwai wrote:
> On Thu, 19 Oct 2017 15:03:20 +0200,
> Olivier Moysan wrote:
>>
>> Add check on substream validity.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
>> ---
>>   sound/soc/stm/stm32_sai_sub.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
>> index 2af397d..815ef10 100644
>> --- a/sound/soc/stm/stm32_sai_sub.c
>> +++ b/sound/soc/stm/stm32_sai_sub.c
>> @@ -184,7 +184,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
>>   static irqreturn_t stm32_sai_isr(int irq, void *devid)
>>   {
>>   	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
>> -	struct snd_pcm_substream *substream = sai->substream;
>>   	struct platform_device *pdev = sai->pdev;
>>   	unsigned int sr, imr, flags;
>>   	snd_pcm_state_t status = SNDRV_PCM_STATE_RUNNING;
>> @@ -199,6 +198,11 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
>>   	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
>>   			   SAI_XCLRFR_MASK);
>>   
>> +	if (!sai->substream) {
>> +		dev_err(&pdev->dev, "Device stopped. Spurious IRQ 0x%x\n", sr);
>> +		return IRQ_NONE;
>> +	}
>> +
>>   	if (flags & SAI_XIMR_OVRUDRIE) {
>>   		dev_err(&pdev->dev, "IRQ %s\n",
>>   			STM_SAI_IS_PLAYBACK(sai) ? "underrun" : "overrun");
>> @@ -227,9 +231,9 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
>>   	}
>>   
>>   	if (status != SNDRV_PCM_STATE_RUNNING) {
>> -		snd_pcm_stream_lock(substream);
>> -		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
>> -		snd_pcm_stream_unlock(substream);
>> +		snd_pcm_stream_lock(sai->substream);
>> +		snd_pcm_stop(sai->substream, SNDRV_PCM_STATE_XRUN);
>> +		snd_pcm_stream_unlock(sai->substream);
> 
> Actually changing to sai->substream opens a race, so this chunk is a
> bad move, at least.  We have no protection of sai->substream in this
> context, thus it can hit a NULL dereference...
> 
> 
> thanks,
> 
> Takashi
> 
