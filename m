From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: jack: Update documention to reflect
	other userspace interfaces
Date: Mon,  7 May 2012 17:10:21 +0100
Message-ID: <1336407021-31117-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13CF72442C
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 18:10:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since this is a generic API which should support any userspace interface
for reporting jacks update the documentation a little to make that a bit
clearer.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/core/jack.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 471e1e3..a06b165 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -155,7 +155,7 @@ EXPORT_SYMBOL(snd_jack_new);
  * @jack:   The jack to configure
  * @parent: The device to set as parent for the jack.
  *
- * Set the parent for the jack input device in the device tree.  This
+ * Set the parent for the jack devices in the device tree.  This
  * function is only valid prior to registration of the jack.  If no
  * parent is configured then the parent device will be the sound card.
  */
@@ -179,6 +179,9 @@ EXPORT_SYMBOL(snd_jack_set_parent);
  * mapping is provided but keys are enabled in the jack type then
  * BTN_n numeric buttons will be reported.
  *
+ * If jacks are not reporting via the input API this call will have no
+ * effect.
+ *
  * Note that this is intended to be use by simple devices with small
  * numbers of keys that can be reported.  It is also possible to
  * access the input device directly - devices with complex input
-- 
1.7.10
