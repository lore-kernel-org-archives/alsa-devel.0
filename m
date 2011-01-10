From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: let snd_soc_update_bits() return an
	error code
Date: Mon, 10 Jan 2011 13:28:33 -0600
Message-ID: <1294687713-16433-2-git-send-email-timur@freescale.com>
References: <1294687713-16433-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id 430D6245C7
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 20:28:41 +0100 (CET)
In-Reply-To: <1294687713-16433-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Update snd_soc_update_bits() so that it returns a negative error code if the
the read or write operation fails.

Note that currently, a lot of the lower-level read functions have an unsigned
integer return type (and some of them even try to return a negative number),
but this code still appears to work in those cases.

An examination of the code shows that all current callers are compatible with
this change.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/soc-core.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a233607..ea4a8e6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2132,19 +2132,26 @@ EXPORT_SYMBOL_GPL(snd_soc_write);
  *
  * Writes new register value.
  *
- * Returns 1 for change else 0.
+ * Returns 1 for change, 0 for no change, or negative error code.
  */
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
 				unsigned int mask, unsigned int value)
 {
 	int change;
 	unsigned int old, new;
+	int ret;
+
+	ret = old = snd_soc_read(codec, reg);
+	if (ret < 0)
+		return ret;
 
-	old = snd_soc_read(codec, reg);
 	new = (old & ~mask) | value;
 	change = old != new;
-	if (change)
-		snd_soc_write(codec, reg, new);
+	if (change) {
+		ret = snd_soc_write(codec, reg, new);
+		if (ret < 0)
+			return ret;
+	}
 
 	return change;
 }
-- 
1.7.3.4
