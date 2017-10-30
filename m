From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: fix build warning in soc-core.c
Date: Sun, 29 Oct 2017 17:10:34 -0700
Message-ID: <ef36bde9-d303-efe1-ce77-57e281311301@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id E644E266E0C
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 01:10:37 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc build error. A symbol that ends with an underscore
character ('_') has special meaning in reST (reStructuredText), so add
a '*' to prevent this error and to indicate that there are several of
these values to choose from.

../sound/soc/soc-core.c:2799: ERROR: Unknown target name: "snd_soc_daifmt".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Liam Girdwood <lgirdwood@gmail.com>
Cc:	Mark Brown <broonie@kernel.org>
Cc:	alsa-devel@alsa-project.org
---
 sound/soc/soc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414-rc7.orig/sound/soc/soc-core.c
+++ lnx-414-rc7/sound/soc/soc-core.c
@@ -2796,7 +2796,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_bclk_r
 /**
  * snd_soc_dai_set_fmt - configure DAI hardware audio format.
  * @dai: DAI
- * @fmt: SND_SOC_DAIFMT_ format value.
+ * @fmt: SND_SOC_DAIFMT_* format value.
  *
  * Configures the DAI hardware format and clocking.
  */
