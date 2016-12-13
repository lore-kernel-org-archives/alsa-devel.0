From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: wm8753: Add control to allow swapping
	HiFi DAC channels
Date: Tue, 13 Dec 2016 13:56:19 +0300
Message-ID: <1481626579-23642-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [94.100.177.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DD73261A1A
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 11:56:30 +0100 (CET)
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
Cc: Alexander Shiyan <shc_work@mail.ru>, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch adds a control to allow swapping HiFi DAC Left/Right channels.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/wm8753.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 9bdf544..d05d76e 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -280,6 +280,7 @@ static const DECLARE_TLV_DB_SCALE(voice_mix_tlv, -1200, 300, 0);
 static const DECLARE_TLV_DB_SCALE(pga_tlv, -1725, 75, 0);
 
 static const struct snd_kcontrol_new wm8753_snd_controls[] = {
+SOC_SINGLE("Hi-Fi DAC Left/Right channel Swap", WM8753_HIFI, 5, 1, 0),
 SOC_DOUBLE_R_TLV("PCM Volume", WM8753_LDAC, WM8753_RDAC, 0, 255, 0, dac_tlv),
 
 SOC_DOUBLE_R_TLV("ADC Capture Volume", WM8753_LADC, WM8753_RADC, 0, 255, 0,
@@ -1087,7 +1088,7 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec *codec,
 {
 	u16 ioctl, hifi;
 
-	hifi = snd_soc_read(codec, WM8753_HIFI) & 0x011f;
+	hifi = snd_soc_read(codec, WM8753_HIFI) & 0x013f;
 	ioctl = snd_soc_read(codec, WM8753_IOCTL) & 0x00ae;
 
 	/* set master/slave audio interface */
-- 
2.4.9
