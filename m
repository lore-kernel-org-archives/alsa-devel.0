From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: snd_soc_rtdcom_lookup() cares
	component driver name" to the asoc tree
Date: Tue, 23 Jan 2018 17:28:27 +0000
Message-ID: <E1ee2N1-00035L-5E@debutante>
References: <87o9llo1b1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4624E2672B0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2018 18:28:32 +0100 (CET)
In-Reply-To: <87o9llo1b1.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, MukundaVijendar <vijendar.mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: snd_soc_rtdcom_lookup() cares component driver name

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

>From 971da24c48a9447fb7a3c7805812fd5f443ca008 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Jan 2018 00:41:24 +0000
Subject: [PATCH] ASoC: soc-core: snd_soc_rtdcom_lookup() cares component
 driver name

snd_soc_rtdcom_lookup() look up component by uisng driver name.
Then, it uses component->driver->name.
Some driver might doesn't have it, thus it should care NULL pointer.
This patch solve this issue.

Reported-by: Mukunda,Vijendar <vijendar.mukunda@amd.com>
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Mukunda,Vijendar <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9b79c2199781..52b2e04cc5e2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -590,9 +590,17 @@ struct snd_soc_component *snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_soc_rtdcom_list *rtdcom;
 
+	if (!driver_name)
+		return NULL;
+
 	for_each_rtdcom(rtd, rtdcom) {
-		if ((rtdcom->component->driver->name == driver_name) ||
-		    strcmp(rtdcom->component->driver->name, driver_name) == 0)
+		const char *component_name = rtdcom->component->driver->name;
+
+		if (!component_name)
+			continue;
+
+		if ((component_name == driver_name) ||
+		    strcmp(component_name, driver_name) == 0)
 			return rtdcom->component;
 	}
 
-- 
2.15.1
