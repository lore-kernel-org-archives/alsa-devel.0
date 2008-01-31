From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: Intel ICH Modem init fails for laptop built-in SiS
	modem
Date: Thu, 31 Jan 2008 16:45:31 +0000
Message-ID: <1201797931.2968.16.camel@castor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id B5DDE24367
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 17:45:36 +0100 (CET)
Received: from rsk.demon.co.uk ([80.176.90.227] helo=[192.168.0.6])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.67)
	id 1JKcXg-000AHe-AG
	for alsa-devel@alsa-project.org; Thu, 31 Jan 2008 16:45:36 +0000
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

My JVC mininote laptop has an inbuilt SiS modem

00:01.6 Modem [0703]: Silicon Integrated Systems [SiS] AC'97 Modem Controller [1039:7013] (rev a0)

which is detected by the snd-intel8x0m driver but it always fails to
initialise and spams the log file :- 

kernel: codec_semaphore: semaphore is not ready [0x1][0x1300]
kernel:last message repeated 2 times
kernel: codec_semaphore: semaphore is not ready [0x1][0x300]
kernel:last message repeated 431 times
kernel: AC'97 1 does not respond - RESET
kernel: codec_semaphore: semaphore is not ready [0x1][0x300]
kernel: codec_semaphore: semaphore is not ready [0x1][0x300]
kernel: AC'97 1 access is not valid [0xffffffff], removing mixer.
kernel: Unable to initialize codec #1
kernel: ACPI: PCI interrupt for device 0000:00:01.6 disabled
kernel: Intel ICH Modem: probe of 0000:00:01.6 failed with error -5

I never use the modem so I blacklisted the snd-intel8x0m module in
modprobe.conf just to make the messages go away.

I'm currently running the fedora 2.6.23 kernel but it has been broken
for a long time.

Is this fixable?
or shall I just go on ignoring it ;) ?
cheers
Richard
