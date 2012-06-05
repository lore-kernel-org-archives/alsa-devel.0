From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] ALSA: hda - add power states information in
	proc
Date: Tue,  5 Jun 2012 18:08:10 +0800
Message-ID: <1338890890-25147-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 28E2A10429A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:12:32 +0200 (CEST)
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
Cc: tiwai@suse.de, swarren@nvidia.com, wangxingchao2011@gmail.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

add more power states information:
- reset status
- clock stop ok
- power states error

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_codec.h |    3 +++
 sound/pci/hda/hda_proc.c  |    6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 4fc3960..71864cdd 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -323,6 +323,9 @@ enum {
 #define AC_PWRST_D1			0x01
 #define AC_PWRST_D2			0x02
 #define AC_PWRST_D3			0x03
+#define AC_PWRST_ERROR                  (1<<8)
+#define AC_PWRST_CLK_STOP_OK            (1<<9)
+#define AC_PWRST_SETTING_RESET          (1<<10)
 
 /* Processing capabilies */
 #define AC_PCAP_BENIGN			(1<<0)
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index e59e2f0..5511de1 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -459,6 +459,12 @@ static void print_power_state(struct snd_info_buffer *buffer,
 		    get_pwr_state(pwr & AC_PWRST_SETTING),
 		    get_pwr_state((pwr & AC_PWRST_ACTUAL) >>
 				  AC_PWRST_ACTUAL_SHIFT));
+	if (pwr & AC_PWRST_ERROR)
+		snd_iprintf(buffer, " Power state error\n");
+	if (pwr & AC_PWRST_CLK_STOP_OK)
+		snd_iprintf(buffer, " PS: clock stop ok\n");
+	if (pwr & AC_PWRST_SETTING_RESET)
+		snd_iprintf(buffer, " Power state setting reset\n");
 }
 
 static void print_unsol_cap(struct snd_info_buffer *buffer,
-- 
1.7.9.5
