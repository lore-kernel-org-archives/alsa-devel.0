From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: rsnd: tidyup for SSIU subnode
Date: Mon, 26 Nov 2018 01:17:01 +0000
Message-ID: <87in0k3aud.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400090.outbound.protection.outlook.com [40.107.140.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CE602679A7
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 02:17:08 +0100 (CET)
Content-Language: en-US
Content-ID: <DF2679DCA750CE4EB5EA8801DF9FBF4F@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit da48a6eb82ea2 ("ASoC: rsnd: add SSIU BUSIF support for
Document") updated Documentation for SSIU, but 1) we want to
keep old/deprecated DMA description, 2) it is missing SSIU
subnode properties. This patch tidyup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 47dc819..4d19d2b 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -327,8 +327,13 @@ SSI subnode properties:
 - no-busif			: BUSIF is not ussed when [mem -> SSI] via DMA case
 - dma				: Should contain Audio DMAC entry
 - dma-names			: SSI  case "rx"  (=playback), "tx"  (=capture)
+				  Deprecated: see SSIU subnode properties
 				  SSIU case "rxu" (=playback), "txu" (=capture)
 
+SSIU subnode properties:
+- dma				: Should contain Audio DMAC entry
+- dma-names			: "rx" (=playback), "tx" (=capture)
+
 SRC subnode properties:
 - dma				: Should contain Audio DMAC entry
 - dma-names			: "rx" (=playback), "tx" (=capture)
-- 
2.7.4
