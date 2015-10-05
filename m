From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/1] ASoC: da7219: Improve error handling for
 regulator supplies
Date: Mon, 5 Oct 2015 15:10:04 +0100
Message-ID: <9f50566afde93ac58ae8205316cc9d1bc2088b2f.1444053230.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 71154260599
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:10:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Currently if bulk_enable() of supplies fails, the code still goes on
to try and put the device into active state, and set expected IO
voltage of the device. This doesn't really make sense so code now
returns on bulk_enable() failure, with an error message. Also,
to help with debug, failure to get supplies also provides an error
message.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

This patch is based on changes introduced under patch:

'ASoC: codecs: Add da7219 codec driver'
(Commit 6d817c0e9fd7536be76690bfdee88e8a81c16f7d, kernel/git/broonie/sound.git)

 sound/soc/codecs/da7219.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 76f8fc2..c86a833 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1554,8 +1554,10 @@ static int da7219_handle_supplies(struct snd_soc_codec *codec)

 	ret = devm_regulator_bulk_get(codec->dev, DA7219_NUM_SUPPLIES,
 				      da7219->supplies);
-	if (ret)
+	if (ret) {
+		dev_err(codec->dev, "Failed to get supplies");
 		return ret;
+	}

 	/* Determine VDDIO voltage provided */
 	vddio = da7219->supplies[DA7219_SUPPLY_VDDIO].consumer;
@@ -1567,6 +1569,10 @@ static int da7219_handle_supplies(struct snd_soc_codec *codec)

 	/* Enable main supplies */
 	ret = regulator_bulk_enable(DA7219_NUM_SUPPLIES, da7219->supplies);
+	if (ret) {
+		dev_err(codec->dev, "Failed to enable supplies");
+		return ret;
+	}

 	/* Ensure device in active mode */
 	snd_soc_write(codec, DA7219_SYSTEM_ACTIVE, DA7219_SYSTEM_ACTIVE_MASK);
@@ -1574,7 +1580,7 @@ static int da7219_handle_supplies(struct snd_soc_codec *codec)
 	/* Update IO voltage level range */
 	snd_soc_write(codec, DA7219_IO_CTRL, io_voltage_lvl);

-	return ret;
+	return 0;
 }

 static void da7219_handle_pdata(struct snd_soc_codec *codec)
--
1.9.3
