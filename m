From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 011/102] ASoC: sta529: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:23 +0100
Message-ID: <1392723148-12597-9-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DE126545D
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/sta529.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 40c07be9b581..f15b0e37274c 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -141,7 +141,7 @@ static const char *pwm_mode_text[] = { "Binary", "Headphone", "Ternary",
 
 static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -9150, 50, 0);
 static const DECLARE_TLV_DB_SCALE(master_vol_tlv, -12750, 50, 0);
-static const SOC_ENUM_SINGLE_DECL(pwm_src, STA529_FFXCFG1, 4, pwm_mode_text);
+static SOC_ENUM_SINGLE_DECL(pwm_src, STA529_FFXCFG1, 4, pwm_mode_text);
 
 static const struct snd_kcontrol_new sta529_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Digital Playback Volume", STA529_LVOL, STA529_RVOL, 0,
-- 
1.8.5.2
