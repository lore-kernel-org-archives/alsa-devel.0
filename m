From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: rt5663: fix a debug statement
Date: Thu, 13 Oct 2016 11:47:13 +0300
Message-ID: <20161013084712.GB16198@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We increment "i" before printing the debug statement.  That makes it
the wrong sleep_time[] information and Smatch complains that the last
increment could be beyond the end of the array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 01a18d8..00ff278 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1547,11 +1547,11 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			msleep(sleep_time[i]);
 			val = snd_soc_read(codec, RT5663_EM_JACK_TYPE_2) &
 				0x0003;
+			dev_dbg(codec->dev, "%s: MX-00e7 val=%x sleep %d\n",
+				__func__, val, sleep_time[i]);
 			i++;
 			if (val == 0x1 || val == 0x2 || val == 0x3)
 				break;
-			dev_dbg(codec->dev, "%s: MX-00e7 val=%x sleep %d\n",
-				__func__, val, sleep_time[i]);
 		}
 		dev_dbg(codec->dev, "%s val = %d\n", __func__, val);
 		switch (val) {
