From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai
	driver name in snd_soc_find_dai
Date: Tue, 22 Aug 2017 15:57:21 +0800
Message-ID: <20170822075729.8438-3-jeffy.chen@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.141])
 by alsa0.perex.cz (Postfix) with ESMTP id EC01126755F
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 09:58:02 +0200 (CEST)
In-Reply-To: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org, Mark Brown <broonie@kernel.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, dianders@chromium.org, mka@chromium.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Currently we are searching dai name in snd_soc_find_dai, which could
either be dai driver name or component device name(for legacy naming).

Allow searching dai driver name in snd_soc_find_dai too, so that we can
use dai driver name to find legacy naming dais.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5:
Allow searching for dai driver name in snd_soc_find_dai, instead of
hacking non-zero device id to avoid legay dai naming.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 004daaa82102..77e7e2a11af0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -950,7 +950,7 @@ static struct snd_soc_component *soc_find_component(
 /**
  * snd_soc_find_dai - Find a registered DAI
  *
- * @dlc: name of the DAI and optional component info to match
+ * @dlc: name of the DAI or the DAI driver and optional component info to match
  *
  * This function will search all registered components and their DAIs to
  * find the DAI of the same name. The component's of_node and name
@@ -978,7 +978,8 @@ struct snd_soc_dai *snd_soc_find_dai(
 		if (dlc->name && strcmp(component->name, dlc->name))
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
-			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name))
+			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
+			    && strcmp(dai->driver->name, dlc->dai_name))
 				continue;
 
 			return dai;
-- 
2.11.0
