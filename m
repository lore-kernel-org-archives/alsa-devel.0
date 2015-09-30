From: mengdong.lin@intel.com
Subject: [PATCH 2/8] ASoC: topology: ABI - Remove unused struct
	snd_soc_tplg_stream_config
Date: Wed, 30 Sep 2015 17:04:50 +0800
Message-ID: <483a16f54f7ec31bce216f07973431938d1a0dc2.1443602494.git.mengdong.lin@intel.com>
References: <cover.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E9A09265B97
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 10:50:20 +0200 (CEST)
In-Reply-To: <cover.1443602494.git.mengdong.lin@intel.com>
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

The struct snd_soc_tplg_stream_config is no longer used in the ABI.
We are using snd_soc_tplg_stream instead.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 2aa081c..4bef63f 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -227,16 +227,6 @@ struct snd_soc_tplg_stream {
 } __attribute__((packed));
 
 /*
- * Duplex stream configuration supported by SW/FW.
- */
-struct snd_soc_tplg_stream_config {
-	__le32 size;		/* in bytes of this structure */
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	struct snd_soc_tplg_stream playback;
-	struct snd_soc_tplg_stream capture;
-} __attribute__((packed));
-
-/*
  * Manifest. List totals for each payload type. Not used in parsing, but will
  * be passed to the component driver before any other objects in order for any
  * global component resource allocations.
-- 
1.9.1
