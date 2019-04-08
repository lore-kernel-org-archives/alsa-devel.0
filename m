From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Use the correct dobj to free
	enum control values and texts" to the asoc tree
Date: Mon,  8 Apr 2019 14:30:12 +0700 (+07)
Message-ID: <20190408073012.9E25E441D3B@finisterre.ee.mobilebroadband>
References: <20190405024833.12189-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D26E1F8973B
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 09:30:24 +0200 (CEST)
In-Reply-To: <20190405024833.12189-1-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Use the correct dobj to free enum control values and texts

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

>From 54f8844e3f6cf898450a6c85f70fa997f0aa72b9 Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 4 Apr 2019 19:48:33 -0700
Subject: [PATCH] ASoC: topology: Use the correct dobj to free enum control
 values and texts

The control values and texts of the enum kcontrol associated
with a widget need to be freed when the widget is removed.
However, both struct snd_soc_dapm_widget and struct soc_enum
contain a dobj member, which resulted in a confusion.
The existing code generates a null pointer dereference by
attempting to free the values and texts from the dobj which
belongs to the widget instead of the dobj belonging to the
enum kcontrol.

The suggested fix is to use the correct dobj member (se->dobj)
of the enum kcontrol.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 25fca7055464..96852d250619 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -482,10 +482,11 @@ static void remove_widget(struct snd_soc_component *comp,
 
 			snd_ctl_remove(card, kcontrol);
 
-			kfree(dobj->control.dvalues);
+			/* free enum kcontrol's dvalues and dtexts */
+			kfree(se->dobj.control.dvalues);
 			for (j = 0; j < se->items; j++)
-				kfree(dobj->control.dtexts[j]);
-			kfree(dobj->control.dtexts);
+				kfree(se->dobj.control.dtexts[j]);
+			kfree(se->dobj.control.dtexts);
 
 			kfree(se);
 			kfree(w->kcontrol_news[i].name);
-- 
2.20.1
