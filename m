From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/5] snd-usb-caiaq: Set default input mode of
	A4DJ
Date: Wed,  4 Feb 2009 22:34:31 +0000
Message-ID: <1233786874-16373-2-git-send-email-mark@pogo.org.uk>
References: <1233786874-16373-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6944424407
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 23:34:35 +0100 (CET)
In-Reply-To: <1233786874-16373-1-git-send-email-mark@pogo.org.uk>
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
Cc: Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Do not start the device with input mode undefined. Mimic the behaviour of
the Audio 8 DJ and start in phono input mode.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 usb/caiaq/caiaq-device.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/usb/caiaq/caiaq-device.c b/usb/caiaq/caiaq-device.c
index 2464614..769321d 100644
--- a/usb/caiaq/caiaq-device.c
+++ b/usb/caiaq/caiaq-device.c
@@ -312,6 +312,12 @@ static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
 		}
 
 		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
+		/* Audio 4 DJ - default input mode to phono */
+		dev->control_state[0] = 2;
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
+			dev->control_state, 1);
+		break;
 	}
 	
 	if (dev->spec.num_analog_audio_out +
-- 
1.6.1.2
