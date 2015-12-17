From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Mimic legacy behaviour of
	reading controls when DSP is on
Date: Thu, 17 Dec 2015 10:05:59 +0000
Message-ID: <1450346759-7011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 684C9265522
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 11:06:01 +0100 (CET)
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

Older firmwares don't specify access flags for the controls,
unfortunately the usage of some of these firmware relies on being able
to read back values from the DSP. The current control code will only do
this for volatile controls. This patch will read the control from the
hardware if no flags are specified and the control is currently
enabled, which should cover these legacy use-cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b083642..d1e0826 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -666,6 +666,9 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 		else
 			ret = -EPERM;
 	} else {
+		if (!ctl->flags && ctl->enabled)
+			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
+
 		memcpy(p, ctl->cache, ctl->len);
 	}
 
-- 
2.1.4
