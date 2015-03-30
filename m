From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] ASoC: dapm: Remove delayed_work from dapm
	context struct
Date: Mon, 30 Mar 2015 21:04:52 +0200
Message-ID: <1427742293-8588-8-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CDDF2605C0
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:56 +0200 (CEST)
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The delayed_work field in the snd_soc_dapm_context struct is now unused and
can be removed. Removing it reduces the size of the snd_soc_dapm_context
struct by ~50% from 100 bytes to 48 bytes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2e5f0ce..0bc8364 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -588,7 +588,6 @@ struct snd_soc_dapm_update {
 /* DAPM context */
 struct snd_soc_dapm_context {
 	enum snd_soc_bias_level bias_level;
-	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 	/* Go to BIAS_OFF in suspend if the DAPM context is idle */
 	unsigned int suspend_bias_off:1;
-- 
1.8.0
