From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] ASoC: bt-sco: support wide band speech
Date: Mon, 24 Nov 2014 20:29:32 +0800
Message-ID: <1416832172-4875-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 460352604F9
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 13:29:53 +0100 (CET)
Received: by mail-pd0-f172.google.com with SMTP id y13so1625249pdi.3
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 04:29:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Yibo Cai <yibo.cai@csr.com>, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

From: Yibo Cai <yibo.cai@csr.com>

HFP1.6 requires support for wide band speech(16KHz) over Bluetooth.

Signed-off-by: Yibo Cai <yibo.cai@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/bt-sco.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index c4cf069..fc0664b 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -31,14 +31,14 @@ static struct snd_soc_dai_driver bt_sco_dai = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
 		 .stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 };
-- 
2.1.1
