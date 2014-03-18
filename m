From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/13] ASoC: Track which components have been
	registered with snd_soc_register_component()
Date: Tue, 18 Mar 2014 09:02:11 +0100
Message-ID: <1395129736-11938-9-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D2B6261AEC
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:47 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_unregister_component() takes the parent device of the component as a
parameter and then looks up the component based on this. This is a problem if
multiple components are registered for the same parent device. Currently drivers
do not do this, but some drivers register a CPU DAI component and a platform for
the same parent device. This will become a problem once platforms are also made
components. To make sure that snd_soc_unregister_component() will not
accidentally unregister the platform in such a case only consider components
that were registered with snd_soc_register_component(). This is only meant as
short term stopgap solution to be able to continue componentisation. Long term
we'll need something different.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 1 +
 sound/soc/soc-core.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a355d0f..f8a79c1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -662,6 +662,7 @@ struct snd_soc_component {
 	unsigned int active;
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
+	unsigned int registered_as_component:1;
 
 	struct list_head list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4df9859..1ee3dd6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3885,6 +3885,7 @@ int snd_soc_register_component(struct device *dev,
 	}
 
 	cmpnt->ignore_pmdown_time = true;
+	cmpnt->registered_as_component = true;
 
 	return __snd_soc_register_component(dev, cmpnt, cmpnt_drv, NULL,
 					    dai_drv, num_dai, true);
@@ -3900,7 +3901,7 @@ void snd_soc_unregister_component(struct device *dev)
 	struct snd_soc_component *cmpnt;
 
 	list_for_each_entry(cmpnt, &component_list, list) {
-		if (dev == cmpnt->dev)
+		if (dev == cmpnt->dev && cmpnt->registered_as_component)
 			goto found;
 	}
 	return;
-- 
1.8.0
