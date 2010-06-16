From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/5] ALSA: usb-audio: unify UAC macros and
	struct names
Date: Wed, 16 Jun 2010 17:57:28 +0200
Message-ID: <1276703851-22199-3-git-send-email-daniel@caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FFAA103903
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 17:57:51 +0200 (CEST)
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

Get rid of the last occurances of _v1 suffixes, and move the version
number right after the "uac" string. Now things are consitent again.

Sorry for the forth and back, but it just looks much nicer this way.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 drivers/usb/gadget/f_audio.c |    6 +++---
 drivers/usb/gadget/gmidi.c   |    2 +-
 include/linux/usb/audio-v2.h |    2 +-
 include/linux/usb/audio.h    |   12 ++++++------
 sound/usb/card.c             |    2 +-
 sound/usb/endpoint.c         |    4 ++--
 sound/usb/mixer.c            |   14 +++++++-------
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/gadget/f_audio.c b/drivers/usb/gadget/f_audio.c
index b91115f..1f48ceb 100644
--- a/drivers/usb/gadget/f_audio.c
+++ b/drivers/usb/gadget/f_audio.c
@@ -61,7 +61,7 @@ DECLARE_UAC_AC_HEADER_DESCRIPTOR(2);
 #define UAC_DT_TOTAL_LENGTH (UAC_DT_AC_HEADER_LENGTH + UAC_DT_INPUT_TERMINAL_SIZE \
 	+ UAC_DT_OUTPUT_TERMINAL_SIZE + UAC_DT_FEATURE_UNIT_SIZE(0))
 /* B.3.2  Class-Specific AC Interface Descriptor */
-static struct uac_ac_header_descriptor_v1_2 ac_header_desc = {
+static struct uac1_ac_header_descriptor_2 ac_header_desc = {
 	.bLength =		UAC_DT_AC_HEADER_LENGTH,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_HEADER,
@@ -125,7 +125,7 @@ static struct usb_audio_control_selector feature_unit = {
 };
 
 #define OUTPUT_TERMINAL_ID	3
-static struct uac_output_terminal_descriptor_v1 output_terminal_desc = {
+static struct uac1_output_terminal_descriptor output_terminal_desc = {
 	.bLength		= UAC_DT_OUTPUT_TERMINAL_SIZE,
 	.bDescriptorType	= USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype	= UAC_OUTPUT_TERMINAL,
@@ -155,7 +155,7 @@ static struct usb_interface_descriptor as_interface_alt_1_desc = {
 };
 
 /* B.4.2  Class-Specific AS Interface Descriptor */
-static struct uac_as_header_descriptor_v1 as_header_desc = {
+static struct uac1_as_header_descriptor as_header_desc = {
 	.bLength =		UAC_DT_AS_HEADER_SIZE,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_AS_GENERAL,
diff --git a/drivers/usb/gadget/gmidi.c b/drivers/usb/gadget/gmidi.c
index 2b56ce6..b7bf880 100644
--- a/drivers/usb/gadget/gmidi.c
+++ b/drivers/usb/gadget/gmidi.c
@@ -238,7 +238,7 @@ static const struct usb_interface_descriptor ac_interface_desc = {
 };
 
 /* B.3.2  Class-Specific AC Interface Descriptor */
-static const struct uac_ac_header_descriptor_v1_1 ac_header_desc = {
+static const struct uac1_ac_header_descriptor_1 ac_header_desc = {
 	.bLength =		UAC_DT_AC_HEADER_SIZE(1),
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	USB_MS_HEADER,
diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index 383b94b..716aebe 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -121,7 +121,7 @@ struct uac2_feature_unit_descriptor {
 
 /* 4.9.2 Class-Specific AS Interface Descriptor */
 
-struct uac_as_header_descriptor_v2 {
+struct uac2_as_header_descriptor {
 	__u8 bLength;
 	__u8 bDescriptorType;
 	__u8 bDescriptorSubtype;
diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index c51200c..a54b825 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -39,8 +39,8 @@
 #define UAC_MIXER_UNIT			0x04
 #define UAC_SELECTOR_UNIT		0x05
 #define UAC_FEATURE_UNIT		0x06
-#define UAC_PROCESSING_UNIT_V1		0x07
-#define UAC_EXTENSION_UNIT_V1		0x08
+#define UAC1_PROCESSING_UNIT		0x07
+#define UAC1_EXTENSION_UNIT		0x08
 
 /* A.6 Audio Class-Specific AS Interface Descriptor Subtypes */
 #define UAC_AS_GENERAL			0x01
@@ -151,7 +151,7 @@
 
 /* Terminal Control Selectors */
 /* 4.3.2  Class-Specific AC Interface Descriptor */
-struct uac_ac_header_descriptor_v1 {
+struct uac1_ac_header_descriptor {
 	__u8  bLength;			/* 8 + n */
 	__u8  bDescriptorType;		/* USB_DT_CS_INTERFACE */
 	__u8  bDescriptorSubtype;	/* UAC_MS_HEADER */
@@ -165,7 +165,7 @@ struct uac_ac_header_descriptor_v1 {
 
 /* As above, but more useful for defining your own descriptors: */
 #define DECLARE_UAC_AC_HEADER_DESCRIPTOR(n)			\
-struct uac_ac_header_descriptor_v1_##n {			\
+struct uac1_ac_header_descriptor_##n {			\
 	__u8  bLength;						\
 	__u8  bDescriptorType;					\
 	__u8  bDescriptorSubtype;				\
@@ -205,7 +205,7 @@ struct uac_input_terminal_descriptor {
 #define UAC_TERMINAL_CS_COPY_PROTECT_CONTROL		0x01
 
 /* 4.3.2.2 Output Terminal Descriptor */
-struct uac_output_terminal_descriptor_v1 {
+struct uac1_output_terminal_descriptor {
 	__u8  bLength;			/* in bytes: 9 */
 	__u8  bDescriptorType;		/* CS_INTERFACE descriptor type */
 	__u8  bDescriptorSubtype;	/* OUTPUT_TERMINAL descriptor subtype */
@@ -395,7 +395,7 @@ static inline __u8 *uac_processing_unit_specific(struct uac_processing_unit_desc
 }
 
 /* 4.5.2 Class-Specific AS Interface Descriptor */
-struct uac_as_header_descriptor_v1 {
+struct uac1_as_header_descriptor {
 	__u8  bLength;			/* in bytes: 7 */
 	__u8  bDescriptorType;		/* USB_DT_CS_INTERFACE */
 	__u8  bDescriptorSubtype;	/* AS_GENERAL */
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7a8ac1d..9feb00c 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -217,7 +217,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 
 	switch (protocol) {
 	case UAC_VERSION_1: {
-		struct uac_ac_header_descriptor_v1 *h1 = control_header;
+		struct uac1_ac_header_descriptor *h1 = control_header;
 
 		if (!h1->bInCollection) {
 			snd_printk(KERN_INFO "skipping empty audio interface (v1)\n");
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 9593b91..289a165 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -275,7 +275,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		/* get audio formats */
 		switch (protocol) {
 		case UAC_VERSION_1: {
-			struct uac_as_header_descriptor_v1 *as =
+			struct uac1_as_header_descriptor *as =
 				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
 
 			if (!as) {
@@ -297,7 +297,7 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		case UAC_VERSION_2: {
 			struct uac2_input_terminal_descriptor *input_term;
 			struct uac2_output_terminal_descriptor *output_term;
-			struct uac_as_header_descriptor_v2 *as =
+			struct uac2_as_header_descriptor *as =
 				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
 
 			if (!as) {
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6939d0f..b6a261f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -582,9 +582,9 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
 		switch (iterm->type >> 16) {
 		case UAC_SELECTOR_UNIT:
 			strcpy(name, "Selector"); return 8;
-		case UAC_PROCESSING_UNIT_V1:
+		case UAC1_PROCESSING_UNIT:
 			strcpy(name, "Process Unit"); return 12;
-		case UAC_EXTENSION_UNIT_V1:
+		case UAC1_EXTENSION_UNIT:
 			strcpy(name, "Ext Unit"); return 8;
 		case UAC_MIXER_UNIT:
 			strcpy(name, "Mixer"); return 5;
@@ -672,8 +672,8 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 			term->name = uac_selector_unit_iSelector(d);
 			return 0;
 		}
-		case UAC_PROCESSING_UNIT_V1:
-		case UAC_EXTENSION_UNIT_V1: {
+		case UAC1_PROCESSING_UNIT:
+		case UAC1_EXTENSION_UNIT: {
 			struct uac_processing_unit_descriptor *d = p1;
 			if (d->bNrInPins) {
 				id = d->baSourceID[0];
@@ -1842,13 +1842,13 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 		return parse_audio_selector_unit(state, unitid, p1);
 	case UAC_FEATURE_UNIT:
 		return parse_audio_feature_unit(state, unitid, p1);
-	case UAC_PROCESSING_UNIT_V1:
+	case UAC1_PROCESSING_UNIT:
 	/*   UAC2_EFFECT_UNIT has the same value */
 		if (state->mixer->protocol == UAC_VERSION_1)
 			return parse_audio_processing_unit(state, unitid, p1);
 		else
 			return 0; /* FIXME - effect units not implemented yet */
-	case UAC_EXTENSION_UNIT_V1:
+	case UAC1_EXTENSION_UNIT:
 	/*   UAC2_PROCESSING_UNIT_V2 has the same value */
 		if (state->mixer->protocol == UAC_VERSION_1)
 			return parse_audio_extension_unit(state, unitid, p1);
@@ -1912,7 +1912,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 	p = NULL;
 	while ((p = snd_usb_find_csint_desc(hostif->extra, hostif->extralen, p, UAC_OUTPUT_TERMINAL)) != NULL) {
 		if (mixer->protocol == UAC_VERSION_1) {
-			struct uac_output_terminal_descriptor_v1 *desc = p;
+			struct uac1_output_terminal_descriptor *desc = p;
 
 			if (desc->bLength < sizeof(*desc))
 				continue; /* invalid descriptor? */
-- 
1.7.1
