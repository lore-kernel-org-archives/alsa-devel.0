From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 3/4] Revert "ALSA: snd-usb-caiaq: Set default
	input mode of A4DJ"
Date: Sat, 29 May 2010 16:53:25 +0100
Message-ID: <1275148406-24596-3-git-send-email-mark@pogo.org.uk>
References: <1275148406-24596-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 354982441A
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 17:53:29 +0200 (CEST)
In-Reply-To: <1275148406-24596-1-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Do not explicity set the default input mode. Use the hardware default
of mode 0 ('Control vinyl'), which is now available.

This reverts commit e3ca4c9.

Acked-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/caiaq/device.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 8052718..bf71048 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -320,12 +320,6 @@ static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
 		}
 
 		break;
-	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
-		/* Audio 4 DJ - default input mode to phono */
-		dev->control_state[0] = 2;
-		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
-			dev->control_state, 1);
-		break;
 	}
 
 	if (dev->spec.num_analog_audio_out +
-- 
1.7.1
