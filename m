From: alexander <axeldenstore@gmail.com>
Subject: cannot submit syncpipe, usb2 audio
Date: Wed, 04 Jan 2012 23:50:28 +0200
Message-ID: <4F04C9A4.9020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 32EF810389C
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 22:57:14 +0100 (CET)
Received: by lago2 with SMTP id o2so6431737lag.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Jan 2012 13:57:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

|I asked in alsa-users about the state of usb2 audio class compliance some time ago but I never got a definitive answer.. I've done some digging on my own and found someone had a similar issue with the same error about a year ago.

This is what dmesg says when I connect the device in usb2 mode, the last row is the error when I try to use it.

[ 2384.749399] usb 1-2: USB disconnect, device number 2
[ 2390.729825] usb 1-2: new high speed USB device number 3 using ehci_hcd
[ 2390.863654] generic-usb 0003:0926:0202.0003: hiddev0,hidraw0: USB HID v1.01 Device [Sound Devices USBPre2] on usb-0000:00:02.1-2/input3
[ 2418.388135] cannot submit syncpipe for urb 0, error -90: internal error

Here are the lsusb -v as usb1.1 http://pastebin.com/Jj6mXHxJ and here as usb2 http://pastebin.com/8uCBAkNb

I've looked at them and the only thing that differs is the|bInterval, wich is 1 in usb1.1 and 4 in usb2
