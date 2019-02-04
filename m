From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: clear platform pointers on
	error" to the asoc tree
Date: Mon,  4 Feb 2019 09:26:55 +0000 (GMT)
Message-ID: <20190204092655.B62BD440082@finisterre.ee.mobilebroadband>
References: <20190129214710.135124-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E492674B6
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 10:26:59 +0100 (CET)
In-Reply-To: <20190129214710.135124-1-cujomalainey@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: clear platform pointers on error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 78a24e10cd94420f1b4e2dc5923ae7109e2aaba1 Mon Sep 17 00:00:00 2001
From: Curtis Malainey <cujomalainey@chromium.org>
Date: Tue, 29 Jan 2019 13:47:09 -0800
Subject: [PATCH] ASoC: soc-core: clear platform pointers on error

Originally snd_soc_init_platform was not cleaning up its pointers, this
was fixed to always reallocate dynamic memory but created a memory leak
when snd_soc_init_platform was called multiple times during the same
probe attempt and also threw away any changes made to the struct between
calls. In order to avoid reallocating memory that is still valid, the
behaviour will be changed to clear the dynamically set pointers on a
probe error and a unregister event and snd_soc_init_platform will go
back to its original behaviour of only allocating null pointers so it will
stop throwing away valid changes.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93efab486736..8c63d32ab2fe 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1048,7 +1048,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	 *	soc.h :: struct snd_soc_dai_link
 	 */
 	/* convert Legacy platform link */
-	if (!platform || dai_link->legacy_platform) {
+	if (!platform) {
 		platform = devm_kzalloc(card->dev,
 				sizeof(struct snd_soc_dai_link_component),
 				GFP_KERNEL);
@@ -1071,6 +1071,24 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	return 0;
 }
 
+static void soc_cleanup_platform(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link;
+	int i;
+	/*
+	 * FIXME
+	 *
+	 * this function should be removed with snd_soc_init_platform
+	 */
+
+	for_each_card_prelinks(card, i, link) {
+		if (link->legacy_platform) {
+			link->legacy_platform = 0;
+			link->platforms       = NULL;
+		}
+	}
+}
+
 static int snd_soc_init_multicodec(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *dai_link)
 {
@@ -2015,6 +2033,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
 	soc_remove_pcm_runtimes(card);
+	soc_cleanup_platform(card);
 
 	/* remove auxiliary devices */
 	soc_remove_aux_devices(card);
-- 
2.20.1
