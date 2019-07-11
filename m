From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: pci: emu10k1: Remove unneeded variable "change"
Date: Thu, 11 Jul 2019 22:47:26 +0530
Message-ID: <20190711171726.GA4356@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Allison Randal <allison@lohutok.net>, Richard Fontana <rfontana@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

fix below issue reported by coccicheck
sound/pci/emu10k1/emu10k1x.c:1077:5-11: Unneeded variable: "change".
Return "0" on line 1092

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/emu10k1/emu10k1x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 67d6473..9cf8183 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1074,7 +1074,6 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 {
 	struct emu10k1x *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
-	int change = 0;
 
 	val = ucontrol->value.integer.value[0] ;
 
@@ -1089,7 +1088,7 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 		snd_emu10k1x_ptr_write(emu, ROUTING, 0, 0x1003F);
 		snd_emu10k1x_gpio_write(emu, 0x1080);
 	}
-	return change;
+	return 0;
 }
 
 static const struct snd_kcontrol_new snd_emu10k1x_shared_spdif =
-- 
2.7.4
