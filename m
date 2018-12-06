From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: ak4104: use
	'reset-gpios' rather than 'reset-gpio'
Date: Thu,  6 Dec 2018 13:24:56 +0100
Message-ID: <20181206122457.28269-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id C50A7267C75
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 13:25:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Bindings should use 'reset-gpios', not 'reset-gpio'. The driver needs to
switch to the gpiod consume API to handle this correctly.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/sound/ak4104.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
index deca5e18f304..ae5f7f057dc3 100644
--- a/Documentation/devicetree/bindings/sound/ak4104.txt
+++ b/Documentation/devicetree/bindings/sound/ak4104.txt
@@ -12,8 +12,8 @@ Required properties:
 
 Optional properties:
 
-  - reset-gpio : a GPIO spec for the reset pin. If specified, it will be
-		 deasserted before communication to the device starts.
+  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
+		  deasserted before communication to the device starts.
 
 Example:
 
-- 
2.19.2
