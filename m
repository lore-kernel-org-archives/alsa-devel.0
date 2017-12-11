From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] ASoC: tfa9879: add DT bindings to
	MAINTAINERS
Date: Mon, 11 Dec 2017 15:26:15 +0100
Message-ID: <20171211142615.11440-3-peda@axentia.se>
References: <20171211142615.11440-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00105.outbound.protection.outlook.com [40.107.0.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E19B266E93
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 15:26:33 +0100 (CET)
In-Reply-To: <20171211142615.11440-1-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Let's keep maintenance of the driver and the bindings in one place.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4fdcb12616c..e7c2ca89fec4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9804,6 +9804,7 @@ NXP TFA9879 DRIVER
 M:	Peter Rosin <peda@axentia.se>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/tfa9879.txt
 F:	sound/soc/codecs/tfa9879*
 
 NXP-NCI NFC DRIVER
-- 
2.11.0
