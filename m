From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] ALSA: dice: improve support for ancient
	firmware for DICE
Date: Tue, 24 Apr 2018 22:24:32 +0900
Message-ID: <20180424132432.3189-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7169526722C
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:25:05 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id i29so9367022pgn.12
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 06:25:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In early stage of firmware SDK, DICE seems to lose its backward
compatibility due to some registers on global address section. I found
this with Alesis Multimix 12 FireWire with ancient firmware (approx.
shipped version).

According to retrieved log from the unit, global section has 96 byte
space. On the other hand, current version of ALSA dice driver assumes
that all of supported unit has at least 100 byte space.

$ ./firewire-request /dev/fw1 read 0xffffe0000000 28
result: 000: 00 00 00 0a 00 00 00 18 00 00 00 22 00 00 00 8a
result: 010: 00 00 00 ac 00 00 01 12 00 00 00 00 00 00 00 00
result: 020: 00 00 00 00 00 00 00 00

This commit adds support for the ancient firmware. Check of global section
is loosened to accept the smaller space. The lack of information is
already compensated by hard-coded parameters.

I experienced that the latest version of Windows driver for this model
can't handle this unit, too. This means that TCAT releases firmware SDK
without backward compatibility for the ancient firmware.

Below list is a early history of driver/firmware package released by
Alesis. I investigated on wayback machine on Internet Archive:
 * Unknown: PAL v1.0.41.2, firmware v1.0.3
 * Mar 2006: PAL v1.54.0, firmware v1.0.4
 * Dec 2006: PAL v2.0.0.2, firmware v2.0
 * Jun 2007: PAL v3.0.41.5, firmware v2.0
 * Jul 2007: PAL v3.0.56.2. firmware v2.0
 * Jan 2008: PAL v3.0.81.1080, firmware v2.0

If I can assume that firmware version is the same as DICE version, DICE
version for the issued firmware may be v1.0.3. According to code base of
userspace driver project (FFADO), I can read DICE v1.0.4 supports global
space larger than 100 byte. I guess the smaller space of global section is
a feature of DICE v1.0.3.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-interface.h   |  9 +++++--
 sound/firewire/dice/dice-proc.c        | 10 +++----
 sound/firewire/dice/dice-transaction.c | 49 +++++++++++++++++++---------------
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/sound/firewire/dice/dice-interface.h b/sound/firewire/dice/dice-interface.h
index 15a484b05298..9cad3d608229 100644
--- a/sound/firewire/dice/dice-interface.h
+++ b/sound/firewire/dice/dice-interface.h
@@ -174,14 +174,19 @@
  */
 #define GLOBAL_SAMPLE_RATE		0x05c
 
+/*
+ * Some old firmware versions do not have the following global registers.
+ * Windows drivers produced by TCAT lost backward compatibility in its
+ * early release because they can handle firmware only which supports the
+ * following registers.
+ */
+
 /*
  * The version of the DICE driver specification that this device conforms to;
  * read-only.
  */
 #define GLOBAL_VERSION			0x060
 
-/* Some old firmware versions do not have the following global registers: */
-
 /*
  * Supported sample rates and clock sources; read-only.
  */
diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
index f5c1d1bced59..cc079323ed30 100644
--- a/sound/firewire/dice/dice-proc.c
+++ b/sound/firewire/dice/dice-proc.c
@@ -148,12 +148,12 @@ static void dice_proc_read(struct snd_info_entry *entry,
 				   >> CLOCK_RATE_SHIFT));
 	snd_iprintf(buffer, "  ext status: %08x\n", buf.global.extended_status);
 	snd_iprintf(buffer, "  sample rate: %u\n", buf.global.sample_rate);
-	snd_iprintf(buffer, "  version: %u.%u.%u.%u\n",
-		    (buf.global.version >> 24) & 0xff,
-		    (buf.global.version >> 16) & 0xff,
-		    (buf.global.version >>  8) & 0xff,
-		    (buf.global.version >>  0) & 0xff);
 	if (quadlets >= 90) {
+		snd_iprintf(buffer, "  version: %u.%u.%u.%u\n",
+			    (buf.global.version >> 24) & 0xff,
+			    (buf.global.version >> 16) & 0xff,
+			    (buf.global.version >>  8) & 0xff,
+			    (buf.global.version >>  0) & 0xff);
 		snd_iprintf(buffer, "  clock caps:");
 		for (i = 0; i <= 6; ++i)
 			if (buf.global.clock_caps & (1 << i))
diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index 0f0350320ae8..b7e138b5abcf 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -265,7 +265,7 @@ int snd_dice_transaction_reinit(struct snd_dice *dice)
 static int get_subaddrs(struct snd_dice *dice)
 {
 	static const int min_values[10] = {
-		10, 0x64 / 4,
+		10, 0x60 / 4,
 		10, 0x18 / 4,
 		10, 0x18 / 4,
 		0, 0,
@@ -301,33 +301,40 @@ static int get_subaddrs(struct snd_dice *dice)
 		}
 	}
 
-	/*
-	 * Check that the implemented DICE driver specification major version
-	 * number matches.
-	 */
-	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
-				 DICE_PRIVATE_SPACE +
-				 be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
-				 &version, sizeof(version), 0);
-	if (err < 0)
-		goto end;
+	if (be32_to_cpu(pointers[1]) > 0x18) {
+		/*
+		 * Check that the implemented DICE driver specification major
+		 * version number matches.
+		 */
+		err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
+				DICE_PRIVATE_SPACE +
+				be32_to_cpu(pointers[0]) * 4 + GLOBAL_VERSION,
+				&version, sizeof(version), 0);
+		if (err < 0)
+			goto end;
 
-	if ((version & cpu_to_be32(0xff000000)) != cpu_to_be32(0x01000000)) {
-		dev_err(&dice->unit->device,
-			"unknown DICE version: 0x%08x\n", be32_to_cpu(version));
-		err = -ENODEV;
-		goto end;
+		if ((version & cpu_to_be32(0xff000000)) !=
+						cpu_to_be32(0x01000000)) {
+			dev_err(&dice->unit->device,
+				"unknown DICE version: 0x%08x\n",
+				be32_to_cpu(version));
+			err = -ENODEV;
+			goto end;
+		}
+
+		/* Set up later. */
+		dice->clock_caps = 1;
 	}
 
 	dice->global_offset = be32_to_cpu(pointers[0]) * 4;
 	dice->tx_offset = be32_to_cpu(pointers[2]) * 4;
 	dice->rx_offset = be32_to_cpu(pointers[4]) * 4;
-	dice->sync_offset = be32_to_cpu(pointers[6]) * 4;
-	dice->rsrv_offset = be32_to_cpu(pointers[8]) * 4;
 
-	/* Set up later. */
-	if (be32_to_cpu(pointers[1]) * 4 >= GLOBAL_CLOCK_CAPABILITIES + 4)
-		dice->clock_caps = 1;
+	/* Old firmware doesn't support these fields. */
+	if (pointers[7])
+		dice->sync_offset = be32_to_cpu(pointers[6]) * 4;
+	if (pointers[9])
+		dice->rsrv_offset = be32_to_cpu(pointers[8]) * 4;
 end:
 	kfree(pointers);
 	return err;
-- 
2.14.1
