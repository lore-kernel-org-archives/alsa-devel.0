From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 06/12] ASoC: wm8996: use true and false for
	boolean values
Date: Sat, 4 Aug 2018 16:52:35 -0500
Message-ID: <d6c8a37703ecad97a48f5ba080ceec38697d100e.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com
 [192.185.51.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 971B92677F8
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2018 23:52:37 +0200 (CEST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway24.websitewelcome.com (Postfix) with ESMTP id 850C11B8B2A
 for <alsa-devel@alsa-project.org>;
 Sat,  4 Aug 2018 16:52:36 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org
Cc: patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8996.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 78a4082..91711f8 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1498,9 +1498,9 @@ static bool wm8996_readable_register(struct device *dev, unsigned int reg)
 	case WM8996_RIGHT_PDM_SPEAKER:
 	case WM8996_PDM_SPEAKER_MUTE_SEQUENCE:
 	case WM8996_PDM_SPEAKER_VOLUME:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -1522,9 +1522,9 @@ static bool wm8996_volatile_register(struct device *dev, unsigned int reg)
 	case WM8996_MIC_DETECT_3:
 	case WM8996_HEADPHONE_DETECT_1:
 	case WM8996_HEADPHONE_DETECT_2:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
