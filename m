From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH] ASoC: Add device tree binding description for
	pcm030-audio-fabric
Date: Mon, 24 Sep 2012 18:19:54 -0400
Message-ID: <1348525194-14687-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A9602616D7
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 00:20:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 .../bindings/sound/pcm030-audio-fabric.txt         |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm030-audio-fabric.txt

diff --git a/Documentation/devicetree/bindings/sound/pcm030-audio-fabric.txt b/Documentation/devicetree/bindings/sound/pcm030-audio-fabric.txt
new file mode 100644
index 0000000..6eacf23
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm030-audio-fabric.txt
@@ -0,0 +1,12 @@
+Phytec pcm030 audio
+
+Required properties:
+- compatible : "phytec,pcm030-audio-fabric"
+- asoc-platform : The mpc5200 controller's phandle for the ac97 controller
+
+Example:
+
+sound {
+	compatible = "phytec,pcm030-audio-fabric";
+	asoc-platform = <&audioplatform>;
+};
-- 
1.7.2.5
