From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCHv2 1/4] ASoC: simple-card: add
 asoc_simple_card_fmt_master() to simplify the code.
Date: Tue, 2 Sep 2014 14:32:00 +0300
Message-ID: <5405AAB0.5030000@ti.com>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>	<1409649969-15759-2-git-send-email-Li.Xiubo@freescale.com>	<54059A35.3020303@gmail.com>	<20140902123848.78c4c62a@armhf>	<54059F20.4080509@gmail.com>
 <20140902130912.65c5b750@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 989B5264EAA
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 13:32:07 +0200 (CEST)
In-Reply-To: <20140902130912.65c5b750@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Varka Bhadram <varkabhadram@gmail.com>
Cc: mark.rutland@arm.com, andrew@lunn.ch, alsa-devel@alsa-project.org, pawel.moll@arm.com, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, tiwai@suse.de, Xiubo Li <Li.Xiubo@freescale.com>, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/02/2014 02:09 PM, Jean-Francois Moine wrote:
> On Tue, 02 Sep 2014 16:12:40 +0530
> Varka Bhadram <varkabhadram@gmail.com> wrote:
>
>>>>> +	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
>>>>> +	case 0x11:
>>>>> +		return SND_SOC_DAIFMT_CBS_CFS;
>>>>> +	case 0x10:
>>>>> +		return SND_SOC_DAIFMT_CBS_CFM;
>>>>> +	case 0x01:
>>>>> +		return SND_SOC_DAIFMT_CBM_CFS;
>>>>> +	default:
>>>>> +		return SND_SOC_DAIFMT_CBM_CFM;
>>>>> +	}
>>>>> +
>>>>> +	/* Shouldn't be here */
>>>>> +	return -EINVAL;
>>>>> +}
>>>> It will be nice if we declare the switch case numbers as macros (specific name)...
>>> I don't see which macros: the values are just 2 booleans.
>>>
>> I am talking about 0x11, 0x10, 0x01 values.. We can give any understandable
>> names to those...?
>
> #define TRUE_TRUE 0x11
> #define TRUE_FALSE 0x10
> #define FALSE_TRUE 0x01
>
> or
>
> 	case ((TRUE << 4) | TRUE:
> 		...
> 	case ((TRUE << 4) | FALSE:
> 		...
> 	case ((FALSE << 4) | TRUE:
> 		...
>

I would vote for this. Even over the options suggested by Takashi, but 
then again this really a matter of taste.

The fact that frame and bit-clock master boolean values are bundled into 
a single "enum" field, instead of two dedicated bits, makes all options 
bit inconvenient.

Best regards,
Jyri
