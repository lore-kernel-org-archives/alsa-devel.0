From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: twl6040: Remove redundant semicolon
Date: Fri, 13 Sep 2013 16:16:17 +0530
Message-ID: <1379069177-1159-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 888EB2608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 13:04:27 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id z10so1112494pdj.17
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 04:04:26 -0700 (PDT)
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
Cc: sachin.kamat@linaro.org, misael.lopez@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Redundant semicolon removed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/twl6040.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 3c79dbb..35059a2 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -246,7 +246,7 @@ static bool twl6040_is_path_unmuted(struct snd_soc_codec *codec,
 		return priv->dl2_unmuted;
 	default:
 		return 1;
-	};
+	}
 }
 
 /*
@@ -1100,7 +1100,7 @@ static void twl6040_mute_path(struct snd_soc_codec *codec, enum twl6040_dai_id i
 		break;
 	default:
 		break;
-	};
+	}
 }
 
 static int twl6040_digital_mute(struct snd_soc_dai *dai, int mute)
-- 
1.7.9.5
