From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm_adsp: Explicitly set the control
	access flags in all cases
Date: Fri, 19 Feb 2016 14:44:42 +0000
Message-ID: <1455893084-4556-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CFBC266A9B
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 15:44:55 +0100 (CET)
In-Reply-To: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

In the case where the firmware does not tell us the access flags for the
control, we let ALSA select a default (READWRITE). But really we should
be applying the volatile flag in this case, as we will read the control
from the DSP if it is on in this case. This patch explicitly sets the
access flags in all cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 00a7d68..c97b3a1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -877,6 +877,9 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_READ;
 		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
 			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+	} else {
+		kcontrol->access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
 	}
 
 	ret = snd_soc_add_card_controls(dsp->card,
-- 
2.1.4
