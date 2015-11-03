From: JongHo Kim <furmuwon@gmail.com>
Subject: [PATCH] ASoC: wm8960: Fix the Input PGA Mute switch
Date: Tue,  3 Nov 2015 11:06:32 +0900
Message-ID: <1446516392-68653-1-git-send-email-furmuwon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 155A0264F22
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 03:07:29 +0100 (CET)
Received: by pasz6 with SMTP id z6so3396065pas.2
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 18:07:28 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, JongHo Kim <furmuwon@gmail.com>
List-Id: alsa-devel@alsa-project.org

Change the xinvert value from 0 to 1 on the "Capture Switch" control
WM8960 datasheet is shown as follows:
Bit 7 at 00h and 01h register address
1 : Enable Mute, 0 : Disable Mute

Signed-off-by: JongHo Kim <furmuwon@gmail.com>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 0563753..5380798 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -229,7 +229,7 @@ SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
 SOC_DOUBLE_R("Capture Volume ZC Switch", WM8960_LINVOL, WM8960_RINVOL,
 	6, 1, 0),
 SOC_DOUBLE_R("Capture Switch", WM8960_LINVOL, WM8960_RINVOL,
-	7, 1, 0),
+	7, 1, 1),
 
 SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
 	       WM8960_INBMIX1, 4, 7, 0, lineinboost_tlv),
-- 
1.9.1
