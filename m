From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v8 10/11] ASoC: fsl: Move fsl-ssi binding doc
	to sound/
Date: Sun, 16 Jun 2013 15:25:16 +0200
Message-ID: <1371389117-19729-11-git-send-email-mpa@pengutronix.de>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id BD4852610D3
 for <alsa-devel@alsa-project.org>; Sun, 16 Jun 2013 15:26:50 +0200 (CEST)
In-Reply-To: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

fsl-ssi was located in powerpc/fsl/ssi.txt. This is no powerpc specific
device, so it should be moved to sound/ as it connects to differen audio
codecs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt}        | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} (100%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/ssi.txt
rename to Documentation/devicetree/bindings/sound/fsl,ssi.txt
-- 
1.8.2.1
