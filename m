From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise on snd-hda-intel
Date: Fri, 24 Jun 2011 09:11:06 +0800
Message-ID: <BANLkTimZHrRz-cjx3kJJziCeqaJtfiF8YA@mail.gmail.com>
References: <4E00F373.6050001@molgaard.org> <4E00F41E.5090303@molgaard.org>
	<1308691120.6844.1.camel@mattotaupa>
	<4E01A8FA.8060709@molgaard.org> <s5hr56m1923.wl%tiwai@suse.de>
	<4E022AA4.5060802@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B287524721
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 03:11:13 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1862093fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 18:11:12 -0700 (PDT)
In-Reply-To: <4E022AA4.5060802@molgaard.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/23 Sune M=F8lgaard <sune@molgaard.org>:
> Takashi Iwai wrote:
>> At Wed, 22 Jun 2011 10:34:02 +0200,
>> Sune M=F8lgaard wrote:
>>>
>>> Simple mixer control 'Front Mic',0
>>> =A0 =A0Capabilities: pvolume pswitch penum
>>> =A0 =A0Playback channels: Front Left - Front Right
>>> =A0 =A0Limits: Playback 0 - 31
>>> =A0 =A0Mono:
>>> =A0 =A0Front Left: Playback 22 [71%] [-1.50dB] [on]
>>> =A0 =A0Front Right: Playback 22 [71%] [-1.50dB] [on]
>>
>> Try to mute this.
>
> Thank you for the suggestion, but it didn't help. At least not as I
> tried to mute or downplay it in alsamixer - should I try some obscure
> command to amixer?
>
> Best regards,
>
> Sune
>


Does the noise appear when you increase  "Front Mic Boost" control
from 0dB to 30 dB ?

arecord -v -f CD -Dhw:CARD=3DIntel | aplay -v -Dhw:CARD=3DIntel
