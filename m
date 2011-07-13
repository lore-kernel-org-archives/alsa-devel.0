From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/5] ALSA: snd-usb: be more verbose about bogus
	UAC_FORMAT_TYPE descriptors
Date: Wed, 13 Jul 2011 02:13:27 +0200
Message-ID: <1310516009-4387-3-git-send-email-zonque@gmail.com>
References: <1310516009-4387-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 2048B1038D2
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 02:13:36 +0200 (CEST)
In-Reply-To: <1310516009-4387-1-git-send-email-zonque@gmail.com>
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
Cc: Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/endpoint.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index b0ef9f5..af59bd7 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -353,8 +353,8 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		}
 		if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8)) ||
 		    ((protocol == UAC_VERSION_2) && (fmt->bLength != 6))) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc\n",
-				   dev->devnum, iface_no, altno);
+			snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc (protocol %d, bLength %d)\n",
+				   dev->devnum, iface_no, altno, protocol, fmt->bLength);
 			continue;
 		}
 
-- 
1.7.5.4
