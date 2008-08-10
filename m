From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ice1724/revo: simple clean up
Date: Mon, 11 Aug 2008 02:09:04 +0400
Message-ID: <20080810220904.GD5093@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id E3C4A24529
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 00:09:09 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so893204fgg.44
	for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2008 15:09:09 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Alexander Beregalov <a.beregalov@gmail.com>

ice1724/revo: simple clean up


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ice1712/revo.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 4d26314..5e1b156 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -524,16 +524,20 @@ static int __devinit revo_init(struct snd_ice1712 *ice)
 	ak = ice->akm = kcalloc(2, sizeof(struct snd_akm4xxx), GFP_KERNEL);
 	if (! ak)
 		return -ENOMEM;
-	ice->akm_codecs = 2;
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
 		ice->akm_codecs = 2;
-		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_revo_front, &akm_revo_front_priv, ice)) < 0)
+		err = snd_ice1712_akm4xxx_init(ak, &akm_revo_front,
+						&akm_revo_front_priv, ice);
+		if (err < 0)
 			return err;
-		if ((err = snd_ice1712_akm4xxx_init(ak + 1, &akm_revo_surround, &akm_revo_surround_priv, ice)) < 0)
+		err = snd_ice1712_akm4xxx_init(ak+1, &akm_revo_surround,
+						&akm_revo_surround_priv, ice);
+		if (err < 0)
 			return err;
 		/* unmute all codecs */
-		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
+		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
+						VT1724_REVO_MUTE);
 		break;
 	case VT1724_SUBDEVICE_REVOLUTION51:
 		ice->akm_codecs = 2;
