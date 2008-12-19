From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/8] ALSA: ASoC: tlv320aic3x add dsp_a,
 fix dsp_b
Date: Fri, 19 Dec 2008 11:04:39 -0700
Message-ID: <494BE237.7020204@boundarydevices.com>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<bd7b27490812190204p11bd383bmb64bf62c166f4476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C03124488
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 19:04:48 +0100 (CET)
In-Reply-To: <bd7b27490812190204p11bd383bmb64bf62c166f4476@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Jarkko Nikula wrote:
> On Thu, Dec 18, 2008 at 9:36 PM, Troy Kisky
> <troy.kisky@boundarydevices.com>wrote:
> 
>> Add SND_SOC_DAIFMT_DSP_A and fix SND_SOC_DAIFMT_DSP_B
>> mode. Before dsp_b was really being initialized as dsp_a.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>>
> 
> 
>> @@ -873,6 +874,8 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai
>> *codec_dai,
>>        case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
>>                break;
>>        case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
>> +               delay = 1;
>> +       case (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF):
>>                iface_breg |= (0x01 << 6);
>>                break;
>>
> 
> Is this correct? I'm looking the WM9713 spec and there DSP_A has the 1-bit
> delay.
> 
> But I like this idea to add another DSP format.
> 
> 
> Jarkko

I think you are correct. Thanks.

But, the AIC23 and SSM2602 would then be backwards too.


Troy
