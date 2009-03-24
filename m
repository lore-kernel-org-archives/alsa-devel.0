From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 1/7] snd-atmel-ac97c: cleanup register
	definitions
Date: Tue, 24 Mar 2009 13:47:44 +0100
Message-ID: <1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3415E103835
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:52 +0100 (CET)
In-Reply-To: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch will remove traces of channel B registers, since they are not
used by the AC97C driver. Channel B might be used for other purposes.

The driver also adds channel status bits TXEMPTY and OVRUN and a
AC97C_CH_MASK macro to ease clearing a channel settings.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.h |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/atmel/ac97c.h b/sound/atmel/ac97c.h
index c17bd58..ecbba50 100644
--- a/sound/atmel/ac97c.h
+++ b/sound/atmel/ac97c.h
@@ -1,5 +1,5 @@
 /*
- * Register definitions for the Atmel AC97C controller
+ * Register definitions for Atmel AC97C
  *
  * Copyright (C) 2005-2009 Atmel Corporation
  *
@@ -17,10 +17,6 @@
 #define AC97C_CATHR		0x24
 #define AC97C_CASR		0x28
 #define AC97C_CAMR		0x2c
-#define AC97C_CBRHR		0x30
-#define AC97C_CBTHR		0x34
-#define AC97C_CBSR		0x38
-#define AC97C_CBMR		0x3c
 #define AC97C_CORHR		0x40
 #define AC97C_COTHR		0x44
 #define AC97C_COSR		0x48
@@ -46,8 +42,10 @@
 #define AC97C_MR_VRA		(1 << 2)
 
 #define AC97C_CSR_TXRDY		(1 << 0)
+#define AC97C_CSR_TXEMPTY	(1 << 1)
 #define AC97C_CSR_UNRUN		(1 << 2)
 #define AC97C_CSR_RXRDY		(1 << 4)
+#define AC97C_CSR_OVRUN		(1 << 5)
 #define AC97C_CSR_ENDTX		(1 << 10)
 #define AC97C_CSR_ENDRX		(1 << 14)
 
@@ -61,11 +59,15 @@
 #define AC97C_CMR_DMAEN		(1 << 22)
 
 #define AC97C_SR_CAEVT		(1 << 3)
+#define AC97C_SR_COEVT		(1 << 2)
+#define AC97C_SR_WKUP		(1 << 1)
+#define AC97C_SR_SOF		(1 << 0)
 
+#define AC97C_CH_MASK(slot)						\
+	(0x7 << (3 * (AC97_SLOT_##slot - 3)))
 #define AC97C_CH_ASSIGN(slot, channel)					\
 	(AC97C_CHANNEL_##channel << (3 * (AC97_SLOT_##slot - 3)))
 #define AC97C_CHANNEL_NONE	0x0
 #define AC97C_CHANNEL_A		0x1
-#define AC97C_CHANNEL_B		0x2
 
 #endif /* __SOUND_ATMEL_AC97C_H */
-- 
1.5.6.3
