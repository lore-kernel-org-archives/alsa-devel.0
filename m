From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Ensure DSP controls are
	always persistent
Date: Mon, 16 Feb 2015 15:25:48 +0000
Message-ID: <1424100349-10520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB33826069A
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:28:08 +0100 (CET)
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
Cc: nikesh.oswal@wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>

Currently DSP controls are persistent (across DSP On/Off) only
if they were set whilst the DSP is off. This change makes the
controls persistent irrespective of when they are set.

Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ff67b33..185ee85 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -420,10 +420,9 @@ static int wm_coeff_put(struct snd_kcontrol *kcontrol,
 
 	memcpy(ctl->cache, p, ctl->len);
 
-	if (!ctl->enabled) {
-		ctl->set = 1;
+	ctl->set = 1;
+	if (!ctl->enabled)
 		return 0;
-	}
 
 	return wm_coeff_write_control(kcontrol, p, ctl->len);
 }
-- 
1.7.2.5
