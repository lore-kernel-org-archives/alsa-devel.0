From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH v2] ALSA: hda - show ICT/KAE control bits
Date: Mon, 13 Aug 2012 15:43:49 +0800
Message-ID: <1344843829-23236-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E63226528C
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 09:26:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Enable two debug options for S/PDIF Converter Control.
KAE: Keep Alive Enable; ICT: IEC Coding Type.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_codec.h |    4 ++++
 sound/pci/hda/hda_proc.c  |    9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index c422d33..afd2af0 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -386,6 +386,10 @@ enum {
 /* DIGITAL2 bits */
 #define AC_DIG2_CC			(0x7f<<0)
 
+/* DIGITAL3 bits */
+#define AC_DIG3_ICT			(0xf<<0)
+#define AC_DIG3_KAE			(1<<7)
+
 /* Pin widget control - 8bit */
 #define AC_PINCTL_EPT			(0x3<<0)
 #define AC_PINCTL_EPT_NATIVE		0
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 7e46258..32bb3d9 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -402,6 +402,9 @@ static void print_digital_conv(struct snd_info_buffer *buffer,
 {
 	unsigned int digi1 = snd_hda_codec_read(codec, nid, 0,
 						AC_VERB_GET_DIGI_CONVERT_1, 0);
+	unsigned char digi2 = digi1 >> 8;
+	unsigned char digi3 = digi1 >> 16;
+
 	snd_iprintf(buffer, "  Digital:");
 	if (digi1 & AC_DIG1_ENABLE)
 		snd_iprintf(buffer, " Enabled");
@@ -419,9 +422,13 @@ static void print_digital_conv(struct snd_info_buffer *buffer,
 		snd_iprintf(buffer, " Pro");
 	if (digi1 & AC_DIG1_LEVEL)
 		snd_iprintf(buffer, " GenLevel");
+	if (digi3 & AC_DIG3_KAE)
+		snd_iprintf(buffer, " KAE");
 	snd_iprintf(buffer, "\n");
 	snd_iprintf(buffer, "  Digital category: 0x%x\n",
-		    (digi1 >> 8) & AC_DIG2_CC);
+		    digi2 & AC_DIG2_CC);
+	snd_iprintf(buffer, "  IEC Coding Type: 0x%x\n",
+			digi3 & AC_DIG3_ICT);
 }
 
 static const char *get_pwr_state(u32 state)
-- 
1.7.9.5
