From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: core: use component driver name as
	component name
Date: Wed, 29 May 2019 14:22:14 +0800
Message-ID: <20190529062214.225874-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E323F8072E
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 08:22:44 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id h83so1159249ybh.15
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 23:22:44 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

fmt_single_name() uses device name to determine component name.  If
multiple components bind to the same device, the debugfs creation in
soc_init_component_debugfs() would fail due to duplicated entity
names.

Name provided by component driver is unique enough to represent each
component.  Use component driver name as the component name to avoid
name duplication.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Hi,

We got "Failed to create component debugfs directory" in our environment.
But the patch does not resolve the issue.
(https://mailman.alsa-project.org/pipermail/alsa-devel/2018-February/132391.html)

The entity name duplicated when creating the debugfs directory, because
there is a device registered 2 components in mt8183_afe_pcm_dev_probe()
in sound/soc/mediatek/mt8183/mt8183-afe-pcm.c.

 sound/soc/soc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7abb017a83f3..2d3520fca613 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3113,7 +3113,10 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 {
 	struct snd_soc_dapm_context *dapm;
 
-	component->name = fmt_single_name(dev, &component->id);
+	if (driver->name)
+		component->name = kstrdup(driver->name, GFP_KERNEL);
+	else
+		component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.22.0.rc1.257.g3120a18244-goog
