From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: regarding setting of fragment size in usbaudio
	driver
Date: Mon, 13 Dec 2010 10:04:29 +0100
Message-ID: <4D05E19D.7010405@ladisch.de>
References: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 44D1210381A
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 10:01:42 +0100 (CET)
In-Reply-To: <AANLkTimCg0kxCU1By9eg0Qba5hKMseS5rAZXsE_a4hOF@mail.gmail.com>
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
> i am using a OSS based usbaudio application for usb audio streaming .
> 
> my usb audio device is capture only device .
> 
> i want to set the fragment size of usbaudio alsa driver to reduce
> latency problem coming in my application .
> 
> currently even if my application reads 4k data from userspace , i
> observed driver will buffer for 100 ms data ( period size data )= 16 k
> at 44100 frquency
> 
> and after driver  reads 16k data , read call will return with 4k data
> .  so read() call remains blocked for 100ms which is causing some
> latency problem .

There is no extra buffer in the driver.
There seems to be something wrong with your algorithm.

Does recording with the arecord tool work?


Regards,
Clemens
