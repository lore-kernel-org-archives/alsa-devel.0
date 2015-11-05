From: mengdong.lin@linux.intel.com
Subject: [PATCH 5/9] topology: ABI - Use __le32 instead of
	__u32 in snd_soc_tplg_dapm_widget
Date: Thu,  5 Nov 2015 20:48:54 +0800
Message-ID: <fb3e146f55a6d0c30894f62ed1e21531f8ea1b25.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D5E7426606B
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:50 +0100 (CET)
In-Reply-To: <cover.1446726689.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

This fixes the endianness of the ABI parameters in the struct.
The field 'num_kcontrols' is also extended from 16 bits to 32 bits.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index b08ff3a..acff6ec 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -347,11 +347,11 @@ struct snd_soc_tplg_dapm_widget {
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
