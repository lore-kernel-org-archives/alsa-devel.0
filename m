From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] ALSA: snd-usb: Accept UAC2 FORMAT_TYPE
	descriptors with bLength > 6
Date: Wed, 13 Jul 2011 02:13:29 +0200
Message-ID: <1310516009-4387-5-git-send-email-zonque@gmail.com>
References: <1310516009-4387-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <1310516009-4387-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: alsa-devel@alsa-project.org
Cc: stable@kernel.org, Daniel Mack <zonque@gmail.com>
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
index af59bd7..b558c67 100644
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

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
