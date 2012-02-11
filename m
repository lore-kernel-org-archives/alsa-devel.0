From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 03/12] ASoC: alc5632: Add voice DAC playback
	switch
Date: Sat, 11 Feb 2012 23:10:36 +0200
Message-ID: <1328994645-8237-4-git-send-email-leon@leon.nu>
References: <1328994645-8237-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E39701039EE
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:11:13 +0100 (CET)
Received: by eaan11 with SMTP id n11so1204912eaa.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:11:13 -0800 (PST)
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

Add voice DAC playback switch.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index fce5e76..6bb6075 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -176,6 +176,8 @@ static const struct snd_kcontrol_new alc5632_snd_controls[] = {
 			ALC5632_AUX_OUT_VOL, 15, 7, 1, 1),
 	SOC_SINGLE_TLV("Voice DAC Playback Volume",
 			ALC5632_VOICE_DAC_VOL, 0, 63, 0, vdac_tlv),
+	SOC_SINGLE("Voice DAC Playback Switch",
+			ALC5632_VOICE_DAC_VOL, 12, 1, 1),
 	SOC_SINGLE_TLV("Phone Capture Volume",
 			ALC5632_PHONE_IN_VOL, 8, 31, 1, vol_tlv),
 	SOC_DOUBLE_TLV("LineIn Capture Volume",
-- 
1.7.3.4
