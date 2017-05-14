From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: hdmi-codec: fix spelling mistake:
	"deteced" -> "detected"
Date: Sun, 14 May 2017 17:53:21 +0100
Message-ID: <20170514165321.6615-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 32AC8266CF6
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 18:53:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vincent Abriou <vincent.abriou@st.com>, Jon Medhurst <tixy@linaro.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 8c5ae1fc23a9..a3f15149afcf 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -819,7 +819,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	mutex_unlock(&hdmi_mutex);
 
 	if (hd->cnt >= ARRAY_SIZE(hdmi_dai_name)) {
-		dev_err(dev, "too many hdmi codec are deteced\n");
+		dev_err(dev, "too many hdmi codec are detected\n");
 		return -EINVAL;
 	}
 
-- 
2.11.0
