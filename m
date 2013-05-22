From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 4/4] cs42l52: fix master playback mute mask.
Date: Wed, 22 May 2013 19:19:27 +0200
Message-ID: <1369243167-28700-5-git-send-email-nschichan@freebox.fr>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id D22FC2610A7
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:20:09 +0200 (CEST)
In-Reply-To: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org

The mask should define the bits to change in the register, not the
bits to preserve.

This fixes the inadvertent changes of the "Headphone Analog Gain"
value during mute/unmute.

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 sound/soc/codecs/cs42l52.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.h b/sound/soc/codecs/cs42l52.h
index 60985c0..4277012 100644
--- a/sound/soc/codecs/cs42l52.h
+++ b/sound/soc/codecs/cs42l52.h
@@ -157,7 +157,7 @@
 #define CS42L52_PB_CTL1_INV_PCMA		(1 << 2)
 #define CS42L52_PB_CTL1_MSTB_MUTE		(1 << 1)
 #define CS42L52_PB_CTL1_MSTA_MUTE		(1 << 0)
-#define CS42L52_PB_CTL1_MUTE_MASK		0xFFFD
+#define CS42L52_PB_CTL1_MUTE_MASK		0x03
 #define CS42L52_PB_CTL1_MUTE			3
 #define CS42L52_PB_CTL1_UNMUTE			0
 
-- 
1.7.10.4
