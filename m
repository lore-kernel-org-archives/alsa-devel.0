From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] ALSA: hdsp - poll for iobox
Date: Fri, 20 Feb 2009 19:30:35 +0100
Message-ID: <20090220193035.61928f71@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 593A61037F5
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 19:30:40 +0100 (CET)
Received: from thinkpad (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-6) with ESMTP id n1KIUaXd020365
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 19:30:40 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sleeping for 2 seconds before checking for the iobox is not enough
on some systems.
this patch increases the timeout, but polls the card during that
time. it thus speeds up the module loading when the card has already
been initialized, while being more robust on systems, which require
a higher timeout than the predefined 2 seconds.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/rme9652/hdsp.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 44d0c15..a586a80 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -653,7 +653,6 @@ static unsigned int hdsp_read(struct hdsp *hdsp, int reg)
 
 static int hdsp_check_for_iobox (struct hdsp *hdsp)
 {
-
 	if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return 0;
 	if (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_ConfigError) {
 		snd_printk ("Hammerfall-DSP: no Digiface or Multiface connected!\n");
@@ -661,7 +660,27 @@ static int hdsp_check_for_iobox (struct hdsp *hdsp)
 		return -EIO;
 	}
 	return 0;
+}
 
+static int hdsp_wait_for_iobox (struct hdsp *hdsp, unsigned int loops, unsigned int delay)
+{
+	unsigned int i;
+
+	if (hdsp->io_type == H9652 || hdsp->io_type == H9632)
+		return 0;
+
+	for (i = 0; i != loops; ++i) {
+		if (hdsp_read (hdsp, HDSP_statusRegister) & HDSP_ConfigError)
+			msleep(delay);
+		else {
+			snd_printd ("Hammerfall-DSP: iobox found after %ums!\n", i * delay);
+			return 0;
+		}
+	}
+
+	snd_printk ("Hammerfall-DSP: no Digiface or Multiface connected!\n");
+	hdsp->state &= ~HDSP_FirmwareLoaded;
+	return -EIO;
 }
 
 static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
@@ -5055,10 +5074,9 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 		return err;
 	
 	if (!is_9652 && !is_9632) {
-		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
-		ssleep(2);
+		/* we wait a maximum of 10 seconds to let freshly inserted cardbus cards do their hardware init */
+		err = hdsp_wait_for_iobox(hdsp, 1000, 10);
 
-		err = hdsp_check_for_iobox(hdsp);
 		if (err < 0)
 			return err;
 
-- 
1.6.1.2
