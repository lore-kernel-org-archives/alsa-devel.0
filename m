From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: how to quirk max capture level?
Date: Tue, 21 Jul 2009 17:19:00 +0200
Message-ID: <4A65DC64.80101@fisher-privat.net>
References: <4A658FB8.9070005@fisher-privat.net> <4A65BA05.5050604@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id BDA692438D
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 17:19:00 +0200 (CEST)
In-Reply-To: <4A65BA05.5050604@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch schrieb:
> Alexey Fisher wrote:
>> i have Logitech QuickCam E3500 ... with little issue.
>> Setting capture volume to more then 94% will mute this device... no 
>> capture will be possible. This device has same issue with windows vista. 
>> So best way to handle it, is usbquirks.h , but i do not know any way to 
>> set max level.
> 
> There is no predefined quirk for this; we need to code a workaround in
> usbmixer.c.
> 
> Please show the output of "lsusb -v" for this device.
> 
> 
> Best regards,
> Clemens

Thank you,
i did some patch to work it around but found some other issues..
i will take closer look to it... all of my usb-sound work different on 
different usb-ports, but all other usb gadgets work with no difference 
on all ports.
one more question: should i get any sound on cval->min? seems like every 
manufacture think different about it.

Best regards,
Alexey
