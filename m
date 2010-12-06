From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-core: Remove useless inline function
	construct
Date: Mon,  6 Dec 2010 15:49:20 +0000
Message-ID: <1291650560-16710-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 560881038DB
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 16:49:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

There is no need to mark this function as inline.  Inline functions
usually are small and concise functions that benefit from not needing
to set up a stack frame and undergo a call/ret sequence upon each
invocation.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e586616..1b4cf65 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3194,7 +3194,7 @@ static int snd_soc_unregister_card(struct snd_soc_card *card)
  * Simplify DAI link configuration by removing ".-1" from device names
  * and sanitizing names.
  */
-static inline char *fmt_single_name(struct device *dev, int *id)
+static char *fmt_single_name(struct device *dev, int *id)
 {
 	char *found, name[NAME_SIZE];
 	int id1, id2;
-- 
1.7.3.3
