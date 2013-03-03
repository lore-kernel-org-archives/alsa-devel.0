From: Mark Hills <mark@xwax.org>
Subject: [PATCH RFC 4/4] snd-usb-audio: Prototype capture
	support for Novation Twitch
Date: Sun,  3 Mar 2013 17:57:37 +0000
Message-ID: <1362333457-23895-4-git-send-email-mark@xwax.org>
References: <alpine.LNX.2.01.1303021621060.8986@localhost>
 <1362333457-23895-1-git-send-email-mark@xwax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EE9282625D4
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 18:57:38 +0100 (CET)
In-Reply-To: <1362333457-23895-1-git-send-email-mark@xwax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

*** This patch is incomplete, as the device re-initialises
*** if playback and capture is attempted at the same time.

The capture endpoint shares the same interface as the playback
endpoint, and it seems that this is the first quirk to do this.

We must override the maxpacksize (which is not done in the
playback interface) because create_fixed_stream_quirk() takes the
wMaxPacketSize from the first endpoint by default.
---
 sound/usb/quirks-table.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 3614e9b..c62f2a3 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2707,6 +2707,29 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 2,
+					.iface = 0,
+					.altsetting = 1,
+ 					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.maxpacksize = 0x126,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000,
+					.rate_min = 44100,
+					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					}
+				}
+			},
+			{
 				.ifnum = 1,
 				.type = QUIRK_MIDI_RAW_BYTES
 			},
-- 
1.7.12.1
