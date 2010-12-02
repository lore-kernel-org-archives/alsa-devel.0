From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hardware events
Date: Thu, 02 Dec 2010 08:51:18 +0100
Message-ID: <4CF74FF6.9080009@ladisch.de>
References: <4CF39483.4050704@gmail.com> <4CF4B112.3070705@ladisch.de>
	<4CF4E48B.3030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 237C1103804
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 08:49:25 +0100 (CET)
In-Reply-To: <4CF4E48B.3030600@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rolf Theunissen <rolf.theunissen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rolf Theunissen wrote:
> Clemens Ladisch wrote:
>> The control notifications are for all changes of the control.
>>
>> If it is not possible to change the volume in software, then the driver
>> must not set the control to be writable.
> 
> The issue is not that the driver should be writable or not. Even, if the
> volume is read only, an OSD can be shown for any event. However when the
> volume can be set both in hardware and in software, the end-user will
> expect different behavior.

The control notifications are for all changes of the control.

If you want to treat hardware-originated changes differently, you have
to send an additional, different notification for the OSD tool.

Usually, such volume change buttons are just treated as input devices,
and software is then expected to change the actual mixer control, but
this doesn't work if the hardware affects the control directly.


Regards,
Clemens
