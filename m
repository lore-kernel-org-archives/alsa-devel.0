From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [RFC PATCH 6/7] ASoC: mioa701_wm9713: convert to new ac97 bus
Date: Sat, 30 Apr 2016 23:15:38 +0200
Message-ID: <1462050939-27940-7-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Convert to the new auto-probing ac97 bus, which changes the device name.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/pxa/mioa701_wm9713.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 5c8f9db50a47..4ed10e6ff5d1 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -149,7 +149,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.stream_name = "AC97 HiFi",
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9713-hifi",
-		.codec_name = "wm9713-codec",
+		.codec_name = "pxa2xx-ac97:0",
 		.init = mioa701_wm9713_init,
 		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
@@ -159,7 +159,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name ="wm9713-aux",
-		.codec_name = "wm9713-codec",
+		.codec_name = "pxa2xx-ac97:0",
 		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
 	},
-- 
2.1.4
