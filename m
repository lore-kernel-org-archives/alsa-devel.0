From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: codecs: dmic: Fix check of return value
	from read of 'num-channels'
Date: Fri, 19 Jan 2018 15:36:50 -0800
Message-ID: <20180119233650.100472-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 28780267210
 for <alsa-devel@alsa-project.org>; Sat, 20 Jan 2018 00:37:25 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id g16so2539526pgn.7
 for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2018 15:37:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 7fb59e940f62 ("ASoC: codecs: dmic: Make number of channels
 configurable") introduces an optional property to the device tree
to specify the number of DMIC channels. dmic_codec_probe() uses
of_property_read_u32() to read the DT value, and expects a return
value of -ENOENT when the property does not exist. This expectation
is incorrect, the actual value returned in this case is -EINVAL (see
of_find_property_value_of_size(), which is called under the hood).
Check for -EINVAL instead.

Fixes: 7fb59e940f62 ("ASoC: codecs: dmic: Make number of channels configurable")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/codecs/dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c88f974ebe3e..cf83c423394d 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -113,7 +113,7 @@ static int dmic_dev_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		err = of_property_read_u32(pdev->dev.of_node, "num-channels", &chans);
-		if (err && (err != -ENOENT))
+		if (err && (err != -EINVAL))
 			return err;
 
 		if (!err) {
-- 
2.16.0.rc1.238.g530d649a79-goog
