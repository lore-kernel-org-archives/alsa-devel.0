From: mengdong.lin@linux.intel.com
Subject: [PATCH 4/9] topology: ABI - Remove unused struct
	snd_soc_tplg_stream_config
Date: Thu,  5 Nov 2015 20:48:46 +0800
Message-ID: <06057ee1dbb744df61847123a7037b240f67afb1.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2C0266000
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:20 +0100 (CET)
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

The struct snd_soc_tplg_stream_config is no longer used in the ABI.
We are using snd_soc_tplg_stream instead.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 8dc2343..b08ff3a 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -218,16 +218,6 @@ struct snd_soc_tplg_stream {
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
