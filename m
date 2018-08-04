From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 12/12] ASoC: wm8903: use true and false for
	boolean values
Date: Sat, 4 Aug 2018 16:56:02 -0500
Message-ID: <a5b8afe476543dc45d3049b72b5dc718fbe1a010.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com
 [192.185.47.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 009C72677CE
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2018 23:56:04 +0200 (CEST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway20.websitewelcome.com (Postfix) with ESMTP id 31B33400C5D2B
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2018 16:56:04 -0500 (CDT)
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
 sound/soc/codecs/wm8903.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 7b8b6ef..6cb3c15 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -251,10 +251,10 @@ static bool wm8903_volatile_register(struct device *dev, unsigned int reg)
 	case WM8903_DC_SERVO_READBACK_2:
 	case WM8903_DC_SERVO_READBACK_3:
 	case WM8903_DC_SERVO_READBACK_4:
-		return 1;
+		return true;
 
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4
