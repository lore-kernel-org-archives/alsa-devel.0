From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ASoC: sgtl5000: fix devres handling
Date: Mon, 30 Jun 2014 10:58:18 +0100
Message-ID: <E1X1YLq-0004E1-MT@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 22BC72610CE
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 11:58:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The sgtl5000 uses a two-stage initialisation process.  The first stage
is when the platform driver is probed, where some resources are found
and initialised.  The second stage is via the codec driver's probe
function, where regulators are found and initialised using the managed
resource support.

The problem here is that this works fine until the codec driver is
unbound.  When this occurs, sgtl5000_remove() is called which is a no-op
as far as the managed resource code is concerned.  The regulators remain
allocated, and their pointers in sgtl5000_priv remain valid.

If the codec is now re-probed, it will again try and find the regulators,
which will now be busy.  This will fail.

That's not the only problem - if using the LDO regulator, the regulator
is unregistered from the regulator core code, but it still has a user.
When the user is cleaned up (eg, by removing the module) it hits the
free'd regulator, and this can oops the kernel.

This bug was originally introduced by 63e54cd9caa3ce ("ASoC: sgtl5000:
Use devm_regulator_bulk_get()").

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
You may wish to give some consideration to whether ASoC core code should
be doing this instead, this is probably a very common source of brokenness
where two-stage driver initialisation exists.  These kinds of issues are
why I consider (as a general rule) that two-stage driver initialisation
is really bad.

 sound/soc/codecs/sgtl5000.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 96ce061c1f10..3bbd89065313 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1305,6 +1305,9 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
+	if (!devres_open_group(codec->dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
 	ret = sgtl5000_enable_regulators(codec);
 	if (ret)
 		return ret;
@@ -1362,6 +1365,9 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 err:
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
+
+	devres_release_group(codec->dev, NULL);
+
 	ldo_regulator_remove(codec);
 
 	return ret;
@@ -1375,6 +1381,9 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
+
+	devres_release_group(codec->dev, NULL);
+
 	ldo_regulator_remove(codec);
 
 	return 0;
-- 
1.8.3.1
