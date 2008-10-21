From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel
	supporting in Blackfin ASoC driver and AD1980 codec driver
Date: Tue, 21 Oct 2008 17:55:23 +0800
Message-ID: <386072610810210255s5a267db3h65a4c6c1bfca19f3@mail.gmail.com>
References: <1224560173-8728-1-git-send-email-cooloney@kernel.org>
	<1224560173-8728-3-git-send-email-cooloney@kernel.org>
	<20081021083715.GA10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E66236@chinexm1.ad.analog.com>
	<20081021091550.GE10841@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA02E662B0@chinexm1.ad.analog.com>
	<s5hhc762sp1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E2A8103807
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 11:55:42 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so754701ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2008 02:55:23 -0700 (PDT)
In-Reply-To: <s5hhc762sp1.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, Mark Brown <broonie@sirena.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 5:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 21 Oct 2008 17:35:49 +0800,
> Cai, Cliff wrote:
>>
>>
>>
>> >-----Original Message-----
>> >From: Mark Brown [mailto:broonie@sirena.org.uk]
>> >Sent: Tuesday, October 21, 2008 5:16 PM
>> >To: Cai, Cliff
>> >Cc: Bryan Wu; alsa-devel@alsa-project.org
>> >Subject: Re: [PATCH 2/3] ASoC: Blackfin: add multi-channel
>> >supporting in Blackfin ASoC driver and AD1980 codec driver
>> >
>> >On Tue, Oct 21, 2008 at 05:08:31PM +0800, Cai, Cliff wrote:
>> >
>> >> >To be honest, I'm surprised that the multi-channel support
>> >can't only
>> >> >incur the extra memory consumpton when playing back a multi-channel
>> >> >stream - I'd have expected the hardware to work in the same
>> >way for a
>> >> >normal stereo stream even if multi-channel support is built in.
>> >
>> >> Yes,hardware almost works in the same way as playing a stereo
>> >> stream,except That it need to fill more data to DMA memory
>> >> manually,since we just simulate AC97 Controller using serial port.
>> >
>> >My point is that the configuration of the hardware for
>> >multi-channel playback only needs to be done when actually
>> >playing back multi-channel data.  When playing back stereo
>> >data it should be possible to configure the hardware and do
>> >the simulation in the same way as when multi-channel support
>> >is not compiled in and avoid the additional costs which that incurs.
>> >
>> >As well as saving memory I'd expect configuring this at
>> >runtime to also save some power when playing back two or four
>> >channel data.
>> >
>>
>> Yes, it's an ideal way,but it's not safe to allocate continuous memory
>> dynamicly,
>> Since embedded system has limited uncached DMA memory.
>
> But, CONFIG_SND_MULTICHAN_SUPPORT would change any buffer allocation
> behavior?  I don't find it...
>
> Anyway, I agree with Mark.  The setup can be ideally dynamically
> changed.
>

Basically, I like Mark's idea.

But you know, it is very difficult for us to allocate big buffer in an
NOMMU machine (such as Blackfin) on the fly, So we prefer to allocate
them at the beginning. And in the embedded world, when the user want
to use multi-channel function, they will enable this option. If they
don't, they won't do that. It is very simple for both us and our
users, although it is less elegant than Mark's idea.

-Bryan
