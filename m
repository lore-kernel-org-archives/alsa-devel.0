From: John Hsu <supercraig0719@gmail.com>
Subject: [PATCH] ASoC: nau8825: devicetree for crosstalk bypass
Date: Mon, 26 Jun 2017 14:53:48 +0800
Message-ID: <1498460028-12314-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58D0D266819
 for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2017 08:54:03 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id s66so16973304pfs.2
 for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2017 23:54:02 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, John Hsu <supercraig0719@gmail.com>, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Update devicetree document for crosstalk function bypass.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
---
 Documentation/devicetree/bindings/sound/nau8825.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index d337423..bf4451b 100644
--- a/Documentation/devicetree/bindings/sound/nau8825.txt
+++ b/Documentation/devicetree/bindings/sound/nau8825.txt
@@ -69,6 +69,8 @@ Optional properties:
   - nuvoton,jack-insert-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
   - nuvoton,jack-eject-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
 
+  - nuvoton,crosstalk-bypass: make crosstalk function bypass if set 1.
+
   - clocks: list of phandle and clock specifier pairs according to common clock bindings for the
       clocks described in clock-names
   - clock-names: should include "mclk" for the MCLK master clock
@@ -96,6 +98,7 @@ Example:
       nuvoton,short-key-debounce = <2>;
       nuvoton,jack-insert-debounce = <7>;
       nuvoton,jack-eject-debounce = <7>;
+      nuvoton,crosstalk-bypass = <1>;
 
       clock-names = "mclk";
       clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
-- 
2.6.4
