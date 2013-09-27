From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/2] [RESEND] snd-ac97-codec: Use complete ID when the codec is not known
Date: Fri, 27 Sep 2013 20:28:03 +0200
Message-ID: <201309272028.03764.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently, if the codec ID is not known, the last byte of the ID is used as name.
It's not helpful at all, use full codec ID instead.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ac97/ac97_codec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index bf578ba2..30a40a8 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1830,7 +1830,7 @@ void snd_ac97_get_name(struct snd_ac97 *ac97, unsigned int id, char *name, int m
 				pid->patch(ac97);
 		}
 	} else
-		sprintf(name + strlen(name), " id %x", id & 0xff);
+		sprintf(name + strlen(name), " id %x", id);
 }
 
 /**
-- 
Ondrej Zary
