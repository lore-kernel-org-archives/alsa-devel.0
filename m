From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Add missing mutex unlock
Date: Fri,  8 May 2015 10:50:10 +0100
Message-ID: <1431078610-4150-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B8F6265AD2
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 11:59:08 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, dan.carpenter@oracle.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The is a missing mutex unlock on the error path in
snd_soc_dapm_get_enum_double. This was introduced in commit
561ed680b764 ("ASoC: dapm: Add support for autodisable mux controls").
This patch adds the missing unlock.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ea3348e..6374852 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3075,8 +3075,10 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	if (e->reg != SND_SOC_NOPM && dapm_kcontrol_is_powered(kcontrol)) {
 		int ret = soc_dapm_read(dapm, e->reg, &reg_val);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&card->dapm_mutex);
 			return ret;
+		}
 	} else {
 		reg_val = dapm_kcontrol_get_value(kcontrol);
 	}
-- 
1.7.2.5
