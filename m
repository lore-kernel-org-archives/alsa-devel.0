From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 08/12] ASoC: alc5632: Fix I2S digital interface
	power for recording
Date: Sat, 11 Feb 2012 23:10:41 +0200
Message-ID: <1328994645-8237-9-git-send-email-leon@leon.nu>
References: <1328994645-8237-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E36BA103A3B
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:11:22 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1252422eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:11:22 -0800 (PST)
In-Reply-To: <1328994645-8237-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

Fix I2S digital interface power for recording.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 30b8f80..1fdec23 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -356,7 +356,7 @@ SND_SOC_DAPM_MUX("SpeakerOut N Mux", SND_SOC_NOPM, 0, 0,
 	&alc5632_spkoutn_mux_controls),
 SND_SOC_DAPM_MUX("ADCR Mux", SND_SOC_NOPM, 0, 0,
 	&alc5632_adcr_func_controls),
-SND_SOC_DAPM_MUX("I2SOut Mux", SND_SOC_NOPM, 0, 0,
+SND_SOC_DAPM_MUX("I2SOut Mux", ALC5632_PWR_MANAG_ADD1, 11, 0,
 	&alc5632_i2s_out_controls),
 
 /* output mixers */
-- 
1.7.3.4
