From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: rme9652: Use common code in
 hdsp_get_iobox_version()
Date: Tue, 5 Sep 2017 22:36:17 +0200
Message-ID: <3ec86adc-18bf-b3f9-341b-9d0ae70256a8@users.sourceforge.net>
References: <9832906e-3b04-b708-2c26-4755e0beb811@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 8678B266BCF
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 22:36:55 +0200 (CEST)
In-Reply-To: <9832906e-3b04-b708-2c26-4755e0beb811@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Sep 2017 22:08:30 +0200

Add a jump target so that a bit of common code can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdsp.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 0ff41f9ab434..9f0f73875f01 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -793,11 +793,8 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 
 		hdsp_write(hdsp, HDSP_control2Reg, HDSP_S200 | HDSP_PROGRAM);
 		hdsp_write (hdsp, HDSP_fifoData, 0);
-		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0) {
-			hdsp->io_type = Multiface;
-			dev_info(hdsp->card->dev, "Multiface found\n");
-			return 0;
-		}
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0)
+			goto set_multi;
 
 		hdsp_write(hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 		hdsp_write(hdsp, HDSP_fifoData, 0);
@@ -810,20 +807,14 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 		hdsp_write(hdsp, HDSP_control2Reg, HDSP_S300);
 		hdsp_write(hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 		hdsp_write(hdsp, HDSP_fifoData, 0);
-		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) == 0) {
-			hdsp->io_type = Multiface;
-			dev_info(hdsp->card->dev, "Multiface found\n");
-			return 0;
-		}
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) == 0)
+			goto set_multi;
 
 		hdsp_write(hdsp, HDSP_control2Reg, HDSP_S300);
 		hdsp_write(hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 		hdsp_write(hdsp, HDSP_fifoData, 0);
-		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0) {
-			hdsp->io_type = Multiface;
-			dev_info(hdsp->card->dev, "Multiface found\n");
-			return 0;
-		}
+		if (hdsp_fifo_wait(hdsp, 0, HDSP_SHORT_WAIT) < 0)
+			goto set_multi;
 
 		hdsp->io_type = RPM;
 		dev_info(hdsp->card->dev, "RPM found\n");
@@ -838,6 +829,11 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 			hdsp->io_type = Digiface;
 	}
 	return 0;
+
+set_multi:
+	hdsp->io_type = Multiface;
+	dev_info(hdsp->card->dev, "Multiface found\n");
+	return 0;
 }
 
 
-- 
2.14.1
