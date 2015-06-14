From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/11] ALSA: bebob: add support for Behringer
	FCA 610/1616
Date: Sun, 14 Jun 2015 12:49:37 +0900
Message-ID: <1434253777-433-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DE87260502
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:46 +0200 (CEST)
In-Reply-To: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

They're based on DM1500 (ArchWave produced), and BeBoB version 3 is
installed.

$ cat /proc/asound/FCA610/firewire/firmware
Manufacturer:	bridgeCo
Protocol Ver:	3
Build Ver:		0
GUID:		0x001564000002AD73
Model ID:		0x03
Model Rev:		0
Firmware Date:	20121102
Firmware Time:	153431
Firmware ID:	0x610
Firmware Ver:	8348
Base Addr:		0x400C0080
Max Size:		1422624
Loader Date:	20121015
Loader Time:	104710

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig       | 1 +
 sound/firewire/bebob/bebob.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 2a0a9aa..8850b7d 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -95,6 +95,7 @@ config SND_BEBOB
 	  * Tascam IF-FW/DM
 	  * Behringer XENIX UFX 1204/1604
 	  * Behringer Digital Mixer X32 series (X-UF Card)
+	  * Behringer FCA610/1616
 	  * Apogee Rosetta 200/400 (X-FireWire card)
 	  * Apogee DA/AD/DD-16X (X-FireWire card)
 	  * Apogee Ensemble
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 920571b..27a04ac 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -373,6 +373,10 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00001604, &spec_normal),
 	/* Behringer, Digital Mixer X32 series (X-UF Card) */
 	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00000006, &spec_normal),
+	/*  Behringer, F-Control Audio 1616 */
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x001616, &spec_normal),
+	/*  Behringer, F-Control Audio 610 */
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x000610, &spec_normal),
 	/* Apogee Electronics, Rosetta 200/400 (X-FireWire card) */
 	/* Apogee Electronics, DA/AD/DD-16X (X-FireWire card) */
 	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048, &spec_normal),
@@ -447,8 +451,6 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* IDs are unknown but able to be supported */
 	/*  Apogee, Mini-ME Firewire */
 	/*  Apogee, Mini-DAC Firewire */
-	/*  Behringer, F-Control Audio 1616 */
-	/*  Behringer, F-Control Audio 610 */
 	/*  Cakawalk, Sonar Power Studio 66 */
 	/*  CME, UF400e */
 	/*  ESI, Quotafire XL */
-- 
2.1.4
