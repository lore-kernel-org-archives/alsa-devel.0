From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add
	multi-channel	supporting in Blackfin ASoC driver and AD1980
	codec driver
Date: Tue, 21 Oct 2008 18:21:25 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA02E66370@chinexm1.ad.analog.com>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org><1224560173-8728-3-git-send-email-cooloney@kernel.org><20081021083715.GA10841@sirena.org.uk><0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com><20081021091550.GE10841@sirena.org.uk><0F1B54C89D5F954D8535DB252AF412FA02E662B0@chinexm1.ad.analog.com><s5hhc762sp1.wl%tiwai@suse.de><0F1B54C89D5F954D8535DB252AF412FA02E662F8@chinexm1.ad.analog.com>
	<s5hd4hu2rna.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BDDF103830
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 12:20:16 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5hd4hu2rna.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Cai, Cliff" <Cliff.Cai@analog.com>
Cc: Bryan Wu <cooloney@kernel.org>, Mark Brown <broonie@sirena.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de] 
>Sent: Tuesday, October 21, 2008 6:02 PM
>To: Cai, Cliff
>Cc: Mark Brown; Bryan Wu; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: Blackfin: add 
>multi-channel supporting in Blackfin ASoC driver and AD1980 
>codec driver
>
>At Tue, 21 Oct 2008 17:48:56 +0800,
>Cai, Cliff wrote:
>> 
>>  
>> 
>> >-----Original Message-----
>> >From: Takashi Iwai [mailto:tiwai@suse.de]
>> >Sent: Tuesday, October 21, 2008 5:39 PM
>> >To: Cai, Cliff
>> >Cc: Mark Brown; Bryan Wu; alsa-devel@alsa-project.org
>> >Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: Blackfin: add 
>> >multi-channel supporting in Blackfin ASoC driver and AD1980 codec 
>> >driver
>> >
>> >At Tue, 21 Oct 2008 17:35:49 +0800,
>> >Cai, Cliff wrote:
>> >> 
>> >>  
>> >> 
>> >> >-----Original Message-----
>> >> >From: Mark Brown [mailto:broonie@sirena.org.uk]
>> >> >Sent: Tuesday, October 21, 2008 5:16 PM
>> >> >To: Cai, Cliff
>> >> >Cc: Bryan Wu; alsa-devel@alsa-project.org
>> >> >Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel
>> >supporting
>> >> >in Blackfin ASoC driver and AD1980 codec driver
>> >> >
>> >> >On Tue, Oct 21, 2008 at 05:08:31PM +0800, Cai, Cliff wrote:
>> >> >
>> >> >> >To be honest, I'm surprised that the multi-channel support
>> >> >can't only
>> >> >> >incur the extra memory consumpton when playing back a 
>> >> >> >multi-channel stream - I'd have expected the hardware to work 
>> >> >> >in the same
>> >> >way for a
>> >> >> >normal stereo stream even if multi-channel support is 
>built in.
>> >> >
>> >> >> Yes,hardware almost works in the same way as playing a stereo 
>> >> >> stream,except That it need to fill more data to DMA memory 
>> >> >> manually,since we just simulate AC97 Controller using 
>serial port.
>> >> >
>> >> >My point is that the configuration of the hardware for
>> >multi-channel
>> >> >playback only needs to be done when actually playing back 
>> >> >multi-channel data.  When playing back stereo data it should be 
>> >> >possible to configure the hardware and do the simulation in
>> >the same
>> >> >way as when multi-channel support is not compiled in and 
>avoid the 
>> >> >additional costs which that incurs.
>> >> >
>> >> >As well as saving memory I'd expect configuring this at 
>runtime to 
>> >> >also save some power when playing back two or four channel data.
>> >> >
>> >> 
>> >> Yes, it's an ideal way,but it's not safe to allocate
>> >continuous memory
>> >> dynamicly, Since embedded system has limited uncached DMA memory.
>> >
>> >But, CONFIG_SND_MULTICHAN_SUPPORT would change any buffer 
>allocation 
>> >behavior?  I don't find it...
>> 
>> It will change the ac97 frame size defined in bf5xx-ac97.h,the frame 
>> size the basic unit of the DMA buffer
>
>Ah, I see.  Then I find this patch OK, at least, changes for 
>blackfin part.
>Basically MULTICHAN_SUPPORT will require more resources, but 
>it still provides the same functionality as without it.
>
>BTW, are your changes to ad1980.c applicable unconditionally?
>For example,
>> --- a/sound/soc/codecs/ad1980.c
>> +++ b/sound/soc/codecs/ad1980.c
>> @@ -145,7 +145,7 @@ struct snd_soc_dai ad1980_dai = {
>>  	.playback = {
>>  		.stream_name = "Playback",
>>  		.channels_min = 2,
>> -		.channels_max = 2,
>> +		.channels_max = 6,
>
>This won't work if the machine side doesn't support the 
>multi-channel.  Right now, blackfin is the only one, but the 
>codec driver should be generic.

This is a problem,what's your suggestion?
I think if the CPU DAI only supports stereo,alsa will omit the 6 channel
support for codec,am I wrong?
It works for me,since I provide two choices for CPU DAI,2 or 6
channel(through CONFIG_SND_MULTICHAN_SUPPORT). 

>Also, the below is dangerous:
>
>> @@ -256,6 +256,9 @@ static int ad1980_soc_probe(struct 
>platform_device 
>> *pdev)
>> +	ac97_write(codec, AC97_EXTENDED_STATUS, 0x0000);/*power on LFE 
>> +CENTER and Surround DACs*/
>
>This will disable all other features, too.

OK, I will only enable the DACs needed.

>
>thanks,
>
>Takashi
>
