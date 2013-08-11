From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: cs4271: fix dapm routing table
Date: Sun, 11 Aug 2013 18:06:59 +0200
Message-ID: <1376237219-31503-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C02C2607B7
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 18:07:08 +0200 (CEST)
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
Cc: broonie@kernel.org, subaparts@yandex.ru, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The widgets are names "AINA" and "AINB", which is also what the
datasheets calls the terminals. Fix the routing table to match these
names.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/cs4271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 35a6a67..a20f1bb 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -184,8 +184,8 @@ SND_SOC_DAPM_OUTPUT("AOUTB-"),
 };
 
 static const struct snd_soc_dapm_route cs4271_dapm_routes[] = {
-	{ "Capture", NULL, "AINL" },
-	{ "Capture", NULL, "AINR" },
+	{ "Capture", NULL, "AINA" },
+	{ "Capture", NULL, "AINB" },
 
 	{ "AOUTA+", NULL, "Playback" },
 	{ "AOUTA-", NULL, "Playback" },
-- 
1.8.3.1
