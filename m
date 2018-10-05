From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 5/5] ASoC: max98988: make it selectable
Date: Fri,  5 Oct 2018 09:58:12 +0200
Message-ID: <20181005075812.13986-6-m.felsch@pengutronix.de>
References: <20181005075812.13986-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 39EBA267903
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 09:58:25 +0200 (CEST)
In-Reply-To: <20181005075812.13986-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Currently the driver will build only if SND_SOC_ALL_CODECS is set.
Adding a Kconfig menu description to build the driver standalone.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efb095dbcd71..b43f85b38e72 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -629,7 +629,7 @@ config SND_SOC_LM49453
 	tristate
 
 config SND_SOC_MAX98088
-       tristate
+	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
 
 config SND_SOC_MAX98090
        tristate
-- 
2.19.0
