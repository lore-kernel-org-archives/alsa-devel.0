From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Re: DM365 McBSP as Master
Date: Wed, 30 Nov 2011 16:09:20 +0530
Message-ID: <CAODvfaHc4TosGn40kKwNe-ees1iimG26sFcoJHVbHPTdDUPmhg@mail.gmail.com>
References: <CAODvfaF4f0ZrPQdR1CiFBp5=WZAkj9fQnjNPgdY15c0wYW-fkA@mail.gmail.com>
	<4E78A059.4010300@mentor.com>
	<CAODvfaG=uSC0J6-q+Cd6cb4Sfb1gNRoYE2UCAziKmtVKa2_qeQ@mail.gmail.com>
	<CAODvfaEEwdPbZGz91H-F080nfPh33r8Y16aCoB83SeghaMGqbA@mail.gmail.com>
	<4E7C3039.1090203@mentor.com>
	<CAODvfaEMx+Jz0dYbUcPsyJ6JWKXi-_wmbXC=MsC11Jv+PUuJ1g@mail.gmail.com>
	<4E9BF5A0.5090203@mentor.com>
	<CAODvfaFCDuQWGNKHuNWNSOU3d4vcwj-7WquA9xfuCCk1dOYQ7w@mail.gmail.com>
	<CAODvfaHtaNp=9stMC8LduRsKwpGTwQ-3R4=yKoRodzVBABEXPA@mail.gmail.com>
	<4E9C23FD.2090106@ladisch.de>
	<CAODvfaE1Sp-=GYx=A3tM55Xn+hWTQzb4NmH+3nnn0F0jznwniA@mail.gmail.com>
	<4EA5B107.9090904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B0138103A5D
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 11:39:22 +0100 (CET)
Received: by ggnv5 with SMTP id v5so251394ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 02:39:20 -0800 (PST)
In-Reply-To: <4EA5B107.9090904@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vladimir Barinov <Vladimir_Barinov@mentor.com>
List-Id: alsa-devel@alsa-project.org

Hi Clemens, Vladimir and All,

I found the problem. in my audio driver.

In snd_soc_dai structure i have commented the

//.symmetric_rates = 1
then this issue not coming.

I verified this structure in tlv320aic3x.c file there is no such
parameter, so i commented this and resolved this problem.

Could you please tell me what for this parameter is required.

Thank you all,
Sreedhar.



On 10/25/11, Clemens Ladisch <clemens@ladisch.de> wrote:
> Appalayagari Sreedhar wrote:
>> Thank you very much. but for the tlv320aic3x codec it works.
>> tlv320aic3x device is also duplex device. and also after aplay
>> calling, i can succesfully open the device for my codec driver.
>> could you please tell me what i am missing  and also why it is working
>> for the tlv320aic3x device.
>
> There's probably some difference in the behaviour of the two drivers
> regarding multiple opens.  Which drivers are you using (the codecs
> don't matter)?
>
>
> Regards,
> Clemens
>
