From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/3] ASoC: core: fix use after free in
	snd_soc_remove_platform()
Date: Tue,  7 Oct 2014 13:41:23 +0200
Message-ID: <1412682085-5217-2-git-send-email-daniel@zonque.org>
References: <1412682085-5217-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id DA669260452
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 13:41:31 +0200 (CEST)
In-Reply-To: <1412682085-5217-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Coverity spotted an use-after-free condition in snd_soc_remove_platform().
Fix this by moving snd_soc_component_cleanup() after the debug print
statement which uses the component's string.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3d8cff6..4c8f8a2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4192,10 +4192,10 @@ void snd_soc_remove_platform(struct snd_soc_platform *platform)
 	snd_soc_component_del_unlocked(&platform->component);
 	mutex_unlock(&client_mutex);
 
-	snd_soc_component_cleanup(&platform->component);
-
 	dev_dbg(platform->dev, "ASoC: Unregistered platform '%s'\n",
 		platform->component.name);
+
+	snd_soc_component_cleanup(&platform->component);
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_platform);
 
-- 
2.1.0
