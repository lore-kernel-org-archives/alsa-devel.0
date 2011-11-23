From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: core: don't try to resume uninstantiated
	a soc-audio devices
Date: Wed, 23 Nov 2011 20:24:10 +0100
Message-ID: <1322076250-22203-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 07FB424461
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 20:24:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "[v3.1]"@mail.zonque.de, Daniel Mack <zonque@gmail.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

The code tries to schedule a work item from the resume context, which
will crash the kernel if snd_soc_instantiate_card() has not been called
for the card before.

The bug I triggered is related to 82e14e8b ("ASoC: core: Don't schedule
deferred_resume_work twice"), hence a backport to 3.1 is necessary.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: stable@kernel.org [v3.1]
---
 sound/soc/soc-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5d3685..721f16e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -709,6 +709,9 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i, ac97_control = 0;
 
+	if (!card->instantiated)
+		return 0;
+
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
-- 
1.7.7.3
