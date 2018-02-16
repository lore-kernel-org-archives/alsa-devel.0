From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: DA7219: Exposes clock enable as a mixer
	setting
Date: Fri, 16 Feb 2018 13:11:14 +0530
Message-ID: <1518766875-15164-3-git-send-email-akshu.agrawal@amd.com>
References: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0059.outbound.protection.outlook.com [104.47.40.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 539A8267D81
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:54:45 +0100 (CET)
In-Reply-To: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

This is required for designs which uses da7219 in master mode
and same clks are shared with other codecs. We need to enable
and disable the clk during playback and capture on other codecs.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/codecs/da7219.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5e043d0..61ed8be 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -672,6 +672,11 @@ static int da7219_tonegen_freq_put(struct snd_kcontrol *kcontrol,
 	SOC_DOUBLE_R("Headphone ZC Gain Switch", DA7219_HP_L_CTRL,
 		     DA7219_HP_R_CTRL, DA7219_HP_L_AMP_ZC_EN_SHIFT,
 		     DA7219_SWITCH_EN_MAX, DA7219_NO_INVERT),
+
+	/* Clock Enable */
+	SOC_SINGLE("Clock Enable", DA7219_DAI_CLK_MODE,
+		   DA7219_DAI_CLK_EN_SHIFT, DA7219_SWITCH_EN_MAX,
+		   DA7219_NO_INVERT),
 };
 
 
-- 
1.9.1
