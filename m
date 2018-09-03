From: Keyon Jie <yang.jie@linux.intel.com>
Subject: [PATCH] ALSA: HDA: Fix several mismatch for register
	mask and value
Date: Mon,  3 Sep 2018 10:47:09 +0800
Message-ID: <20180903024709.56749-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 1922C267796
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 04:45:44 +0200 (CEST)
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
Cc: jeeja.kp@intel.com, vkoul@kernel.org, rakesh.a.ughreja@intel.com, pierre-louis.bossart@linux.intel.com, Keyon Jie <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

E.g. for snd_hdac_ext_link_clear_stream_id(), we should set (1 << stream)
as mask, and 0 as value, here correct it and several similar mismatches.

And, here also remove unreadable register_mask usage for those mask value
updating.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 1bd27576db98..a835558ddbc9 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -146,7 +146,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_decouple);
  */
 void snd_hdac_ext_link_stream_start(struct hdac_ext_stream *stream)
 {
-	snd_hdac_updatel(stream->pplc_addr, AZX_REG_PPLCCTL, 0, AZX_PPLCCTL_RUN);
+	snd_hdac_updatel(stream->pplc_addr, AZX_REG_PPLCCTL,
+			 AZX_PPLCCTL_RUN, AZX_PPLCCTL_RUN);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_link_stream_start);
 
@@ -171,7 +172,8 @@ void snd_hdac_ext_link_stream_reset(struct hdac_ext_stream *stream)
 
 	snd_hdac_ext_link_stream_clear(stream);
 
-	snd_hdac_updatel(stream->pplc_addr, AZX_REG_PPLCCTL, 0, AZX_PPLCCTL_STRST);
+	snd_hdac_updatel(stream->pplc_addr, AZX_REG_PPLCCTL,
+			 AZX_PPLCCTL_STRST, AZX_PPLCCTL_STRST);
 	udelay(3);
 	timeout = 50;
 	do {
@@ -242,7 +244,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_link_set_stream_id);
 void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
 				 int stream)
 {
-	snd_hdac_updatew(link->ml_addr, AZX_REG_ML_LOSIDV, 0, (1 << stream));
+	snd_hdac_updatew(link->ml_addr, AZX_REG_ML_LOSIDV, (1 << stream), 0);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_link_clear_stream_id);
 
@@ -415,7 +417,6 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_bus *bus,
 				 bool enable, int index)
 {
 	u32 mask = 0;
-	u32 register_mask = 0;
 
 	if (!bus->spbcap) {
 		dev_err(bus->dev, "Address of SPB capability is NULL\n");
@@ -424,12 +425,8 @@ void snd_hdac_ext_stream_spbcap_enable(struct hdac_bus *bus,
 
 	mask |= (1 << index);
 
-	register_mask = readl(bus->spbcap + AZX_REG_SPB_SPBFCCTL);
-
-	mask |= register_mask;
-
 	if (enable)
-		snd_hdac_updatel(bus->spbcap, AZX_REG_SPB_SPBFCCTL, 0, mask);
+		snd_hdac_updatel(bus->spbcap, AZX_REG_SPB_SPBFCCTL, mask, mask);
 	else
 		snd_hdac_updatel(bus->spbcap, AZX_REG_SPB_SPBFCCTL, mask, 0);
 }
@@ -503,7 +500,6 @@ void snd_hdac_ext_stream_drsm_enable(struct hdac_bus *bus,
 				bool enable, int index)
 {
 	u32 mask = 0;
-	u32 register_mask = 0;
 
 	if (!bus->drsmcap) {
 		dev_err(bus->dev, "Address of DRSM capability is NULL\n");
@@ -512,12 +508,8 @@ void snd_hdac_ext_stream_drsm_enable(struct hdac_bus *bus,
 
 	mask |= (1 << index);
 
-	register_mask = readl(bus->drsmcap + AZX_REG_SPB_SPBFCCTL);
-
-	mask |= register_mask;
-
 	if (enable)
-		snd_hdac_updatel(bus->drsmcap, AZX_REG_DRSM_CTL, 0, mask);
+		snd_hdac_updatel(bus->drsmcap, AZX_REG_DRSM_CTL, mask, mask);
 	else
 		snd_hdac_updatel(bus->drsmcap, AZX_REG_DRSM_CTL, mask, 0);
 }
-- 
2.14.1
