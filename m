From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Check widget kcontrols before
	deref" to the asoc tree
Date: Tue, 17 Apr 2018 18:09:25 +0100
Message-ID: <E1f8U6f-0001eL-FW@debutante>
References: <20180327133045.29351-6-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E21C1267642
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 19:09:27 +0200 (CEST)
In-Reply-To: <20180327133045.29351-6-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Check widget kcontrols before deref

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

>From f53c4c20d6d38bcefd89bfcab135486cbb797884 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 27 Mar 2018 14:30:44 +0100
Subject: [PATCH] ASoC: topology: Check widget kcontrols before deref

Validate the topology input before we dereference the pointer.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 5598e891b2b3..986b8b2f90fb 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -513,7 +513,7 @@ static void remove_widget(struct snd_soc_component *comp,
 	 */
 	if (dobj->widget.kcontrol_type == SND_SOC_TPLG_TYPE_ENUM) {
 		/* enumerated widget mixer */
-		for (i = 0; i < w->num_kcontrols; i++) {
+		for (i = 0; w->kcontrols != NULL && i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 			struct soc_enum *se =
 				(struct soc_enum *)kcontrol->private_value;
@@ -530,7 +530,7 @@ static void remove_widget(struct snd_soc_component *comp,
 		}
 	} else {
 		/* volume mixer or bytes controls */
-		for (i = 0; i < w->num_kcontrols; i++) {
+		for (i = 0; w->kcontrols != NULL && i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 
 			if (dobj->widget.kcontrol_type
-- 
2.17.0
