From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 1/6] Force a cast to silence a warning from "sparse"
Date: Mon, 28 Jan 2013 23:42:27 +0100
Message-ID: <1359412952-1680-2-git-send-email-ospite@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Antonio Ospite <ao2@amarulasolutions.com>, Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

  Some audio drivers are calling snd_dma_continuous_data(GFP_KERNEL)
  which makes "sparse" give a warning:

    $ make C=2 M=sound/usb modules
      ...
    sound/usb/6fire/pcm.c:625:25: warning: cast from restricted gfp_t
    sound/usb/caiaq/audio.c:845:41: warning: cast from restricted gfp_t
    sound/usb/usx2y/usbusx2yaudio.c:997:54: warning: cast from restricted gfp_t
    sound/usb/usx2y/usbusx2yaudio.c:1001:54: warning: cast from restricted gfp_t
    sound/usb/usx2y/usx2yhwdeppcm.c:774:54: warning: cast from restricted gfp_t
    sound/usb/usx2y/usx2yhwdeppcm.c:778:54: warning: cast from restricted gfp_t

  Add __force to the cast to silence the warning.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---

CCing linux-kernel on just this patch of the series as there may be
comments about this practice of forcing casts.

Regards,
   Antonio

 include/sound/memalloc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 844af65..cf15b82 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -37,7 +37,7 @@ struct snd_dma_device {
 #ifndef snd_dma_pci_data
 #define snd_dma_pci_data(pci)	(&(pci)->dev)
 #define snd_dma_isa_data()	NULL
-#define snd_dma_continuous_data(x)	((struct device *)(unsigned long)(x))
+#define snd_dma_continuous_data(x)	((struct device *)(__force unsigned long)(x))
 #endif
 
 
-- 
1.7.10.4
