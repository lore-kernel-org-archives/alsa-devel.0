From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 11/14] ASoC: core: Tell codec that jack is being removed
Date: Wed,  5 Jun 2019 15:45:53 +0200
Message-ID: <20190605134556.10322-12-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When component is being removed we should disable jack, otherwise some
codecs will try to trigger interrupt using freed structures.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7abb017a83f3..ace5fb01d9a0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -951,6 +951,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 static void soc_cleanup_component(struct snd_soc_component *component)
 {
+	snd_soc_component_set_jack(component, NULL, NULL);
 	list_del(&component->card_list);
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
-- 
2.17.1
