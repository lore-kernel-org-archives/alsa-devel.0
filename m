From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Instantiate any forgotten DAPM
	widgets
Date: Mon, 15 Jun 2009 10:33:01 +0100
Message-ID: <1245058382-30813-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090615093223.GA30743@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3B01103803
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:33:03 +0200 (CEST)
In-Reply-To: <20090615093223.GA30743@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

With the recent changes to the DAPM power checks it has become important
to explicitly instantiate all widgets but some drivers were forgetting
to do that.  Since everything needs to do it add a call to instantiate
them immediately before the card registration - it does no harm when it
is called repeatedly and saves work in drivers.

Tested-by: pHilipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3f44150..1d70829 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1389,6 +1389,9 @@ int snd_soc_init_card(struct snd_soc_device *socdev)
 	snprintf(codec->card->longname, sizeof(codec->card->longname),
 		 "%s (%s)", card->name, codec->name);
 
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(codec);
+
 	ret = snd_card_register(codec->card);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: failed to register soundcard for %s\n",
-- 
1.6.3.1
