From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ioctl problem - help please!!
Date: Thu, 04 Feb 2010 10:45:06 +0100
Message-ID: <4B6A9722.3070109@ladisch.de>
References: <60ef6ece1002021334q4eb53641p5308f84847ed3949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 11D3224153
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 10:45:10 +0100 (CET)
In-Reply-To: <60ef6ece1002021334q4eb53641p5308f84847ed3949@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Rene E. Henriquez G." <rene.henriquez@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene E. Henriquez G. wrote:
> Does anybody know what might cause this:
> 
> 2925  open("/dev/snd/pcmC0D0c", O_RDWR|O_NONBLOCK) = 5
> 2925  ioctl(5, 0x80184151, 0x7ffff3351890) = -1 EIO (Input/output error)
> 
> to give EIO?

Some error detected by the driver.  Which driver?
Does normal recording work?


Regards,
Clemens
