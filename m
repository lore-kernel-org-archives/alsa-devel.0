From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: multi-component - Fix tlv320aic3x GPIO
	initialization
Date: Fri,  6 Aug 2010 10:04:38 +0300
Message-ID: <1281078278-10675-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9654B243F2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 09:03:35 +0200 (CEST)
Received: by eye27 with SMTP id 27so2552114eye.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 00:03:35 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

aic3x_init does a soft reset first and thus TLV320AIC3x GPIO setup must be
done after doing the basic init. Before multi-component the init was done
at i2c probe time and GPIO setup at soc probe time.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Liam, squash into TI CODECs commit.
---
 sound/soc/codecs/tlv320aic3x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 43fd9c1..0b80e24 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1231,6 +1231,8 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->control_data = aic3x->control_data;
 
+	aic3x_init(codec);
+
 	if (aic3x->setup) {
 		/* setup GPIO functions */
 		aic3x_write(codec, AIC3X_GPIO1_REG,
@@ -1239,8 +1241,6 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 			    (aic3x->setup->gpio_func[1] & 0xf) << 4);
 	}
 
-	aic3x_init(codec);
-
 	snd_soc_add_controls(codec, aic3x_snd_controls,
 			     ARRAY_SIZE(aic3x_snd_controls));
 
-- 
1.7.1
