From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 3/6] dt: Add doc for the ZTE HDMI audio
	codec binding
Date: Fri, 29 May 2015 21:31:18 +0800
Message-ID: <1432906281-27698-4-git-send-email-jun.nie@linaro.org>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 90DD22606B7
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:32:01 +0200 (CEST)
Received: by pacux9 with SMTP id ux9so17966677pac.3
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:32:00 -0700 (PDT)
In-Reply-To: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds the devicetree documentation for the ZTE
zx296702 HDMI audio codec binding.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-hdmi.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-hdmi.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-hdmi.txt b/Documentation/devicetree/bindings/sound/zte,zx-hdmi.txt
new file mode 100644
index 0000000..624d75d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-hdmi.txt
@@ -0,0 +1,10 @@
+ZTE HDMI ASoC codec binding
+
+Required properties:
+ - compatible : Must be "zte,hdmi-audio"
+
+Example:
+	acodec: acodec {
+		#sound-dai-cells = <0>;
+		compatible = "zte,hdmi-audio";
+	};
-- 
1.9.1
