From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ALSA: snd-usb: Accept UAC2 FORMAT_TYPE
	descriptors with bLength > 6
Date: Thu,  4 Aug 2011 15:56:26 +0200
Message-ID: <1312466188-3428-2-git-send-email-zonque@gmail.com>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 005EA24416
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 15:56:57 +0200 (CEST)
In-Reply-To: <1312466188-3428-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, stable@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Focusrite Scarlett 18i6 USB has them that way, which is probably a
bug. Anyway, the driver should simply ignore this fact.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
Cc: stable@kernel.org
---
 sound/usb/endpoint.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 1eea7e3..1867bbd 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -352,7 +352,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			continue;
 		}
 		if (((protocol == UAC_VERSION_1) && (fmt->bLength < 8)) ||
-		    ((protocol == UAC_VERSION_2) && (fmt->bLength != 6))) {
+		    ((protocol == UAC_VERSION_2) && (fmt->bLength < 6))) {
 			snd_printk(KERN_ERR "%d:%u:%d : invalid UAC_FORMAT_TYPE desc (protocol %d, bLength %d)\n",
 				   dev->devnum, iface_no, altno, protocol, fmt->bLength);
 			continue;
-- 
1.7.5.4
