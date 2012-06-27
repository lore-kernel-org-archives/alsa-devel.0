From: rashmi narayan <rashmi.nyn@gmail.com>
Subject: Re: Configuring an audio path within ALSA
Date: Wed, 27 Jun 2012 17:34:47 +0530
Message-ID: <CABTnDnPpvSsrU-iQhv9ntvR+3LgL7uoD7DgqkVU9eqiJX30TeA@mail.gmail.com>
References: <CABTnDnPfGF8AddTSQ4GPyyvosQVa7K6Koda2cz79dknxWMaTVg@mail.gmail.com>
	<4FE924E2.2010504@codeaurora.org>
	<CABTnDnNv4tjHUY4MTTUxT_aiLUof85SpJLqV6ooEiqJF1yTLqA@mail.gmail.com>
	<4FEA99D6.3000308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B17C104345
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 14:04:48 +0200 (CEST)
Received: by eaaa1 with SMTP id a1so306575eaa.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2012 05:04:47 -0700 (PDT)
In-Reply-To: <4FEA99D6.3000308@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 27, 2012 at 10:57 AM, Patrick Lai <plai@codeaurora.org> wrote:

> On 6/26/2012 12:52 AM, rashmi narayan wrote:
>
>> Thank you Patrick .
>>
>> Currently my codec driver SGTL5000.c has the following audio map
>> static const struct snd_soc_dapm_route audio_map[] = {
>> {"ADC Mux", "LINE_IN", "LINE_IN"},
>> {"ADC Mux", "MIC_IN", "MIC_IN"},
>> {"ADC", NULL, "ADC Mux"},
>> {"DAC Mux", "DAC", "DAC"},
>> {"DAC Mux", "LINE_IN", "LINE_IN"},
>> {"LO", NULL, "DAC"},
>> {"HP", NULL, "DAC Mux"},
>> {"LINE_OUT", NULL, "LO"},
>> {"HP_OUT", NULL, "HP"},
>> };
>>
>> This map does not have a link from ADC to DAC.
>> You mention "After a set of ALSA mixer commands is issued to create a
>> path from one end point to another end point" , how do we issue those
>> commands? to create a link , currently my alsa mixer shows no option for
>> a ADC to DAC select.
>>
>
> If you have widgets defined matching what you specify in audio_map, you
> should see mixer command i.e "ADC Mux' base on audio map you have
> given. Then you give amixer 'ADC Mux' 'LINE_IN', this would translate
> to writing codec register to have ADC Mux take LINE_IN as input. Audio
> map is defined base on your CODEC topology. I would not be able to
> comment on how to enable CODEC loopback for your CODEC. However,
> the audio map you provided above is kind of fishy. For example,
> shouldn't DAC be sink instead of source
> {"DAC", "DAC", "DAC MUX"} as opposed to {"DAC Mux", "DAC", "DAC"}
>
>
  The DAC MUX is a misnomer , it can be thought of as HeadphoneMux where
the inputs are LINE_IN and DAC(arch of SGTL5000).
The datasheet has a DAC select register to choose between ADC and I2S_
IN(I2S In is default) . I don't see that in the map.
 The driver doesn't understand the command * amixer 'ADC Mux' 'LINE_IN' *it
understands amixer control or alsamixer though .
 So is there any other option for the connect source to destination
command... Am I missing something here?


>> -Rashmi
>>
>>
>>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
