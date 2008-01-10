From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/17] Add D1 power event to power down event
	sequence
Date: Thu, 10 Jan 2008 13:17:03 +0000
Message-ID: <1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 65C6724587
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:19 +0100 (CET)
In-Reply-To: <1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0e361d5..b159734 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -288,6 +288,14 @@ static void close_delayed_work(struct work_struct *work)
 		/* are we waiting on this codec DAI stream */
 		if (codec_dai->pop_wait == 1) {
 
+			/* power down the codec to D1 if no longer active */
+			if (codec->active == 0) {
+				dbg("pop wq D1 %s %s\n", codec->name,
+					codec_dai->playback.stream_name);
+				snd_soc_dapm_device_event(socdev,
+					SNDRV_CTL_POWER_D1);
+			}
+
 			codec_dai->pop_wait = 0;
 			snd_soc_dapm_stream_event(codec,
 				codec_dai->playback.stream_name,
-- 
1.5.3.8
