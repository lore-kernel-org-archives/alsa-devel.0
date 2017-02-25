From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: ux500: Remove unuseful break after return
Date: Sat, 25 Feb 2017 21:41:25 +0200
Message-ID: <1488051685-8958-1-git-send-email-codrut.cristian.grosu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/ux500/ux500_msp_i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 959d7b4..bd5266a 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -604,7 +604,6 @@ int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}

 	return 0;
--
1.9.1
