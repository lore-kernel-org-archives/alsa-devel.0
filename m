From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: samsung: add missing \n to end of pr_err messages
Date: Fri, 16 Sep 2016 18:30:53 +0100
Message-ID: <20160916173053.13138-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, some pr_err messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/samsung/ac97.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 5eafb66..97d6700 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -74,7 +74,7 @@ static void s3c_ac97_activate(struct snd_ac97 *ac97)
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to activate!");
+		pr_err("AC97: Unable to activate!\n");
 }
 
 static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
@@ -100,7 +100,7 @@ static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to read!");
+		pr_err("AC97: Unable to read!\n");
 
 	stat = readl(s3c_ac97.regs + S3C_AC97_STAT);
 	addr = (stat >> 16) & 0x7f;
@@ -137,7 +137,7 @@ static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
 	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to write!");
+		pr_err("AC97: Unable to write!\n");
 
 	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
 	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
-- 
2.9.3
