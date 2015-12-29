From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Use nested lock for
	snd_soc_dapm_mutex_lock
Date: Tue, 29 Dec 2015 16:25:13 +0000
Message-ID: <1451406314-13973-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A5B3D26586C
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 17:25:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_mutex_lock currently uses the un-nested call which can
cause lockdep warnings when called from control handlers (a relatively
common usage) and using modules. As creating the control causes a
potential mutex inversion with the handler, creating the control will
take the controls_rwsem under the dapm_mutex and accessing the control
will take the dapm_mutex under controls_rwsem.

All the users look like they want to be using the runtime class of the
lock anyway, so this patch just changes snd_soc_dapm_mutex_lock to use
the nested call, with the SND_SOC_DAPM_CLASS_RUNTIME class.

Fixes: f6d5e586b416 ("ASoC: dapm: Add helpers to lock/unlock DAPM mutex")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a2deeb9..aae55d0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1687,7 +1687,7 @@ extern const struct dev_pm_ops snd_soc_pm_ops;
 /* Helper functions */
 static inline void snd_soc_dapm_mutex_lock(struct snd_soc_dapm_context *dapm)
 {
-	mutex_lock(&dapm->card->dapm_mutex);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 }
 
 static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
-- 
2.1.4
