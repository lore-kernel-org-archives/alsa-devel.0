From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: regarding setting of fragment size in usbaudio
	driver
Date: Mon, 13 Dec 2010 14:38:24 +0100
Message-ID: <4D0621D0.1040403@ladisch.de>
References: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>	<4D05E19D.7010405@ladisch.de>
	<AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 83A0D245E2
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 14:35:38 +0100 (CET)
In-Reply-To: <AANLkTi=S732=Wj572Th860PpBYE0fkJ97JH2CwitZ4ah@mail.gmail.com>
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

(please don't top-post)

Amit Nagal wrote:
> i used SNDCTL_DSP_GETBLKSIZE ioctl to find the fragment size of driver
> . i found it to be 16k .
> 
> 1) now if the application reads 4k data from userspace , read call
> will remain blocked for audio driver's fragment size usb data read (
> 16k)
>  or app_request_size(4k) ?

If, when read() is called, there is enough data in the buffer, it will
return that data and return immediately.  Otherwise, it will wait for
the hardware to reach the next period boundary (in OSS: fragment
boundary) and try again.

If you want to have shorter waits, use lower fragment sizes.


Regards,
Clemens
