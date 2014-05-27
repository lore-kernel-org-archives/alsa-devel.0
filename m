From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/12] fireworks/bebob: Add suffix for long
	long integer literal
Date: Wed, 28 May 2014 00:14:42 +0900
Message-ID: <1401203687-4189-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B352D26586A
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:15 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds suffix to register values of each device, to supress 'sparse'
warnings. Additionally, this commit changes offset values with integer literal.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.h                     |  4 ++--
 sound/firewire/bebob/bebob_focusrite.c           | 20 ++++++++++----------
 sound/firewire/bebob/bebob_maudio.c              |  4 ++--
 sound/firewire/fireworks/fireworks_transaction.c |  4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 6aef152..d1c93a1 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -35,8 +35,8 @@
 #include "../cmp.h"
 
 /* basic register addresses on DM1000/DM1100/DM1500 */
-#define BEBOB_ADDR_REG_INFO	0xffffc8020000
-#define BEBOB_ADDR_REG_REQ	0xffffc8021000
+#define BEBOB_ADDR_REG_INFO	0xffffc8020000ULL
+#define BEBOB_ADDR_REG_REQ	0xffffc8021000ULL
 
 struct snd_bebob;
 
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
index cd29dbc..e71066d 100644
--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -14,15 +14,15 @@
 #define DIG_OUT	"Digital Out"
 #define STM_IN	"Stream In"
 
-#define SAFFIRE_ADDRESS_BASE			0x000100000000
+#define SAFFIRE_ADDRESS_BASE			0x000100000000ULL
 
-#define SAFFIRE_OFFSET_CLOCK_SOURCE		0x0000000000f8
-#define SAFFIREPRO_OFFSET_CLOCK_SOURCE		0x000000000174
+#define SAFFIRE_OFFSET_CLOCK_SOURCE		0x00f8
+#define SAFFIREPRO_OFFSET_CLOCK_SOURCE		0x0174
 
 /* whether sync to external device or not */
-#define SAFFIRE_OFFSET_CLOCK_SYNC_EXT		0x00000000013c
-#define SAFFIRE_LE_OFFSET_CLOCK_SYNC_EXT	0x000000000432
-#define SAFFIREPRO_OFFSET_CLOCK_SYNC_EXT	0x000000000164
+#define SAFFIRE_OFFSET_CLOCK_SYNC_EXT		0x013c
+#define SAFFIRE_LE_OFFSET_CLOCK_SYNC_EXT	0x0432
+#define SAFFIREPRO_OFFSET_CLOCK_SYNC_EXT	0x0164
 
 #define SAFFIRE_CLOCK_SOURCE_INTERNAL		0
 #define SAFFIRE_CLOCK_SOURCE_SPDIF		1
@@ -35,10 +35,10 @@
 #define SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK	5
 
 /* S/PDIF, ADAT1, ADAT2 is enabled or not. three quadlets */
-#define SAFFIREPRO_ENABLE_DIG_IFACES		0x0000000001a4
+#define SAFFIREPRO_ENABLE_DIG_IFACES		0x01a4
 
 /* saffirepro has its own parameter for sampling frequency */
-#define SAFFIREPRO_RATE_NOREBOOT		0x0000000001cc
+#define SAFFIREPRO_RATE_NOREBOOT		0x01cc
 /* index is the value for this register */
 static const unsigned int rates[] = {
 	[0] = 0,
@@ -51,8 +51,8 @@ static const unsigned int rates[] = {
 };
 
 /* saffire(no label)/saffire LE has metering */
-#define SAFFIRE_OFFSET_METER			0x000000000100
-#define SAFFIRE_LE_OFFSET_METER			0x000000000168
+#define SAFFIRE_OFFSET_METER			0x0100
+#define SAFFIRE_LE_OFFSET_METER			0x0168
 
 static inline int
 saffire_read_block(struct snd_bebob *bebob, u64 offset,
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 52b1a40..6af50eb 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -49,7 +49,7 @@
 /* padding */
 #define MAUDIO_BOOTLOADER_CUE3	0x00000000
 
-#define MAUDIO_SPECIFIC_ADDRESS	0xffc700000000
+#define MAUDIO_SPECIFIC_ADDRESS	0xffc700000000ULL
 
 #define METER_OFFSET		0x00600000
 
@@ -111,7 +111,7 @@ int snd_bebob_maudio_load_firmware(struct fw_unit *unit)
 	 * firmware version 5058 or later has date later than "20070401", but
 	 * 'date' is not null-terminated.
 	 */
-	if (date < 0x3230303730343031) {
+	if (date < 0x3230303730343031LL) {
 		dev_err(&unit->device,
 			"Use firmware version 5058 or later\n");
 		err = -ENOSYS;
diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
index 81a65eb..aa56b8a 100644
--- a/sound/firewire/fireworks/fireworks_transaction.c
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -31,8 +31,8 @@
  */
 #include "./fireworks.h"
 
-#define MEMORY_SPACE_EFW_COMMAND	0xecc000000000
-#define MEMORY_SPACE_EFW_RESPONSE	0xecc080000000
+#define MEMORY_SPACE_EFW_COMMAND	0xecc000000000ULL
+#define MEMORY_SPACE_EFW_RESPONSE	0xecc080000000ULL
 
 #define ERROR_RETRIES 3
 #define ERROR_DELAY_MS 5
-- 
1.8.3.2
