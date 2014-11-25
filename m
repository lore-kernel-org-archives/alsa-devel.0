From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3] ASoC: Remove 'const' from the device_node
	pointers
Date: Tue, 25 Nov 2014 12:14:48 +0100
Message-ID: <20141125112534.9070E2656F0@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AC75265626
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 12:25:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

As Russell King's explained it, there should not be pointers to
struct device_node:

"struct device_node is a ref-counted structure.  That means if you
 store a reference to it, you should "get" it, and you should "put"
 it once you've done.  The act of "put"ing the pointed-to structure
 involves writing to that structure, so it is totally unappropriate
 to store a device_node structure as a const pointer.  It forces you
 to have to cast it back to a non-const pointer at various points
 in time to use various OF function calls."

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v3: change the patch comment (Mark Brown)
v2: remove const from the pointers instead of modifying the
    OF functions (Russell King)
---
 include/sound/soc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 879e2b3..13e1648 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -883,7 +883,7 @@ struct snd_soc_platform_driver {
 
 struct snd_soc_dai_link_component {
 	const char *name;
-	const struct device_node *of_node;
+	struct device_node *of_node;
 	const char *dai_name;
 };
 
@@ -985,7 +985,7 @@ struct snd_soc_codec_conf {
 	 * DT/OF node, but not both.
 	 */
 	const char *dev_name;
-	const struct device_node *of_node;
+	struct device_node *of_node;
 
 	/*
 	 * optional map of kcontrol, widget and path name prefixes that are
@@ -1002,7 +1002,7 @@ struct snd_soc_aux_dev {
 	 * DT/OF node, but not both.
 	 */
 	const char *codec_name;
-	const struct device_node *codec_of_node;
+	struct device_node *codec_of_node;
 
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_component *component);
-- 
2.1.3
