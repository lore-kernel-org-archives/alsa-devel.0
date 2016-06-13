From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm5102: Correct supported channels
	on trace compressed DAI
Date: Mon, 13 Jun 2016 13:35:16 +0100
Message-ID: <1465821317-28449-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8D92654C7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:35:13 +0200 (CEST)
In-Reply-To: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ajit.pandey@soctronics.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The audio trace firmware on wm5102 only supports 4 channels correct
the DAI driver structure to reflect this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 3f024b8..846deed 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1873,7 +1873,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 		.capture = {
 			.stream_name = "Audio Trace CPU",
 			.channels_min = 1,
-			.channels_max = 6,
+			.channels_max = 4,
 			.rates = WM5102_RATES,
 			.formats = WM5102_FORMATS,
 		},
-- 
2.1.4
