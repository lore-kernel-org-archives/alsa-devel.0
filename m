From: "Nie Jun" <niej0001@gmail.com>
Subject: Re: noise and consume pcm faster
Date: Fri, 5 Sep 2008 15:49:42 +0800
Message-ID: <7c34ac520809050049v63fd98f9ie7b7e654c85487c6@mail.gmail.com>
References: <7c34ac520809020200l290f78d3l5e7146bfb567e739@mail.gmail.com>
	<7c34ac520809020240i1234a011v9e0ae3a5f2c8a860@mail.gmail.com>
	<s5h4p4xnz6f.wl%tiwai@suse.de>
	<7c34ac520809042100p2171a726y763d6c3d385b9544@mail.gmail.com>
	<7c34ac520809042102o45feca83lf6eb3b4aadbc95d3@mail.gmail.com>
	<s5h1vzzunli.wl%tiwai@suse.de>
	<7c34ac520809042334u263597e6h49efdd9f958a1927@mail.gmail.com>
	<s5hsksft7f5.wl%tiwai@suse.de>
	<7c34ac520809050044u1c1cc953hcb64cb2e1ac6cc2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id B926110382A
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 09:49:43 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so138019eyc.56
	for <alsa-devel@alsa-project.org>; Fri, 05 Sep 2008 00:49:43 -0700 (PDT)
In-Reply-To: <7c34ac520809050044u1c1cc953hcb64cb2e1ac6cc2d@mail.gmail.com>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is strange that there is no noise in the first several seconds. It seems
like a buffer overflow with too much data accumulated. However, there should
not be overflow in playback, right?


2008/9/5 Nie Jun <niej0001@gmail.com>

> I do not know how these two params will be modified by ALSA lib. It does
> not directly accept specified value.
> With this cmd:
> ./aplay 48k_stero.wav -F5120 -B106400
> I get the nearest setting as following, but still has noise.
>
> channels: 2
> rate: 48000 (48000/1)
> period_size: 248
> buffer_size: 5208
>
>
>
> 2008/9/5 Takashi Iwai <tiwai@suse.de>
>
> At Fri, 5 Sep 2008 14:34:51 +0800,
>> Nie Jun wrote:
>> >
>> > I can not figure out the reason of noise and faster consumption from
>> these
>> > different. Do you have any idea about these different? Or any other data
>> may
>> > contain clue?
>>
>> So, do you mean that the problem persists even if you use the exactly
>> same period_size and buffer_size as OSS (i.e. 256 and 5120)?
>>
>>
>> Takashi
>>
>
>
