From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/9] topology: ABI - Remove tdm_slot & dai_fmt
	from snd_soc_tplg_stream
Date: Thu,  5 Nov 2015 20:48:38 +0800
Message-ID: <c1e7e2f2b5976107549c9a25356159d73f2ce7a9.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C9CD265E27
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:12 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

These two fields are line parameters for BE/CC links and
should not be from toplogy but from ACPI.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index ddc28ce..8dc2343 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -215,8 +215,6 @@ struct snd_soc_tplg_stream {
 	__le32 period_bytes;	/* size of period in bytes */
 	__le32 buffer_bytes;	/* size of buffer in bytes */
 	__le32 channels;	/* channels */
-	__le32 tdm_slot;	/* optional BE bitmask of supported TDM slots */
-	__le32 dai_fmt;		/* SND_SOC_DAIFMT_  */
 } __attribute__((packed));
 
 /*
-- 
1.9.1
