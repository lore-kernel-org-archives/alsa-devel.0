From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: Use dev_dbg in
	dac33_hard_power function
Date: Mon, 17 May 2010 14:21:45 +0300
Message-ID: <1274095306-24838-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1274095306-24838-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 46394245F0
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 13:21:54 +0200 (CEST)
In-Reply-To: <1274095306-24838-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: felipe.balbi@nokia.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Felipe Balbi <felipe.balbi@nokia.com>

Since the cases when the same power state would be set again
handled gracefully, we do not need to use dev_warn.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 007fe83..ad1795a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -352,7 +352,7 @@ static int dac33_hard_power(struct snd_soc_codec *codec, int power)
 
 	/* Safety check */
 	if (unlikely(power == dac33->chip_power)) {
-		dev_warn(codec->dev, "Trying to set the same power state: %s\n",
+		dev_dbg(codec->dev, "Trying to set the same power state: %s\n",
 			power ? "ON" : "OFF");
 		goto exit;
 	}
-- 
1.7.1
