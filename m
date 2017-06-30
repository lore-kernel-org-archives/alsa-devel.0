From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ALSA: x86: fix error return code in hdmi_lpe_audio_probe()
Date: Fri, 30 Jun 2017 14:59:01 -0500
Message-ID: <20170630195901.GA5751@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

platform_get_irq() returns an error code, but the sata_rcar driver
ignores it and always returns -ENODEV. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly. Also,
notice that platform_get_irq() no longer returns 0 on error.

Print and propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/x86/intel_hdmi_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c19efc9..a095150 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1758,8 +1758,8 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not get irq resource\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "Could not get irq resource: %d\n", irq);
+		return irq;
 	}
 
 	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.5.0
