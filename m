From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound: soc: fix soc-core.c kernel-doc warning
Date: Sun, 2 Sep 2018 19:38:10 -0700
Message-ID: <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning:

../sound/soc/soc-core.c:2918: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c |    2 --
 1 file changed, 2 deletions(-)

--- lnx-419-rc2.orig/sound/soc/soc-core.c
+++ lnx-419-rc2/sound/soc/soc-core.c
@@ -2910,8 +2910,6 @@ static struct snd_soc_dai *soc_add_dai(s
  * @component: The component the DAIs are registered for
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
- * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
- *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
 				 struct snd_soc_dai_driver *dai_drv, size_t count)
