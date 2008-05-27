From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bandwidth issue with usb-audio in alsa
Date: Tue, 27 May 2008 17:34:05 +0200
Message-ID: <483C29ED.6060504@ladisch.de>
References: <483C0847.1080405@singhkunal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BD38F24424
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 17:34:10 +0200 (CEST)
In-Reply-To: <483C0847.1080405@singhkunal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kunal Singh <kunal@singhkunal.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kunal Singh wrote:
> 	I have some update on the issue which I had reported earlier. In my last e-mail, I had not mentioned that iPod is connected to the target through a USB (HS) Hub. When I connect the
> same hub to my Desktop and read its configuration using "usbview" - I see that "interval" for this hub is mentioned
> as "256 msec". (I have two hubs and I get all the results same with both the hubs).

Please show the output of "lsusb -v".


Regards,
Clemens
