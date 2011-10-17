From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Re: DM365 McBSP as Master
Date: Mon, 17 Oct 2011 18:56:22 +0530
Message-ID: <CAODvfaE1Sp-=GYx=A3tM55Xn+hWTQzb4NmH+3nnn0F0jznwniA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9E5B244A3
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 15:26:23 +0200 (CEST)
Received: by ggnf2 with SMTP id f2so3233162ggn.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 06:26:22 -0700 (PDT)
In-Reply-To: <4E9C23FD.2090106@ladisch.de>
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

Hi Clemens,

Thank you very much. but for the tlv320aic3x codec it works.
tlv320aic3x device is also duplex device. and also after aplay
calling, i can succesfully open the device for my codec driver.
could you please tell me what i am missing  and also why it is working
for the tlv320aic3x device.

Thank you,
Sreedhar.

On 10/17/11, Clemens Ladisch <clemens@ladisch.de> wrote:
> Clemens
> Regards,
>
>
> implementations; you should open the device twice.
> the device in full duplex mode.  This is not supported by most OSS
> O_RDWR indicates that you want to use the same file handle to use
>
>
> Appalayagari Sreedhar wrote:
>> root@dm368-evm:/# ./myoss
>> Audio Driver failed to open, oss_fd = -1 errno = 22
>>
>> On 10/17/11, Appalayagari Sreedhar <sreecha01@gmail.com> wrote:
>>> i found that if i open the device O_WRONLY and O_RDONLY mode it works.
>>> if i try to open the device using the O_RDWR mode it fails.
>
