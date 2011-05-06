From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 04/10] ASoC: upd9976: add capture ability
	for dai driver
Date: Fri, 06 May 2011 13:46:19 +0800
Message-ID: <20110506054618.26312.41572.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E22CD103849
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:44:52 +0200 (CEST)
In-Reply-To: <20110506053852.26312.79083.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Wang Xingchao <xingchao.wang@intel.com>

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/soc/codecs/upd9976.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index 7be10ae..5b8d047 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -303,6 +303,13 @@ static struct snd_soc_dai_driver upd9976_dais[] = {
 			    SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |
 			    SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32),
 	},
+	.capture = {
+		.stream_name = "Audio Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16),
+	},
 	.ops = &upd9976_audio_dai_ops,
 },
 };
