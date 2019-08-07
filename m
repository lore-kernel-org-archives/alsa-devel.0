From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: reuse rtdcom at
	snd_soc_rtdcom_add()" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:48 +0100 (BST)
Message-ID: <20190807133048.18F042743057@ypsilon.sirena.org.uk>
References: <87h86tahp2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2C7BF80227
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:49 +0200 (CEST)
In-Reply-To: <87h86tahp2.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: reuse rtdcom at snd_soc_rtdcom_add()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 32d2c172fe88705058310635a732259c0a98e89b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Aug 2019 10:30:47 +0900
Subject: [PATCH] ASoC: soc-core: reuse rtdcom at snd_soc_rtdcom_add()

snd_soc_rtdcom_add() is using both "rtdcom" and "new_rtdcom" as
variable name, but these are not used at same time.
Let's reuse rtdcom.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87h86tahp2.wl-kuninori.morimoto.gx@renesas.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e176b972e4e6..d12054ab8741 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -274,7 +274,6 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_rtdcom_list *new_rtdcom;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		/* already connected */
@@ -282,14 +281,14 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			return 0;
 	}
 
-	new_rtdcom = kmalloc(sizeof(*new_rtdcom), GFP_KERNEL);
-	if (!new_rtdcom)
+	rtdcom = kmalloc(sizeof(*rtdcom), GFP_KERNEL);
+	if (!rtdcom)
 		return -ENOMEM;
 
-	new_rtdcom->component = component;
-	INIT_LIST_HEAD(&new_rtdcom->list);
+	rtdcom->component = component;
+	INIT_LIST_HEAD(&rtdcom->list);
 
-	list_add_tail(&new_rtdcom->list, &rtd->component_list);
+	list_add_tail(&rtdcom->list, &rtd->component_list);
 
 	return 0;
 }
-- 
2.20.1
