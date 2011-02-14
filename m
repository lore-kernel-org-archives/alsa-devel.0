From: "Nenad Sljivic" <nenad.sljivic@rt-rk.com>
Subject: plughw, access modes
Date: Mon, 14 Feb 2011 03:04:27 -0800
Message-ID: <8C2D93A7301A488588BD4A2CAD8C6F4D@domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rt-rk.com (mail.rt-rk.ftn.uns.ac.rs [147.91.177.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A60421037F3
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 12:04:44 +0100 (CET)
Received: from localhost (mail.localdomain [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 2AD0125C031
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 12:04:41 +0100 (CET)
Received: from mail.rt-rk.com ([127.0.0.1])
	by localhost (mail.rt-rk.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id i-IruY2H8isw for <alsa-devel@alsa-project.org>;
	Mon, 14 Feb 2011 12:04:41 +0100 (CET)
Received: from ne6414 (c-98-210-180-191.hsd1.ca.comcast.net [98.210.180.191])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.rt-rk.com (Postfix) with ESMTP id B9E9925C02E
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 12:04:32 +0100 (CET)
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

Greetings guys,

 

I am dealing with the device driver for the chip that has his own hardware
buffer and the DMA is not available. Therefore, driver doesn't support MMAP
access and the data is copied using the copy file operation. My HW natively
supports BE format. 

However, I would like to be able to play little endian pcm as well. 

The problem, occurs when I try to use plughw device in order to play LE pcm
file

 

" aplay: set_params:1022: Unable to install hw params: "

 

My debugging session proved me that plughw device is trying to access device
driver with MMAP_INTERLEAVED mode. Does it mean that this is the only way
for plughw to access device driver, and that I am not able to use plugins
unless do some heavy modifications of device drivers (implement mmap
access). Am I missing something?

Any info on this would be most welcome.

 

Thanks,

Nenad
