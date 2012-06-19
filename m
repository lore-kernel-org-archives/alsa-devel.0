From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Add missing include of pcm.h to
	pcm_params.h
Date: Tue, 19 Jun 2012 19:31:48 +0100
Message-ID: <1340130709-2857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 564B3243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 20:31:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There's a dependency but no #include.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/pcm_params.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index f494f1e..37ae12e 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <sound/pcm.h>
+
 int snd_pcm_hw_param_first(struct snd_pcm_substream *pcm, 
 			   struct snd_pcm_hw_params *params,
 			   snd_pcm_hw_param_t var, int *dir);
-- 
1.7.10
