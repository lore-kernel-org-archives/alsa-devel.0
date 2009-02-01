From: Dmitry Baikov <dsbaikov@gmail.com>
Subject: RME HDSP rev 37 does not work on 64-bit linux
Date: Sun, 1 Feb 2009 18:13:14 +0300
Message-ID: <70a871c80902010713p2b49c7cbj98356d56bdb4ed62@mail.gmail.com>
References: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f19.google.com (mail-fx0-f19.google.com
	[209.85.220.19]) by alsa0.perex.cz (Postfix) with ESMTP id 69FBA24445
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 16:13:15 +0100 (CET)
Received: by fxm12 with SMTP id 12so1003630fxm.8
	for <alsa-devel@alsa-project.org>; Sun, 01 Feb 2009 07:13:15 -0800 (PST)
In-Reply-To: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>
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

Hello,

recently I upgraded firmware for my RME HDSP (Cardbus + Multiface II)
to recent version,
to be able to use it under WinXP 64, since there's no 64-bit windows
driver for old hdsp firmware.
And the results under linux are surprising:
My main OS is Ubuntu 8.10 64-bit, and there hdspmixer fails with the message:

Card 1 : RME Hammerfall DSP at 0x130000000, irq 18
Uninitialized HDSP card found.
Use hdsploader to upload configuration data to the card.
No Hammerfall DSP card found.

Trying to run hdsploader gives:

Card 1 : RME Hammerfall DSP at 0x130000000, irq 18
Upload firmware for card hw:1
Hwdep ioctl error on card hw:1 : Input/output error.

dmesg:
Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations

This happens even if I boot into winxp first to initialize multiface,
then reboot into linux and do not run hdsploader.

BUT:
under 32-bit ubuntu 8.10 with the same kernel 2.6.27-11-generic and
the same version of alsa-*: 1.0.17-0ubuntu1,
everything works fine both with cold boot + hdsploader and winxp ->
reboot-> no hdsploader.

Regards,
Dmitry.
