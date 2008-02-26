From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] Report errors from
	snd_soc_dapm_set_endpoint()
Date: Tue, 26 Feb 2008 11:42:55 +0000
Message-ID: <1204026175-13316-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <>
	<1204026175-13316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1204026175-13316-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C9252463A
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 12:42:56 +0100 (CET)
In-Reply-To: <1204026175-13316-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 620d7ea..abac684 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1334,10 +1334,11 @@ int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
 	list_for_each_entry(w, &codec->dapm_widgets, list) {
 		if (!strcmp(w->name, endpoint)) {
 			w->connected = status;
+			return 0;
 		}
 	}
 
-	return 0;
+	return -ENODEV;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_set_endpoint);
 
-- 
1.5.4.3
