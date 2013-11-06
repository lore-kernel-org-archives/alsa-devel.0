From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 9/9] ASoC: Replace BUG() with WARN()
Date: Wed,  6 Nov 2013 11:07:19 +0100
Message-ID: <1383732439-31441-10-git-send-email-tiwai@suse.de>
References: <1383732439-31441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D97FA261643
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:07:22 +0100 (CET)
In-Reply-To: <1383732439-31441-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG() used in the driver is just to spit the stack trace on buggy
points, not really needed to stop the whole operation.  For that
purpose, it'd be more convenient to use WARN() instead with more
error information.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-cache.c | 6 ++++--
 sound/soc/soc-dapm.c  | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 1b6663f45b34..375dc6dfba4e 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -36,7 +36,8 @@ static bool snd_soc_set_cache_val(void *base, unsigned int idx,
 		break;
 	}
 	default:
-		BUG();
+		WARN(1, "Invalid word_size %d\n", word_size);
+		break;
 	}
 	return false;
 }
@@ -57,7 +58,8 @@ static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
 		return cache[idx];
 	}
 	default:
-		BUG();
+		WARN(1, "Invalid word_size %d\n", word_size);
+		break;
 	}
 	/* unreachable */
 	return -1;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c89bbe5a65e7..59ad2025370a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1427,7 +1427,7 @@ static void dapm_seq_check_event(struct snd_soc_card *card,
 		power = 0;
 		break;
 	default:
-		BUG();
+		WARN(1, "Unknown event %d\n", event);
 		return;
 	}
 
@@ -2027,7 +2027,7 @@ static ssize_t dapm_bias_read_file(struct file *file, char __user *user_buf,
 		level = "Off\n";
 		break;
 	default:
-		BUG();
+		WARN(1, "Unknown bias_level %d\n", dapm->bias_level);
 		level = "Unknown\n";
 		break;
 	}
@@ -3452,7 +3452,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	default:
-		BUG();
+		WARN(1, "Unknown event %d\n", event);
 		return -EINVAL;
 	}
 
-- 
1.8.4.2
