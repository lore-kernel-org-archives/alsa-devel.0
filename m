From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd-hdsp driver error?
Date: Tue, 19 Jan 2010 15:08:05 +0800
Message-ID: <4f3252891001182308s4f05a562u78655bb3e495ae9b@mail.gmail.com>
References: <933ed0910911020433j59c4907q94ee073e5f09e328@mail.gmail.com>
	<4f3252890911042029m18db97d0qc324b37d1c1dd330@mail.gmail.com>
	<933ed0910911051646u71594153ue23984ae32c70d8e@mail.gmail.com>
	<4f3252890911051753x650bc617te8086af4fc3a745f@mail.gmail.com>
	<933ed0910911060823x4f512b32h546167eea73050df@mail.gmail.com>
	<4f3252890911061512i5f6c439cyd977e5fb67c84693@mail.gmail.com>
	<s5h4op5qp94.wl%tiwai@suse.de>
	<933ed0910911081030p1323d375g7fd719358bfa9e9@mail.gmail.com>
	<4f3252891001140802y7bb31156q74f87ba13bca82f4@mail.gmail.com>
	<933ed0911001160530n79a0bb06m5ffb44c40565d5de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 18F6C244AD
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 08:08:06 +0100 (CET)
Received: by pwi4 with SMTP id 4so6820222pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 23:08:06 -0800 (PST)
In-Reply-To: <933ed0911001160530n79a0bb06m5ffb44c40565d5de@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/1/16 Lars Zobbe <fedesensfar@gmail.com>

> Thansk a lot Raymond. That actually works! My HDSP now loads without mayor
> problems. This is brilliant. I've been struggling for so long to make this
> work and finally...
> I recommend everyone with a RME HDSP, who wants to use pulseaudio, to check
> out ticket 764.
> Thanks again Raymond.
> Lars.
>
> 2010/1/14 Raymond Yau <superquad.vortex2@gmail.com>
>
>>
>> Refer to
>>
>> http://pulseaudio.org/ticket/764#comment:1
>>
>>
>> load-module module-alsa-sink device_id=0 tsched=0
>>
> load-module module-alsa-source device_id=0 tsched=0
>>
>
if your hdsp works , this mean that this is a bug introduced at pulseaudio
since 0.9.15 ( working profile )

I guess none of PA develpers had your card ,

if you want the pulseaudio bug fixed ,

you will need to post the output of full pulseaudio log of module-alsa-sink
( pulseaudio -k;pulseaudio -vvvvv ) and the outout of aplay -v -Dplughw:0,0
any.wav

in the pulseaudio bug tracker

 so that PA developer can compare with the non-working pulseaudio log
