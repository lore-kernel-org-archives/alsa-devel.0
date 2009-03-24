From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH 2/7] snd-atmel-ac97c: remove dead break
	statements after return in switch case
Date: Tue, 24 Mar 2009 13:47:45 +0100
Message-ID: <1237898870-15780-3-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1237898870-15780-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 306E010382E
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:47:53 +0100 (CET)
In-Reply-To: <1237898870-15780-2-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index dd72e00..21be9c9 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -312,7 +312,6 @@ static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
 	default:
 		/* TODO: support more than two channels */
 		return -EINVAL;
-		break;
 	}
 	ac97c_writel(chip, OCA, word);
 
@@ -374,7 +373,6 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 	default:
 		/* TODO: support more than two channels */
 		return -EINVAL;
-		break;
 	}
 	ac97c_writel(chip, ICA, word);
 
-- 
1.5.6.3
