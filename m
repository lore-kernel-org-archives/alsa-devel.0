From: fuweix.tang@intel.com
Subject: [PATCH] topology: Added supply widget support
Date: Thu, 13 Apr 2017 14:58:06 +0800
Message-ID: <1492066686-10777-1-git-send-email-fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B3A62669CD
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:58:22 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, "Tewani,
 Pradeep D" <pradeep.d.tewani@intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Tewani, Pradeep D" <pradeep.d.tewani@intel.com>

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
---
 include/sound/asoc.h | 3 ++-
 src/topology/dapm.c  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 082c542..9bef6eb 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -70,7 +70,8 @@
 #define SND_SOC_TPLG_DAPM_DAI_IN	13
 #define SND_SOC_TPLG_DAPM_DAI_OUT	14
 #define SND_SOC_TPLG_DAPM_DAI_LINK	15
-#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_DAI_LINK
+#define SND_SOC_TPLG_DAPM_SUPPLY	16
+#define SND_SOC_TPLG_DAPM_LAST		SND_SOC_TPLG_DAPM_SUPPLY
 
 /* Header magic number and string sizes */
 #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 13aa1c4..b7e244e 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -38,6 +38,7 @@ static const struct map_elem widget_map[] = {
 	{"dai_in", SND_SOC_TPLG_DAPM_DAI_IN},
 	{"dai_out", SND_SOC_TPLG_DAPM_DAI_OUT},
 	{"dai_link", SND_SOC_TPLG_DAPM_DAI_LINK},
+	{"supply", SND_SOC_TPLG_DAPM_SUPPLY},
 };
 
 static int lookup_widget(const char *w)
-- 
2.7.4
