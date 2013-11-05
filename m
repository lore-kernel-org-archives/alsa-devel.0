From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: usb - For class 2 devices,
	use channel map from altsettings
Date: Tue,  5 Nov 2013 04:41:07 +0100
Message-ID: <1383622868-2596-3-git-send-email-david.henningsson@canonical.com>
References: <1383622868-2596-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 76B27261A83
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 04:41:12 +0100 (CET)
In-Reply-To: <1383622868-2596-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The channel config from the streaming descriptor is probably a
better indicator of the channel map than the input terminal.
Use the input terminal's channel map as fallback only.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/usb/stream.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index b43b6ee..badd1d6d 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -587,6 +587,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 
 			num_channels = as->bNrChannels;
 			format = le32_to_cpu(as->bmFormats);
+			chconfig = le32_to_cpu(as->bmChannelConfig);
 
 			/* lookup the terminal associated to this interface
 			 * to extract the clock */
@@ -594,7 +595,8 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 									    as->bTerminalLink);
 			if (input_term) {
 				clock = input_term->bCSourceID;
-				chconfig = le32_to_cpu(input_term->bmChannelConfig);
+				if (!chconfig && (num_channels == input_term->bNrChannels))
+					chconfig = le32_to_cpu(input_term->bmChannelConfig);
 				break;
 			}
 
-- 
1.7.9.5
