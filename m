From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v2 2/2] devicetree: sound: Fix fsl-asoc-card identation
Date: Fri, 29 Jan 2016 11:01:01 +0000
Message-ID: <1454065261-9522-2-git-send-email-eu@felipetonello.com>
References: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index ceaef5126989..16b254b04f8c 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -43,7 +43,7 @@ Required properties:
 
   - audio-cpu		: The phandle of an CPU DAI controller
 
-  - audio-codec		: The phandle of an audio codec
+  - audio-codec	: The phandle of an audio codec
 
   - audio-routing	: A list of the connections between audio components.
 			  Each entry is a pair of strings, the first being the
-- 
2.7.0
