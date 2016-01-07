From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/6] [ALSA] portman2x4 - remove space
Date: Thu,  7 Jan 2016 12:45:48 +0530
Message-ID: <1452150951-1571-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

checkpatch complains about space before tab.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/portman2x4.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 4f9717b..65b0650 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -123,21 +123,21 @@ static int portman_create(struct snd_card *card,
  *********************************************************************/
 
 /* Standard PC parallel port status register equates. */
-#define	PP_STAT_BSY   	0x80	/* Busy status.  Inverted. */
-#define	PP_STAT_ACK   	0x40	/* Acknowledge.  Non-Inverted. */
-#define	PP_STAT_POUT  	0x20	/* Paper Out.    Non-Inverted. */
-#define	PP_STAT_SEL   	0x10	/* Select.       Non-Inverted. */
-#define	PP_STAT_ERR   	0x08	/* Error.        Non-Inverted. */
+#define	PP_STAT_BSY	0x80	/* Busy status.  Inverted. */
+#define	PP_STAT_ACK	0x40	/* Acknowledge.  Non-Inverted. */
+#define	PP_STAT_POUT	0x20	/* Paper Out.    Non-Inverted. */
+#define	PP_STAT_SEL	0x10	/* Select.       Non-Inverted. */
+#define	PP_STAT_ERR	0x08	/* Error.        Non-Inverted. */
 
 /* Standard PC parallel port command register equates. */
-#define	PP_CMD_IEN  	0x10	/* IRQ Enable.   Non-Inverted. */
-#define	PP_CMD_SELI 	0x08	/* Select Input. Inverted. */
-#define	PP_CMD_INIT 	0x04	/* Init Printer. Non-Inverted. */
-#define	PP_CMD_FEED 	0x02	/* Auto Feed.    Inverted. */
+#define	PP_CMD_IEN	0x10	/* IRQ Enable.   Non-Inverted. */
+#define	PP_CMD_SELI	0x08	/* Select Input. Inverted. */
+#define	PP_CMD_INIT	0x04	/* Init Printer. Non-Inverted. */
+#define	PP_CMD_FEED	0x02	/* Auto Feed.    Inverted. */
 #define	PP_CMD_STB      0x01	/* Strobe.       Inverted. */
 
 /* Parallel Port Command Register as implemented by PCP2x4. */
-#define	INT_EN	 	PP_CMD_IEN	/* Interrupt enable. */
+#define	INT_EN		PP_CMD_IEN	/* Interrupt enable. */
 #define	STROBE	        PP_CMD_STB	/* Command strobe. */
 
 /* The parallel port command register field (b1..b3) selects the
@@ -148,7 +148,7 @@ static int portman_create(struct snd_card *card,
 #define	RXDATA0		(0 << 1)	/* PCP RxData channel 0. */
 #define	RXDATA1		(1 << 1)	/* PCP RxData channel 1. */
 #define	GEN_CTL		(2 << 1)	/* PCP General Control Register. */
-#define	SYNC_CTL 	(3 << 1)	/* PCP Sync Control Register. */
+#define	SYNC_CTL	(3 << 1)	/* PCP Sync Control Register. */
 #define	TXDATA0		(4 << 1)	/* PCP TxData channel 0. */
 #define	TXDATA1		(5 << 1)	/* PCP TxData channel 1. */
 #define	TXDATA2		(6 << 1)	/* PCP TxData channel 2. */
-- 
1.9.1
