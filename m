From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] HDA-Intel: Fix wrong CTLINDEX entries for HBR
	Passthrough
Date: Thu,  6 Sep 2012 10:33:20 +0800
Message-ID: <1346898800-13951-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 064FC26520D
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 04:41:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, anssi.hannula@iki.fi, alanwww1@xbmc.org, fengguang.wu@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

>From Anssi Hannula:
"The CTLINDEX=x values in /usr/share/alsa/cards/HDA-Intel.conf are off
when you have S/PDIF output in the same card as HDMI, which is often the case
on Intel.

The workaround is to bump all the CTLINDEX=x values one step up in the
HDA-Intel.pcm.hdmi.foo entries, i.e.
CTLINDEX=0 => CTLINDEX=1
CTLINDEX=1 => CTLINDEX=2
etc, in the /usr/share/alsa/cards/HDA-Intel.conf."

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 src/conf/cards/HDA-Intel.conf |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index d4f2667..7d6de8f 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -211,7 +211,7 @@ HDA-Intel.pcm.hdmi.0 {
 			"cards.HDA-Intel.pcm.hdmi.common:"
 			"CARD=" $CARD ","
 			"DEVICE=3,"
-			"CTLINDEX=0,"
+			"CTLINDEX=1,"
 			"AES0=" $AES0 ","
 			"AES1=" $AES1 ","
 			"AES2=" $AES2 ","
@@ -234,7 +234,7 @@ HDA-Intel.pcm.hdmi.1 {
 			"cards.HDA-Intel.pcm.hdmi.common:"
 			"CARD=" $CARD ","
 			"DEVICE=7,"
-			"CTLINDEX=1,"
+			"CTLINDEX=2,"
 			"AES0=" $AES0 ","
 			"AES1=" $AES1 ","
 			"AES2=" $AES2 ","
@@ -257,7 +257,7 @@ HDA-Intel.pcm.hdmi.2 {
 			"cards.HDA-Intel.pcm.hdmi.common:"
 			"CARD=" $CARD ","
 			"DEVICE=8,"
-			"CTLINDEX=2,"
+			"CTLINDEX=3,"
 			"AES0=" $AES0 ","
 			"AES1=" $AES1 ","
 			"AES2=" $AES2 ","
@@ -280,7 +280,7 @@ HDA-Intel.pcm.hdmi.3 {
 			"cards.HDA-Intel.pcm.hdmi.common:"
 			"CARD=" $CARD ","
 			"DEVICE=9,"
-			"CTLINDEX=3,"
+			"CTLINDEX=4,"
 			"AES0=" $AES0 ","
 			"AES1=" $AES1 ","
 			"AES2=" $AES2 ","
-- 
1.7.9.5
