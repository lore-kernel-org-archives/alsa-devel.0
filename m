From: andy-alsa@ultra-premium.com
Subject: [PATCH 1/2] ALSA: ca0106 - add Sound Blaster 5.1vx
	info.
Date: Tue, 21 Sep 2010 23:51:18 +1000
Message-ID: <1285077079-5519-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D09D24141
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:51:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-preoject.org
Cc: alsa-devel@alsa-project.org, Andy Owen <andy-alsa@ultra-premium.com>
List-Id: alsa-devel@alsa-project.org

From: Andy Owen <andy-alsa@ultra-premium.com>

---
 sound/pci/ca0106/ca0106_main.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 8e69620..6dc9a5d 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -239,6 +239,16 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	   .gpio_type = 1,
 	   .i2c_adc = 1,
 	   .spi_dac = 1 } ,
+	/* Sound Blaster 5.1vx
+	 * Tested: Playback on front, rear, center/lfe speakers
+	 * Not-Tested: Capture
+	 */
+	{ .serial = 0x10041102,
+	  .name   = "Sound Blaster 5.1vx [SB1070]",
+	  .gpio_type = 1,
+	  .i2c_adc = 0,
+	  .spi_dac = 1
+	 } ,
 	 /* MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC97 */
 	 /* SB0438
 	  * CTRL:CA0106-DAT
-- 
1.7.0.4
