From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/3] ASoC: skl_rt286: Add deepbuffer dai link
Date: Mon, 12 Jun 2017 17:10:57 +0530
Message-ID: <1497267657-20359-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1497267657-20359-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 897D1266E2D
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 13:55:49 +0200 (CEST)
In-Reply-To: <1497267657-20359-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds the deepbuffer device which can be opened with a bigger
buffer size. The application can disable interrupts and sleep for longer
duration.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index f5ab7b8d51d1..453826ea1367 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -43,6 +43,7 @@ struct skl_rt286_private {
 
 enum {
 	SKL_DPCM_AUDIO_PB = 0,
+	SKL_DPCM_AUDIO_DB_PB,
 	SKL_DPCM_AUDIO_CP,
 	SKL_DPCM_AUDIO_REF_CP,
 	SKL_DPCM_AUDIO_DMIC_CP,
@@ -310,6 +311,23 @@ static int skylake_dmic_startup(struct snd_pcm_substream *substream)
 		.dpcm_playback = 1,
 		.ops = &skylake_rt286_fe_ops,
 	},
+	[SKL_DPCM_AUDIO_DB_PB] = {
+		.name = "Skl Deepbuffer Port",
+		.stream_name = "Deep Buffer Audio",
+		.cpu_dai_name = "Deepbuffer Pin",
+		.platform_name = "0000:00:1f.3",
+		.nonatomic = 1,
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST
+		},
+		.dpcm_playback = 1,
+		.ops = &skylake_rt286_fe_ops,
+
+	},
 	[SKL_DPCM_AUDIO_CP] = {
 		.name = "Skl Audio Capture Port",
 		.stream_name = "Audio Record",
-- 
1.9.1
