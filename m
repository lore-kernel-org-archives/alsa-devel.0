From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: regarding setting of fragment size in usbaudio
	driver
Date: Tue, 14 Dec 2010 17:23:33 +0100
Message-ID: <4D079A05.90505@ladisch.de>
References: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>	<4D05E19D.7010405@ladisch.de>	<AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>	<4D0621D0.1040403@ladisch.de>
	<AANLkTi=XTZGC08sq4XfjgEgBH7Aamct75D-XE0wQjciH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 79A3424664
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 17:23:36 +0100 (CET)
In-Reply-To: <AANLkTi=XTZGC08sq4XfjgEgBH7Aamct75D-XE0wQjciH@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Amit Nagal wrote:
> > If you want to have shorter waits, use lower fragment sizes.
> 
> yes ,  setting of lower fragment size is my requirement at the moment
> in OSS application .
> i tried to use SNDCTL_DSP_SETFRAGMENT ioctl to set lower fragment size .

In theory, this should work.

> but audio driver uses default fragment size only and not the fragment
> size desired by application .

Does it return an error?  If yes, try moving this call before some
other parameter setting ioctls.


Regards,
Clemens
