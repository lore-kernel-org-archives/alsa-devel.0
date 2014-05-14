From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/6] ASoC: ak4642: Add ALC controls
Date: Wed, 14 May 2014 09:37:34 +0200
Message-ID: <1400053058-1115-3-git-send-email-s.hauer@pengutronix.de>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 77DA9261A01
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:37:42 +0200 (CEST)
In-Reply-To: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

ALC and ALC Zero crossing detection has been enabled unconditionally.
Add controls for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/ak4642.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 3373a9c..90d2d93 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -148,6 +148,8 @@ static const struct snd_kcontrol_new ak4642_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("Digital Playback Volume", L_DVC, R_DVC,
 			 0, 0xFF, 1, out_tlv),
+	SOC_SINGLE("ALC Capture Switch", ALC_CTL1, 5, 1, 0),
+	SOC_SINGLE("ALC Capture ZC Switch", ALC_CTL1, 4, 1, 1),
 };
 
 static const struct snd_kcontrol_new ak4642_headphone_control =
-- 
2.0.0.rc0
