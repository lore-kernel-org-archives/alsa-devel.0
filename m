From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] ASoC: xlnx: Grammar s/the the/the/
Date: Tue, 18 Dec 2018 14:47:43 +0100
Message-ID: <20181218134743.13692-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [195.130.132.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3022677C8
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 14:47:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, Jiri Kosina <trivial@kernel.org>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Fixes: 33f8db9a89200c18 ("ASoC: xlnx: enable i2s driver build")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/xilinx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 25e287feb58c33e8..723a583a8d570f62 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -1,5 +1,5 @@
 config SND_SOC_XILINX_I2S
-	tristate "Audio support for the the Xilinx I2S"
+	tristate "Audio support for the Xilinx I2S"
 	help
 	  Select this option to enable Xilinx I2S Audio. This enables
 	  I2S playback and capture using xilinx soft IP. In transmitter
-- 
2.17.1
