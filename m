From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] ALSA sound/pcmcia/pdaudiocf/pdaudiocf_core.c: make some code static
Date: Mon, 22 Nov 2004 00:58:53 +0100
Message-ID: <20041121235853.GH13254__11970.7059966915$1101082142$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 2B6FA271
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 00:58:54 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch below makes some needlessly global code static.


diffstat output:
 sound/pcmcia/pdaudiocf/pdaudiocf.h      |    2 --
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf.h.old	2004-11-21 23:57:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf.h	2004-11-21 23:57:46.000000000 +0100
@@ -130,8 +130,6 @@
 	return inw(chip->port + reg);
 }
 
-unsigned char pdacf_ak4117_read(void *private_data, unsigned char reg);
-void pdacf_ak4117_write(void *private_data, unsigned char reg, unsigned char val);
 pdacf_t *snd_pdacf_create(snd_card_t *card);
 int snd_pdacf_ak4117_create(pdacf_t *pdacf);
 void snd_pdacf_powerdown(pdacf_t *chip);
--- linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_core.c.old	2004-11-21 23:57:54.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2004-11-21 23:58:10.000000000 +0100
@@ -28,7 +28,7 @@
 /*
  *
  */
-unsigned char pdacf_ak4117_read(void *private_data, unsigned char reg)
+static unsigned char pdacf_ak4117_read(void *private_data, unsigned char reg)
 {
 	pdacf_t *chip = private_data;
 	unsigned long timeout;
@@ -60,7 +60,7 @@
 	return res;
 }
 
-void pdacf_ak4117_write(void *private_data, unsigned char reg, unsigned char val)
+static void pdacf_ak4117_write(void *private_data, unsigned char reg, unsigned char val)
 {
 	pdacf_t *chip = private_data;
 	unsigned long timeout;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
