From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: jack: Always update jack state even for
	noop changes
Date: Wed, 25 Jul 2012 22:59:31 +0100
Message-ID: <1343253571-21610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B421265B47
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 23:59:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that DAPM is very cheap for most updates we've no need to avoid trying
to run it so always notify even if we don't think there are any changes.
This avoids potential issues with bootstrapping state like the pin state
or other notifiers when there's nothing in the jack.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-jack.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 9db15ba..e19fd6d 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -83,11 +83,6 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	jack->status &= ~mask;
 	jack->status |= status & mask;
 
-	/* The DAPM sync is expensive enough to be worth skipping.
-	 * However, empty mask means pin synchronization is desired. */
-	if (mask && (jack->status == oldstatus))
-		goto out;
-
 	trace_snd_soc_jack_notify(jack, status);
 
 	list_for_each_entry(pin, &jack->pins, list) {
@@ -109,7 +104,6 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 
 	snd_jack_report(jack->jack, jack->status);
 
-out:
 	mutex_unlock(&jack->mutex);
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_report);
-- 
1.7.10.4
