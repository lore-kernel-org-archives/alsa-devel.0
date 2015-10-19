From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2 6/7] ALSA: USB-audio: Adjust max packet size
	calculation for tx_length_quirk
Date: Mon, 19 Oct 2015 08:52:54 +0200
Message-ID: <1445237575-396-7-git-send-email-ricardw@axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
 <1445237575-396-1-git-send-email-ricardw@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 341A3265740
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 08:53:06 +0200 (CEST)
In-Reply-To: <1445237575-396-1-git-send-email-ricardw@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Ricard Wanderlof <ricardw@axis.com>, Ricard Wanderlof <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org

For the Zoom R16/24 (tx_length_quirk set), when calculating the maximum
sample frequency, consideration must be made for the fact that four bytes
of the packet contain a length descriptor and consequently must not be
counted as part of the audio data.

This is corroborated by the wMaxPacketSize for this device, which is 108
bytes according for the USB playback endpoint descriptor. The frame size
is 8 bytes (2 channels of 4 bytes each), and the 108 bytes thus work out
as 13 * 8 + 4, i.e. corresponding to 13 frames plus the additional 4 byte
length descriptor.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 sound/usb/endpoint.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 0cc64bd..a8c751a 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -617,6 +617,8 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	unsigned int max_packs_per_period, urbs_per_period, urb_packs;
 	unsigned int max_urbs, i;
 	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
+	int tx_length_quirk = (ep->chip->tx_length_quirk &&
+			       usb_pipeout(ep->pipe));
 
 	if (pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE && fmt->dsd_dop) {
 		/*
@@ -650,11 +652,17 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	 */
 	maxsize = (((ep->freqmax << ep->datainterval) + 0xffff) >> 16) *
 			 (frame_bits >> 3);
+	if (tx_length_quirk)
+		maxsize += sizeof(__le32); /* Space for length descriptor */
 	/* but wMaxPacketSize might reduce this */
 	if (ep->maxpacksize && ep->maxpacksize < maxsize) {
 		/* whatever fits into a max. size packet */
-		maxsize = ep->maxpacksize;
-		ep->freqmax = (maxsize / (frame_bits >> 3))
+		unsigned int data_maxsize = maxsize = ep->maxpacksize;
+
+		if (tx_length_quirk)
+			/* Need to remove the length descriptor to calc freq */
+			data_maxsize -= sizeof(__le32);
+		ep->freqmax = (data_maxsize / (frame_bits >> 3))
 				<< (16 - ep->datainterval);
 	}
 
-- 
2.1.4
