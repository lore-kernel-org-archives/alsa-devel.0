From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] ASoC: Rename ALC5632 MICBIAS to common name
	convention.
Date: Mon, 12 Dec 2011 21:43:45 +0200
Message-ID: <1323719025-18304-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C78212435E
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 20:44:08 +0100 (CET)
Received: by eekd17 with SMTP id d17so2869412eek.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 11:44:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 08613c7..390e437 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -379,8 +379,8 @@ SND_SOC_DAPM_PGA("MIC1 PGA", ALC5632_PWR_MANAG_ADD3, 3, 0, NULL, 0),
 SND_SOC_DAPM_PGA("MIC2 PGA", ALC5632_PWR_MANAG_ADD3, 2, 0, NULL, 0),
 SND_SOC_DAPM_PGA("MIC1 Pre Amp", ALC5632_PWR_MANAG_ADD3, 1, 0, NULL, 0),
 SND_SOC_DAPM_PGA("MIC2 Pre Amp", ALC5632_PWR_MANAG_ADD3, 0, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("Mic Bias1", ALC5632_PWR_MANAG_ADD1, 3, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("Mic Bias2", ALC5632_PWR_MANAG_ADD1, 2, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS1", ALC5632_PWR_MANAG_ADD1, 3, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS2", ALC5632_PWR_MANAG_ADD1, 2, 0, NULL, 0),
 
 SND_SOC_DAPM_PGA_E("D Amp", ALC5632_PWR_MANAG_ADD2, 14, 0, NULL, 0,
 	amp_mixer_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-- 
1.7.3.4
