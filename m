From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 19/20] ASoC: rename sgtl5000 device tree
	binding document
Date: Sat,  3 Mar 2012 23:20:00 +0800
Message-ID: <1330788001-10158-20-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF8B1041DF
	for <alsa-devel@alsa-project.org>; Sat,  3 Mar 2012 16:07:56 +0100 (CET)
Received: by mail-iy0-f179.google.com with SMTP id h37so3836616iak.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Mar 2012 07:07:56 -0800 (PST)
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

It moves and renames sgtl5000 device tree binding document to make
it aligned with other codecs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt}  |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/sound/{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt} (100%)

diff --git a/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
rename to Documentation/devicetree/bindings/sound/sgtl5000.txt
-- 
1.7.5.4
