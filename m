From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm0010: Constify usage of firmware
	filenames
Date: Fri, 29 Mar 2013 09:45:34 +0000
Message-ID: <1364550335-15023-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F8FB26530C
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 10:53:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@wmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 40256b5..a5cd51f 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -342,7 +342,7 @@ static void byte_swap_64(u64 *data_in, u64 *data_out, u32 len)
 		data_out[i] = cpu_to_be64(le64_to_cpu(data_in[i]));
 }
 
-static int wm0010_firmware_load(char *name, struct snd_soc_codec *codec)
+static int wm0010_firmware_load(const char *name, struct snd_soc_codec *codec)
 {
 	struct spi_device *spi = to_spi_device(codec->dev);
 	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
-- 
1.7.2.5
