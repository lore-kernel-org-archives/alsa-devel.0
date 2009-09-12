From: Giuliano Pochini <pochini@shiny.it>
Subject: Can't resume from suspend because firmware is not
	found ?!?
Date: Sat, 12 Sep 2009 22:38:00 +0200
Message-ID: <20090912223800.5170f488@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 815FC247D9
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 22:38:14 +0200 (CEST)
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

I tested suspend/resume on a laptop because I failed to make it work on my
G4 (grr!!). Suspend work, resume does not. From dmesg (below) it looks like
the soundcard driver is asked to resume before the ATA driver, thus is
cannot load the firmware. Am I overlooking something ?  Suggestions ?

----
Echoaudio Indigo IOx 0000:07:00.0: resume
Echoaudio Indigo IOx 0000:07:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Echoaudio Indigo IOx 0000:07:00.0: enabling bus mastering
ALSA echoaudio.c:2177: res res1
Echoaudio Indigo IOx 0000:07:00.0: firmware: requesting ea/indigo_iox_dsp.fw
PM: Adding info for No Bus:0000:07:00.0
ata4.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
ata4.00: ACPI cmd ef/03:42:00:00:00:a0 filtered out
ata4.00: configured for UDMA/33
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: _GTF unexpected object type 0x1
ata1.00: _GTF unexpected object type 0x1
ata1.00: configured for UDMA/100
tg3: eth0: Link is up at 10 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
PM: Removing info for No Bus:0000:07:00.0
ALSA echoaudio.c:47: get_firmware(): Firmware not available (-2)
pm_op(): pci_pm_resume+0x0/0x79 returns -2
PM: Device 0000:07:00.0 failed to resume: error -2
----


-- 
Giuliano.
