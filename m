From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/31] ASoC: Replace BUG() with snd_BUG()
Date: Tue,  5 Nov 2013 18:40:17 +0100
Message-ID: <1383673218-18405-31-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D7E2265281
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG() used in the driver is just to spit the stack trace on buggy
points, not really needed to stop the whole operation.  For that
purpose, it'd be more convenient to use snd_BUG() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-cache.c | 4 ++--
 sound/soc/soc-dapm.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 1b6663f45b34..4737ffcdd589 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -36,7 +36,7 @@ static bool snd_soc_set_cache_val(void *base, unsigned int idx,
 		break;
 	}
 	default:
-		BUG();
+		snd_BUG();
 	}
 	return false;
 }
@@ -57,7 +57,7 @@ static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
 		return cache[idx];
 	}
 	default:
-		BUG();
+		snd_BUG();
 	}
 	/* unreachable */
 	return -1;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c89bbe5a65e7..eedb81ec4db4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1427,7 +1427,7 @@ static void dapm_seq_check_event(struct snd_soc_card *card,
 		power = 0;
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		return;
 	}
 
@@ -2027,7 +2027,7 @@ static ssize_t dapm_bias_read_file(struct file *file, char __user *user_buf,
 		level = "Off\n";
 		break;
 	default:
-		BUG();
+		snd_BUG();
 		level = "Unknown\n";
 		break;
 	}
@@ -3452,7 +3452,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		BUG();
+		snd_BUG();
 		return -EINVAL;
 	}
 
-- 
1.8.4.2
