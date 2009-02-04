From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 0/3] Add AVR32 ALSA drivers
Date: Wed,  4 Feb 2009 12:48:31 +0100
Message-ID: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CB192433F
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 12:48:37 +0100 (CET)
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
Cc: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>

This series adds support for the ABDAC and AC97C peripherals on AVR32 devices.

They also need the DW DMAC cyclic DMA API patch to work[1]. The patch set is
made against kernel v2.6.29-rc3. A review would be greatly appreciated,
checkpatch.pl gives no warnings and usage works as expected on hardware.

Adding these drivers to the queue for the upstream kernel should wait until the
cyclic DMA API for the DW DMAC driver is also in the queue for upstream.

1: http://avr32linux.org/archives/kernel/2009-February/002088.html
   http://avr32linux.org/archives/kernel/2009-February/002087.html

-- 
Best regards,
Hans-Christian Egtvedt
