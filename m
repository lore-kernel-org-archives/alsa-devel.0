From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH 1/2] ASoC: topology: Rename clock_gated to
	clock_cont in snd_soc_tplg_hw_config
Date: Mon, 19 Feb 2018 07:05:30 +0100
Message-ID: <20180219060531.17276-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A8D2266E7D
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 07:05:51 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id l43so8421451wrc.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Feb 2018 22:05:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

In kernel `soc-dai.h`, DAI clock gating is defined as following:

~~~~
\#define SND_SOC_DAIFMT_CONT		(1 << 4) /* continuous clock */
\#define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
~~~~

Therefore, the corresponding field of struct snd_soc_tplg_hw_config should
be inverted compared to the current logic:

clock_count = 1 => SND_SOC_DAIFMT_CONT
clock_count = 0 => SND_SOC_DAIFMT_GATED

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 include/uapi/sound/asoc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 69c37ecbff7e..10188850dede 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -312,7 +312,9 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_cont;	/* 1 if clock is continuous, and can not be
+				 * gated to save power
+				 */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
-- 
2.13.6
