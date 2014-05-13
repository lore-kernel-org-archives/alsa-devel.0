From: Eduard Gilmutdinov <edgilmutdinov@gmail.com>
Subject: [RFC PATCH 2/2] Add support for capture through
	external audio card Focusrite Saffire 6 USB
Date: Tue, 13 May 2014 10:08:51 +0600
Message-ID: <1399954131-26516-3-git-send-email-edgilmutdinov@gmail.com>
References: <1399954131-26516-1-git-send-email-edgilmutdinov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 53FCC2652EE
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 06:09:11 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id el20so2617382lab.1
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 21:09:10 -0700 (PDT)
In-Reply-To: <1399954131-26516-1-git-send-email-edgilmutdinov@gmail.com>
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
Cc: mark@xwax.org, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eduard Gilmutdinov <edgilmutdinov@gmail.com>
---
 sound/usb/quirks-table.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f652b10..a61e57d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2539,6 +2539,30 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
 					.endpoint = 0x01,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.maxpacksize = 0x024c,
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
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 2,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.maxpacksize = 0x0126,
 					.rates = SNDRV_PCM_RATE_44100 |
 						 SNDRV_PCM_RATE_48000,
 					.rate_min = 44100,
-- 
1.9.2
