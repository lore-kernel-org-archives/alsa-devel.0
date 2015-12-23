From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Use proper output for
	external amp routes" to the asoc tree
Date: Wed, 23 Dec 2015 00:09:01 +0000
Message-ID: <E1aBWzF-0007Mp-A1@debutante>
References: <1450821617-12906-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE92E265D83
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:09 +0100 (CET)
In-Reply-To: <1450821617-12906-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Use proper output for external amp routes

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6b803c611c66debd6fc454c9ed049822994a5885 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 22 Dec 2015 23:00:17 +0100
Subject: [PATCH] ASoC: sun4i-codec: Use proper output for external amp routes

An external amp (if any) is connected to the external outputs of the SoC
of course, rather then directly to the internal amp.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e6cc6a14718a..44f170c73b06 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -728,7 +728,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_card_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route sun4i_codec_card_dapm_routes[] = {
-	{ "Speaker", NULL, "Power Amplifier" },
+	{ "Speaker", NULL, "HP Right" },
+	{ "Speaker", NULL, "HP Left" },
 };
 
 static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
-- 
2.6.2
