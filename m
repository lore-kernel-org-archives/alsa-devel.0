From: mengdong.lin@intel.com
Subject: [PATCH v2 3/8] ASoC: topology: ABI - Use __le32
	instead of __u32 in snd_soc_tplg_dapm_widget
Date: Wed, 30 Sep 2015 17:30:05 +0800
Message-ID: <1adb358d870891f0553feb8469a36632557e68a8.1443605139.git.mengdong.lin@intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BF509265DAA
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:15:35 +0200 (CEST)
In-Reply-To: <cover.1443605139.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@intel.com, vedang.patel@intel.com, subhransu.s.prusty@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

This fixes the endianness of the ABI parameters in the struct.
The field 'num_kcontrols' is also extended from 16 bits to 32 bits.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 4bef63f..88210a8 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -356,11 +356,11 @@ struct snd_soc_tplg_dapm_widget {
 	__le32 shift;		/* bits to shift */
 	__le32 mask;		/* non-shifted mask */
 	__le32 subseq;		/* sort within widget type */
-	__u32 invert;		/* invert the power bit */
-	__u32 ignore_suspend;	/* kept enabled over suspend */
-	__u16 event_flags;
-	__u16 event_type;
-	__u16 num_kcontrols;
+	__le32 invert;		/* invert the power bit */
+	__le32 ignore_suspend;	/* kept enabled over suspend */
+	__le16 event_flags;
+	__le16 event_type;
+	__le32 num_kcontrols;
 	struct snd_soc_tplg_private priv;
 	/*
 	 * kcontrols that relate to this widget
-- 
1.9.1
