From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ALSA: usb: handle descriptor with
	SYNC_NONE illegal value
Date: Thu, 13 Aug 2015 17:42:33 -0500
Message-ID: <1439505753-3532-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1439505753-3532-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3515C264F38
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 00:42:41 +0200 (CEST)
In-Reply-To: <1439505753-3532-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The M-Audio Transit exposes an interface with a SYNC_NONE attribute.
This is not a valid value according to the USB audio classspec. However
there is a sync endpoint associated to this record. Changing the logic to
try to use this sync endpoint allows for seamless transitions between
altset 2 and altset 3. If any errors happen, the behavior remains the same.

$ more /proc/asound/card1/stream0
M-Audio Transit USB at usb-0000:00:14.0-2, full speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (NONE)
    Rates: 8000 - 48000 (continuous)
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/usb/pcm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 7cd7c03..9f29017 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -411,10 +411,17 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 
-	if ((is_playback && attr != USB_ENDPOINT_SYNC_ASYNC) ||
+	if ((is_playback && attr == USB_ENDPOINT_SYNC_SYNC) ||
+	    (is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE) ||
 	    (!is_playback && attr != USB_ENDPOINT_SYNC_ADAPTIVE))
 		return 0;
 
+	/*
+	 * In case of illegal SYNC_NONE for OUT endpoint, we keep going to see
+	 * if we don't find a sync endpoint, as on M-Audio Transit. In case of
+	 * error fall back to SYNC mode and don't create sync endpoint
+	 */
+
 	/* check sync-pipe endpoint */
 	/* ... and check descriptor size before accessing bSynchAddress
 	   because there is a version of the SB Audigy 2 NX firmware lacking
@@ -428,6 +435,8 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 			   get_endpoint(alts, 1)->bmAttributes,
 			   get_endpoint(alts, 1)->bLength,
 			   get_endpoint(alts, 1)->bSynchAddress);
+		if (is_playback && attr == USB_ENDPOINT_SYNC_NONE)
+			goto no_valid_sync_ep_found;
 		return -EINVAL;
 	}
 	ep = get_endpoint(alts, 1)->bEndpointAddress;
@@ -438,6 +447,8 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 			"%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
 			   fmt->iface, fmt->altsetting,
 			   is_playback, ep, get_endpoint(alts, 0)->bSynchAddress);
+		if (is_playback && attr == USB_ENDPOINT_SYNC_NONE)
+			goto no_valid_sync_ep_found;
 		return -EINVAL;
 	}
 
@@ -449,11 +460,15 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 						   implicit_fb ?
 							SND_USB_ENDPOINT_TYPE_DATA :
 							SND_USB_ENDPOINT_TYPE_SYNC);
-	if (!subs->sync_endpoint)
+	if (!subs->sync_endpoint) {
+		if (is_playback && attr == USB_ENDPOINT_SYNC_NONE)
+			goto no_valid_sync_ep_found;
 		return -EINVAL;
+	}
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
+no_valid_sync_ep_found: /* fall back to synchronous mode */
 	return 0;
 }
 
-- 
1.9.1
