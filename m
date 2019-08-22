From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: wm8988: fix typo in
	wm8988_right_line_controls
Date: Thu, 22 Aug 2019 22:36:08 +0800
Message-ID: <20190822143608.59824-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 107ECF80112
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 16:36:42 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, yuehaibing@huawei.com, tglx@linutronix.de, allison@lohutok.net, gregkh@linuxfoundation.org, info@metux.net
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/wm8988.c:270:30: warning:
 wm8988_rline_enum defined but not used [-Wunused-const-variable=]

wm8988_rline_enum should be used in wm8988_right_line_controls.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5409fb4e327a ("ASoC: Add WM8988 CODEC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/wm8988.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 25e74cf..85bfd04 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -273,7 +273,7 @@ static const struct soc_enum wm8988_rline_enum =
 			      wm8988_line_texts,
 			      wm8988_line_values);
 static const struct snd_kcontrol_new wm8988_right_line_controls =
-	SOC_DAPM_ENUM("Route", wm8988_lline_enum);
+	SOC_DAPM_ENUM("Route", wm8988_rline_enum);
 
 /* Left Mixer */
 static const struct snd_kcontrol_new wm8988_left_mixer_controls[] = {
-- 
2.7.4
