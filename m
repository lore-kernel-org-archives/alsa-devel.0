From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: rt5645: Allow 4 channel recording on AIF1
Date: Mon, 28 Sep 2015 13:32:37 -0700
Message-ID: <1443472357-12150-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 150812604E5
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 22:33:03 +0200 (CEST)
Received: by pacex6 with SMTP id ex6so183652193pac.0
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 13:33:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The codec supports 4 channel recording with TDM on AIF1.
This patch modifies the DAI capability to allow it.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index b0d96b6..0d092bf 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3101,7 +3101,7 @@ static struct snd_soc_dai_driver rt5645_dai[] = {
 		.capture = {
 			.stream_name = "AIF1 Capture",
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 4,
 			.rates = RT5645_STEREO_RATES,
 			.formats = RT5645_FORMATS,
 		},
-- 
2.6.0.rc2.230.g3dd15c0
