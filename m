From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/6] [ALSA] portman2x4 - fix blanklines
Date: Thu,  7 Jan 2016 12:45:47 +0530
Message-ID: <1452150951-1571-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C1C265546
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2016 08:16:04 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id uo6so233294324pac.1
 for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2016 23:16:04 -0800 (PST)
In-Reply-To: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

checkpatch complains about multiple blank lines and missing blank line
after declaration.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/portman2x4.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index ba0860d..4f9717b 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -284,7 +284,6 @@ static void portman_write_midi(struct portman *pm,
 	/* Data sent. */
 }
 
-
 /*
  *  Read MIDI byte from port
  *  Attempt to read input byte from specified hardware input port (0..).
@@ -357,7 +356,6 @@ static int portman_read_midi(struct portman *pm, int port)
 	portman_write_data(pm, 1);	/* Cause rising edge, which shifts data. */
 	portman_write_data(pm, 0);	/* Return data clock low. */
 
-
 	/* De-assert Strobe and return data. */
 	portman_write_command(pm, cmdout);	/* Output saved address+IE. */
 
@@ -375,6 +373,7 @@ static int portman_read_midi(struct portman *pm, int port)
 static int portman_data_avail(struct portman *pm, int channel)
 {
 	int command = INT_EN;
+
 	switch (channel) {
 	case 0:
 		command |= RXDATA0;
@@ -393,7 +392,6 @@ static int portman_data_avail(struct portman *pm, int channel)
 	return 0;
 }
 
-
 /*
  *  Flushes any input
  */
@@ -823,7 +821,6 @@ static int snd_portman_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
 static struct platform_driver snd_portman_driver = {
 	.probe  = snd_portman_probe,
 	.remove = snd_portman_remove,
-- 
1.9.1
