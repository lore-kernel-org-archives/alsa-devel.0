From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH][RESEND] au88x0: mem leak fix in snd_vortex_create()
Date: Sat, 4 Aug 2007 20:30:34 +0200
Message-ID: <200708042030.34804.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932578AbXHDSd3@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Manuel Jander <mjander@embedded.cl>, Jesper Juhl <jesper.juhl@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(resend of patch previously submitted on 04-Aug-2007 02:09)


Hi,

In sound/pci/au88x0/au88x0.c::snd_vortex_create() : 
The Coverity checker found that if we allocate storage for 'chip' 
but then leave via the  regions_out:  label, then we end up leaking 
the storage allocated for 'chip'.
I believe simply freeing 'chip' before the "return err;" line is 
all we need to fix this, but please double-check me :)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
---

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 5ec1b6f..f70286a 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -232,6 +232,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	pci_disable_device(chip->pci_dev);
 	//FIXME: this not the right place to unregister the gameport
 	vortex_gameport_unregister(chip);
+	kfree(chip);
 	return err;
 }
 
