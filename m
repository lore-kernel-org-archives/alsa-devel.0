From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ASoC: make wm8782 codec selectable in
	Kconfig
Date: Mon, 21 May 2018 23:54:50 +0200
Message-ID: <20180521215450.30557-2-daniel@zonque.org>
References: <20180521215450.30557-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 94CB726762F
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 23:55:00 +0200 (CEST)
In-Reply-To: <20180521215450.30557-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

FOr platforms that use the simple-card driver, the codec cannot be selected
through 'select' magic in Kconfig. So turn this into a real config option.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9548f63ca531..c389173a34d3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1111,7 +1111,7 @@ config SND_SOC_WM8776
 	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8782
-	tristate
+	tristate "Wolfson Microelectronics WM8782 ADC"
 
 config SND_SOC_WM8804
 	tristate
-- 
2.14.3
