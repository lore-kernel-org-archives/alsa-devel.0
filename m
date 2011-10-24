From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DM365 McBSP as Master
Date: Mon, 24 Oct 2011 20:40:07 +0200
Message-ID: <4EA5B107.9090904@ladisch.de>
References: <CAODvfaF4f0ZrPQdR1CiFBp5=WZAkj9fQnjNPgdY15c0wYW-fkA@mail.gmail.com>	<4E78A059.4010300@mentor.com>	<CAODvfaG=uSC0J6-q+Cd6cb4Sfb1gNRoYE2UCAziKmtVKa2_qeQ@mail.gmail.com>	<CAODvfaEEwdPbZGz91H-F080nfPh33r8Y16aCoB83SeghaMGqbA@mail.gmail.com>	<4E7C3039.1090203@mentor.com>	<CAODvfaEMx+Jz0dYbUcPsyJ6JWKXi-_wmbXC=MsC11Jv+PUuJ1g@mail.gmail.com>	<4E9BF5A0.5090203@mentor.com>	<CAODvfaFCDuQWGNKHuNWNSOU3d4vcwj-7WquA9xfuCCk1dOYQ7w@mail.gmail.com>	<CAODvfaHtaNp=9stMC8LduRsKwpGTwQ-3R4=yKoRodzVBABEXPA@mail.gmail.com>	<4E9C23FD.2090106@ladisch.de>
	<CAODvfaE1Sp-=GYx=A3tM55Xn+hWTQzb4NmH+3nnn0F0jznwniA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C7EF5103807
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 20:40:45 +0200 (CEST)
In-Reply-To: <CAODvfaE1Sp-=GYx=A3tM55Xn+hWTQzb4NmH+3nnn0F0jznwniA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Appalayagari Sreedhar <sreecha01@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vladimir Barinov <Vladimir_Barinov@mentor.com>
List-Id: alsa-devel@alsa-project.org

Appalayagari Sreedhar wrote:
> Thank you very much. but for the tlv320aic3x codec it works.
> tlv320aic3x device is also duplex device. and also after aplay
> calling, i can succesfully open the device for my codec driver.
> could you please tell me what i am missing  and also why it is working
> for the tlv320aic3x device.

There's probably some difference in the behaviour of the two drivers
regarding multiple opens.  Which drivers are you using (the codecs
don't matter)?


Regards,
Clemens
