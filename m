From: Giuliano Pochini <pochini@shiny.it>
Subject: What can change after suspend ?
Date: Wed, 28 Oct 2009 00:17:50 +0100
Message-ID: <20091028001750.62f12ef1@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C6B42443F
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 00:18:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm adding suspend/resume support to echoaudio drivers. I was
reading /Documentation/power/pci.txt:

"
        pci_set_power_state(PCI_D0);
        pci_restore_state();
        /* device's irq possibly is changed, driver should take care */
"

The card does not support D[0-3] states. The driver suspends the card by
turning the DSP off, without changing the PCI state. Can IRQ, memory mapped
regions, whatever, change on resume ?
Are pci_save_state() and pci_enable_wake() useful/required in this case ?


-- 
Giuliano.
