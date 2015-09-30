From: mengdong.lin@intel.com
Subject: [PATCH v2 8/8] ASoC: topology: ABI - Remove tdm_slot &
	dai_fmt from snd_soc_tplg_stream
Date: Wed, 30 Sep 2015 17:32:40 +0800
Message-ID: <30ca5b75b0eb2dc29ab9cbbb8c83d180799a91cd.1443605139.git.mengdong.lin@intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E8EBD265E0E
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:18:26 +0200 (CEST)
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

From: Mengdong Lin <mengdong.lin@intel.com>

These two fields are line parameters for BE/CC links and
should not be from toplogy but from ACPI.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 538ea13..26539a7 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -224,8 +224,6 @@ struct snd_soc_tplg_stream {
 	__le32 period_bytes;	/* size of period in bytes */
 	__le32 buffer_bytes;	/* size of buffer in bytes */
 	__le32 channels;	/* channels */
-	__le32 tdm_slot;	/* optional BE bitmask of supported TDM slots */
-	__le32 dai_fmt;		/* SND_SOC_DAIFMT_  */
 } __attribute__((packed));
 
 /*
-- 
1.9.1
