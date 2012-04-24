From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [snd-usb-audio] frequent "delay: estimated xxx,
 actual yyy" messages
Date: Tue, 24 Apr 2012 15:59:15 +0200
Message-ID: <4F96B1B3.1060606@ladisch.de>
References: <3172169.OcqrdKakkS@siegfried> <4F9594AF.4090902@linux.intel.com>
	<1383683.z6YHnxXImd@siegfried>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A50E8243B0
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 15:55:24 +0200 (CEST)
In-Reply-To: <1383683.z6YHnxXImd@siegfried>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guillaume Clement <gclement@baobob.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guillaume Clement wrote:
> Could the delay not be the cause, but a side effect ?

Yes, that's probable.  It might be possible that some interrupt got
delayed too much, or that packets were completed in wrong order.

> Do you have any idea why keeping my CPU busy removes the problem ?

I'd guess that an idle CPU needs a longer time to wake up.
What CPU and what CPU frequency governor are you using?


Regards,
Clemens
