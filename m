From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 7/8] ASoC: dapm: Add a few supply widget
	sanity checks
Date: Sat, 25 Oct 2014 17:42:02 +0200
Message-ID: <1414251723-25050-8-git-send-email-lars@metafoo.de>
References: <1414251723-25050-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F602260643
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 17:42:17 +0200 (CEST)
In-Reply-To: <1414251723-25050-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Supply widgets are somewhat special and not all kinds of paths to or from
supply widgets make sense. This patch adds a few sanity checks that errors
out during the path instantiation for those invalid paths. This will prevent
drivers to depend on weird behavior resulting from such paths as well as
will allow the DAPM algorithms to assume that they never see such paths.

This patch adds checks for the following three invalid types of paths:
	* A path with a non-supply widget as a source connected to a supply
	  widget as a sink. Such a path has no effect on either of the two
	  connected widgets.
	* Paths with a connected() callback that have a non-supply widget as the
	  source. The DAPM algorithm only uses the conneceted() callback for
	  supply widget power checks. And since it prevents caching of the DAPM
	  state there is no intention to make it more generic as it has
	  negative performance implications.
	* Paths which connect a supply to a mixer or mux via a control. Controls
	  are only meant to affect the routing of audio data.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1
---
 sound/soc/soc-dapm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ffcda7e..8e26c2b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2194,6 +2194,27 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_path *path;
 	int ret;
 
+	if (wsink->is_supply && !wsource->is_supply) {
+		dev_err(dapm->dev,
+			"Connecting non-supply widget to supply widget is not supported (%s -> %s)\n",
+			wsource->name, wsink->name);
+		return -EINVAL;
+	}
+
+	if (connected && !wsource->is_supply) {
+		dev_err(dapm->dev,
+			"connected() callback only supported for supply widgets (%s -> %s)\n",
+			wsource->name, wsink->name);
+		return -EINVAL;
+	}
+
+	if (wsource->is_supply && control) {
+		dev_err(dapm->dev,
+			"Conditional paths are not supported for supply widgets (%s -> [%s] -> %s)\n",
+			wsource->name, control, wsink->name);
+		return -EINVAL;
+	}
+
 	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
-- 
1.8.0
