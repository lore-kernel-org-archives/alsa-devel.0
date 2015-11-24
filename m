From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: fix kernel-doc warnings in
	sound/soc/soc-ops.c
Date: Mon, 23 Nov 2015 17:37:54 -0800
Message-ID: <5653BF72.1050509@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B73E626583F
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 02:37:59 +0100 (CET)
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

Fix kernel-doc warnings in soc-ops.c:

..//sound/soc/soc-ops.c:415: warning: No description found for parameter 'ucontrol'
..//sound/soc/soc-ops.c:415: warning: Excess function parameter 'uinfo' description in 'snd_soc_put_volsw_sx'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Liam Girdwood <lgirdwood@gmail.com>
Cc:	Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-44-rc2.orig/sound/soc/soc-ops.c
+++ lnx-44-rc2/sound/soc/soc-ops.c
@@ -404,7 +404,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 /**
  * snd_soc_put_volsw_sx - double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double mixer control that spans 2 registers.
  *
