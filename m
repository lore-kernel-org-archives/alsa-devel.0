From: Matt Reimer <mreimer@sdgsystems.com>
Subject: [PATCH] ALSA: ASoC: Fix WM9713 mic 2 preamp volume
Date: Thu, 15 May 2014 12:50:25 -0700
Message-ID: <1400183425-23628-1-git-send-email-mreimer@sdgsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C637B2625FE
 for <Alsa-devel@alsa-project.org>; Thu, 15 May 2014 21:50:35 +0200 (CEST)
Received: by mail-pa0-f44.google.com with SMTP id ld10so1488524pab.17
 for <Alsa-devel@alsa-project.org>; Thu, 15 May 2014 12:50:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
Cc: Matt Reimer <mreimer@sdgsystems.com>
List-Id: alsa-devel@alsa-project.org

Fix WM9713's mic 2 preamp volume. The previous definition specified
the Mic A pre-amp input select bits (aka "Mic A Source") instead.

Signed-off-by: Matt Reimer <mreimer@sdgsystems.com>
---
 sound/soc/codecs/wm9713.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index acea892..5f69b52 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -134,7 +134,7 @@ SOC_DOUBLE_TLV("PCM Playback Volume", AC97_PHONE, 8, 0, 31, 1, main_tlv),
 SOC_SINGLE_TLV("Mic 1 Volume", AC97_MIC, 8, 31, 1, main_tlv),
 SOC_SINGLE_TLV("Mic 2 Volume", AC97_MIC, 0, 31, 1, main_tlv),
 SOC_SINGLE_TLV("Mic 1 Preamp Volume", AC97_3D_CONTROL, 10, 3, 0, mic_tlv),
-SOC_SINGLE_TLV("Mic 2 Preamp Volume", AC97_3D_CONTROL, 12, 3, 0, mic_tlv),
+SOC_SINGLE_TLV("Mic 2 Preamp Volume", AC97_3D_CONTROL, 8, 3, 0, mic_tlv),
 
 SOC_SINGLE("Mic Boost (+20dB) Switch", AC97_LINE, 5, 1, 0),
 SOC_SINGLE("Mic Headphone Mixer Volume", AC97_LINE, 0, 7, 1),
-- 
1.7.5.4
