From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3] ALSA: snd-usb: operate on given mixer
	interface only
Date: Thu,  4 Aug 2011 15:56:28 +0200
Message-ID: <1312466188-3428-4-git-send-email-zonque@gmail.com>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 1004D24419
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 15:56:58 +0200 (CEST)
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

When creating the mixers for an USB audio device, the current code looks
at the host interface stored in mixer->chip->ctrl_if. Change this and
rather keep a local pointer to the interface that was given when
snd_usb_create_mixer() was called.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
Reported-by: Lean-Yves LENHOF <jean-yves@lenhof.eu.org>
Cc: stable@kernel.org
---
 sound/usb/mixer.c |   20 ++++++++------------
 sound/usb/mixer.h |    1 +
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5ab345f..45dd1fe 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1939,15 +1939,13 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 	struct mixer_build state;
 	int err;
 	const struct usbmix_ctl_map *map;
-	struct usb_host_interface *hostif;
 	void *p;
 
-	hostif = mixer->chip->ctrl_intf;
 	memset(&state, 0, sizeof(state));
 	state.chip = mixer->chip;
 	state.mixer = mixer;
-	state.buffer = hostif->extra;
-	state.buflen = hostif->extralen;
+	state.buffer = mixer->hostif->extra;
+	state.buflen = mixer->hostif->extralen;
 
 	/* check the mapping table */
 	for (map = usbmix_ctl_maps; map->id; map++) {
@@ -1960,7 +1958,8 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 	}
 
 	p = NULL;
-	while ((p = snd_usb_find_csint_desc(hostif->extra, hostif->extralen, p, UAC_OUTPUT_TERMINAL)) != NULL) {
+	while ((p = snd_usb_find_csint_desc(mixer->hostif->extra, mixer->hostif->extralen,
+					    p, UAC_OUTPUT_TERMINAL)) != NULL) {
 		if (mixer->protocol == UAC_VERSION_1) {
 			struct uac1_output_terminal_descriptor *desc = p;
 
@@ -2167,17 +2166,15 @@ int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
 /* create the handler for the optional status interrupt endpoint */
 static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 {
-	struct usb_host_interface *hostif;
 	struct usb_endpoint_descriptor *ep;
 	void *transfer_buffer;
 	int buffer_length;
 	unsigned int epnum;
 
-	hostif = mixer->chip->ctrl_intf;
 	/* we need one interrupt input endpoint */
-	if (get_iface_desc(hostif)->bNumEndpoints < 1)
+	if (get_iface_desc(mixer->hostif)->bNumEndpoints < 1)
 		return 0;
-	ep = get_endpoint(hostif, 0);
+	ep = get_endpoint(mixer->hostif, 0);
 	if (!usb_endpoint_dir_in(ep) || !usb_endpoint_xfer_int(ep))
 		return 0;
 
@@ -2207,7 +2204,6 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	};
 	struct usb_mixer_interface *mixer;
 	struct snd_info_entry *entry;
-	struct usb_host_interface *host_iface;
 	int err;
 
 	strcpy(chip->card->mixername, "USB Mixer");
@@ -2224,8 +2220,8 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		return -ENOMEM;
 	}
 
-	host_iface = &usb_ifnum_to_if(chip->dev, ctrlif)->altsetting[0];
-	switch (get_iface_desc(host_iface)->bInterfaceProtocol) {
+	mixer->hostif = &usb_ifnum_to_if(chip->dev, ctrlif)->altsetting[0];
+	switch (get_iface_desc(mixer->hostif)->bInterfaceProtocol) {
 	case UAC_VERSION_1:
 	default:
 		mixer->protocol = UAC_VERSION_1;
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index ae1a14d..81b2d8a 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -3,6 +3,7 @@
 
 struct usb_mixer_interface {
 	struct snd_usb_audio *chip;
+	struct usb_host_interface *hostif;
 	struct list_head list;
 	unsigned int ignore_ctl_error;
 	struct urb *urb;
-- 
1.7.5.4
