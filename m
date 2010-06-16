From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/5] ALSA: usb-midi: whitespace fixes
Date: Wed, 16 Jun 2010 17:57:29 +0200
Message-ID: <1276703851-22199-4-git-send-email-daniel@caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 16EC624150
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 17:57:47 +0200 (CEST)
In-Reply-To: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/midi.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 4678564..b9c2bc6 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -434,7 +434,7 @@ static void snd_usbmidi_maudio_broken_running_status_input(
 			u8 cin = buffer[i] & 0x0f;
 			struct usbmidi_in_port *port = &ep->ports[cable];
 			int length;
-			
+
 			length = snd_usbmidi_cin_length[cin];
 			if (cin == 0xf && buffer[i + 1] >= 0xf8)
 				; /* realtime msg: no running status change */
@@ -628,13 +628,13 @@ static struct usb_protocol_ops snd_usbmidi_standard_ops = {
 
 static struct usb_protocol_ops snd_usbmidi_midiman_ops = {
 	.input = snd_usbmidi_midiman_input,
-	.output = snd_usbmidi_standard_output, 
+	.output = snd_usbmidi_standard_output,
 	.output_packet = snd_usbmidi_output_midiman_packet,
 };
 
 static struct usb_protocol_ops snd_usbmidi_maudio_broken_running_status_ops = {
 	.input = snd_usbmidi_maudio_broken_running_status_input,
-	.output = snd_usbmidi_standard_output, 
+	.output = snd_usbmidi_standard_output,
 	.output_packet = snd_usbmidi_output_standard_packet,
 };
 
@@ -1248,7 +1248,7 @@ static void snd_usbmidi_out_endpoint_delete(struct snd_usb_midi_out_endpoint *ep
  */
 static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi* umidi,
 					   struct snd_usb_midi_endpoint_info* ep_info,
-			 		   struct snd_usb_midi_endpoint* rep)
+					   struct snd_usb_midi_endpoint* rep)
 {
 	struct snd_usb_midi_out_endpoint* ep;
 	unsigned int i;
@@ -1398,7 +1398,7 @@ static void snd_usbmidi_rawmidi_free(struct snd_rawmidi *rmidi)
 }
 
 static struct snd_rawmidi_substream *snd_usbmidi_find_substream(struct snd_usb_midi* umidi,
-							   int stream, int number)
+								int stream, int number)
 {
 	struct list_head* list;
 
@@ -1811,7 +1811,7 @@ static int snd_usbmidi_detect_endpoints(struct snd_usb_midi* umidi,
 		snd_usbmidi_switch_roland_altsetting(umidi);
 
 	if (endpoint[0].out_ep || endpoint[0].in_ep)
-		return 0;	
+		return 0;
 
 	intf = umidi->iface;
 	if (!intf || intf->num_altsetting < 1)
@@ -1849,7 +1849,7 @@ static int snd_usbmidi_detect_per_port_endpoints(struct snd_usb_midi* umidi,
 						 struct snd_usb_midi_endpoint_info* endpoints)
 {
 	int err, i;
-	
+
 	err = snd_usbmidi_detect_endpoints(umidi, endpoints, MIDI_MAX_ENDPOINTS);
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		if (endpoints[i].out_ep)
-- 
1.7.1
