From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 3/3] dt-bindings: sound: rockchip Fix
	compatible string in example
Date: Tue, 20 Mar 2018 13:03:32 -0300
Message-ID: <20180320160332.13212-4-ezequiel@vanguardiasur.com.ar>
References: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id AC70E2671F9
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:04:35 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id z184so2219079qkc.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 09:04:35 -0700 (PDT)
In-Reply-To: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.co.uk>, kernel@collabora.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Use the correct compatible string in the example devicetree
snippet, which was probably overlooked.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
index 2539e1d68107..e5430d1d34e4 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
@@ -22,7 +22,7 @@ Optionnal properties:
 Example:
 
 sound {
-	compatible = "rockchip,rockchip-audio-es8388";
+	compatible = "rockchip,rk3288-hdmi-analog";
 	rockchip,model = "Analog audio output";
 	rockchip,i2s-controller = <&i2s>;
 	rockchip,audio-codec = <&es8388>;
-- 
2.16.2
