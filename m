From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: [PATCH] Line In for Acer Inspire 6530G model
Date: Tue, 30 Jun 2009 00:54:35 -0300
Message-ID: <d54969c50906292054j77aa8dd5ha0e2954b1e793f38@mail.gmail.com>
References: <20090626082750.6D1B210092@gold.linx.net>
	<s5hzlbrv76f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f189.google.com (mail-vw0-f189.google.com
	[209.85.212.189])
	by alsa0.perex.cz (Postfix) with ESMTP id F0EAA103858
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 05:54:36 +0200 (CEST)
Received: by vwj27 with SMTP id 27so76352vwj.16
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 20:54:35 -0700 (PDT)
In-Reply-To: <s5hzlbrv76f.wl%tiwai@suse.de>
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
Cc: Tony Vroon <tony@linx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/6/29 Takashi Iwai <tiwai@suse.de>:
> At Fri, 26 Jun 2009 09:27:50 +0100 (BST),
> Tony Vroon wrote:
>>
>> The Line In connector is set up as PIN_IN by default, using
>> VREF_HIZ. It is connected to both ADCs, so add it to both
>> input selectors.
>> Also add the ability to use the input mix (on a SoundBlaster
>> one would call this "What You Hear").
>>
>> Signed-off-by: Tony Vroon <tony@linx.net>
>
> I applied this as this appears safe.
> Emilio, could you check whether this works?

I don't have the necessary cable to connect my MP3/CD Player to line
in, sorry. Unless I can use a normal mic on line in (I guess not,
because mics don't have any power supply), I won't be able to test.

>
>
> thanks,
>
> Takashi
>
