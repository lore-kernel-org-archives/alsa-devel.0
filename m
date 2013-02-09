From: Matt Gruskin <matthew.gruskin@gmail.com>
Subject: [PATCH - add support for M-Audio FT C600 1/1] ALSA:
 usb-audio: add support for M-Audio FT C600
Date: Sat, 9 Feb 2013 13:54:45 -0500
Message-ID: <CAFTHD9XZeP0MF7QVhA3ARBT0LdxccZpxbZKWU4E9pbFRZPogPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index e90daf8..638e7f7 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -807,6 +807,7 @@ static void volume_control_quirks(struct
usb_mixer_elem_info *cval,
 {
  switch (cval->mixer->chip->usb_id) {
  case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
+ case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
  if (strcmp(kctl->id.name, "Effect Duration") == 0) {
  cval->min = 0x0000;
  cval->max = 0xffff;
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 0e2ed3d..cc2dd1f 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -380,6 +380,10 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
  .selector_map = c400_selectors,
  },
  {
+ .id = USB_ID(0x0763, 0x2031),
+ .selector_map = c400_selectors,
+ },
+ {
  .id = USB_ID(0x08bb, 0x2702),
  .map = linex_map,
  .ignore_ctl_error = 1,
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 15520de..497d274 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -637,7 +637,7 @@ static int
snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 }

 /* M-Audio FastTrack Ultra quirks */
-/* FTU Effect switch (also used by C400) */
+/* FTU Effect switch (also used by C400/C600) */
 struct snd_ftu_eff_switch_priv_val {
  struct usb_mixer_interface *mixer;
  int cached_value;
@@ -1029,32 +1029,45 @@ void snd_emuusb_set_samplerate(struct
snd_usb_audio *chip,
  }
 }

-/* M-Audio Fast Track C400 */
-/* C400 volume controls, this control needs a volume quirk, see mixer.c */
+/* M-Audio Fast Track C400/C600 */
+/* C400/C600 volume controls, this control needs a volume quirk, see mixer.c */
 static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
 {
  char name[64];
  unsigned int cmask, offset;
  int out, chan, err;
+ int num_outs = 0;
+ int num_ins = 0;

  const unsigned int id = 0x40;
  const int val_type = USB_MIXER_S16;
  const int control = 1;

- for (chan = 0; chan < 10; chan++) {
- for (out = 0; out < 6; out++) {
- if (chan < 6) {
+ switch (mixer->chip->usb_id) {
+ case USB_ID(0x0763, 0x2030):
+ num_outs = 6;
+ num_ins = 4;
+ break;
+ case USB_ID(0x0763, 0x2031):
+ num_outs = 8;
+ num_ins = 6;
+ break;
+ }
+
+ for (chan = 0; chan < num_outs + num_ins; chan++) {
+ for (out = 0; out < num_outs; out++) {
+ if (chan < num_outs) {
  snprintf(name, sizeof(name),
  "PCM%d-Out%d Playback Volume",
  chan + 1, out + 1);
  } else {
  snprintf(name, sizeof(name),
  "In%d-Out%d Playback Volume",
- chan - 5, out + 1);
+ chan - num_outs + 1, out + 1);
  }

  cmask = (out == 0) ? 0 : 1 << (out - 1);
- offset = chan * 6;
+ offset = chan * num_outs;
  err = snd_create_std_mono_ctl_offset(mixer, id, control,
  cmask, val_type, offset, name,
  &snd_usb_mixer_vol_tlv);
@@ -1110,20 +1123,33 @@ static int
snd_c400_create_effect_vol_ctls(struct usb_mixer_interface *mixer)
  char name[64];
  unsigned int cmask;
  int chan, err;
+ int num_outs = 0;
+ int num_ins = 0;

  const unsigned int id = 0x42;
  const int val_type = USB_MIXER_S16;
  const int control = 1;

- for (chan = 0; chan < 10; chan++) {
- if (chan < 6) {
+ switch (mixer->chip->usb_id) {
+ case USB_ID(0x0763, 0x2030):
+ num_outs = 6;
+ num_ins = 4;
+ break;
+ case USB_ID(0x0763, 0x2031):
+ num_outs = 8;
+ num_ins = 6;
+ break;
+ }
+
+ for (chan = 0; chan < num_outs + num_ins; chan++) {
+ if (chan < num_outs) {
  snprintf(name, sizeof(name),
  "Effect Send DOut%d",
  chan + 1);
  } else {
  snprintf(name, sizeof(name),
  "Effect Send AIn%d",
- chan - 5);
+ chan - num_outs + 1);
  }

  cmask = (chan == 0) ? 0 : 1 << (chan - 1);
@@ -1142,20 +1168,33 @@ static int
snd_c400_create_effect_ret_vol_ctls(struct usb_mixer_interface *mixer
  char name[64];
  unsigned int cmask;
  int chan, err;
+ int num_outs = 0;
+ int offset = 0;

  const unsigned int id = 0x40;
  const int val_type = USB_MIXER_S16;
  const int control = 1;
- const int chan_id[6] = { 0, 7, 2, 9, 4, 0xb };
- const unsigned int offset = 0x3c;
- /* { 0x3c, 0x43, 0x3e, 0x45, 0x40, 0x47 } */

- for (chan = 0; chan < 6; chan++) {
+ switch (mixer->chip->usb_id) {
+ case USB_ID(0x0763, 0x2030):
+ num_outs = 6;
+ offset = 0x3c;
+ /* { 0x3c, 0x43, 0x3e, 0x45, 0x40, 0x47 } */
+ break;
+ case USB_ID(0x0763, 0x2031):
+ num_outs = 8;
+ offset = 0x70;
+ /* { 0x70, 0x79, 0x72, 0x7b, 0x74, 0x7d, 0x76, 0x7f } */
+ break;
+ }
+
+ for (chan = 0; chan < num_outs; chan++) {
  snprintf(name, sizeof(name),
  "Effect Return %d",
  chan + 1);

- cmask = (chan_id[chan] == 0) ? 0 : 1 << (chan_id[chan] - 1);
+ cmask = (chan == 0) ? 0 :
+ 1 << (chan + (chan % 2) * num_outs - 1);
  err = snd_create_std_mono_ctl_offset(mixer, id, control,
  cmask, val_type, offset, name,
  &snd_usb_mixer_vol_tlv);
@@ -1299,6 +1338,7 @@ int snd_usb_mixer_apply_create_quirk(struct
usb_mixer_interface *mixer)
  break;

  case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
+ case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C400 */
  err = snd_c400_create_mixer(mixer);
  break;

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d82e378..749752a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -363,6 +363,7 @@ static int set_format(struct snd_usb_substream
*subs, struct audioformat *fmt)

  switch (subs->stream->chip->usb_id) {
  case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
+ case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
  if (is_playback) {
  implicit_fb = 1;
  ep = 0x81;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 64d25a7..4901400 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2326,6 +2326,77 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  }
 },
 {
+ USB_DEVICE_VENDOR_SPEC(0x0763, 0x2031),
+ .driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+ /* .vendor_name = "M-Audio", */
+ /* .product_name = "Fast Track C600", */
+ .ifnum = QUIRK_ANY_INTERFACE,
+ .type = QUIRK_COMPOSITE,
+ .data = &(const struct snd_usb_audio_quirk[]) {
+ {
+ .ifnum = 1,
+ .type = QUIRK_AUDIO_STANDARD_MIXER,
+ },
+ /* Playback */
+ {
+ .ifnum = 2,
+ .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+ .data = &(const struct audioformat) {
+ .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+ .channels = 8,
+ .iface = 2,
+ .altsetting = 1,
+ .altset_idx = 1,
+ .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+ .endpoint = 0x01,
+ .ep_attr = 0x09,
+ .rates = SNDRV_PCM_RATE_44100 |
+ SNDRV_PCM_RATE_48000 |
+ SNDRV_PCM_RATE_88200 |
+ SNDRV_PCM_RATE_96000,
+ .rate_min = 44100,
+ .rate_max = 96000,
+ .nr_rates = 4,
+ .rate_table = (unsigned int[]) {
+ 44100, 48000, 88200, 96000
+ },
+ .clock = 0x80,
+ }
+ },
+ /* Capture */
+ {
+ .ifnum = 3,
+ .type = QUIRK_AUDIO_FIXED_ENDPOINT,
+ .data = &(const struct audioformat) {
+ .formats = SNDRV_PCM_FMTBIT_S24_3LE,
+ .channels = 6,
+ .iface = 3,
+ .altsetting = 1,
+ .altset_idx = 1,
+ .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+ .endpoint = 0x81,
+ .ep_attr = 0x05,
+ .rates = SNDRV_PCM_RATE_44100 |
+ SNDRV_PCM_RATE_48000 |
+ SNDRV_PCM_RATE_88200 |
+ SNDRV_PCM_RATE_96000,
+ .rate_min = 44100,
+ .rate_max = 96000,
+ .nr_rates = 4,
+ .rate_table = (unsigned int[]) {
+ 44100, 48000, 88200, 96000
+ },
+ .clock = 0x80,
+ }
+ },
+ /* MIDI */
+ {
+ .ifnum = -1 /* Interface = 4 */
+ }
+ }
+ }
+},
+{
  USB_DEVICE_VENDOR_SPEC(0x0763, 0x2080),
  .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
  /* .vendor_name = "M-Audio", */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2c97185..7d7ad0b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -863,13 +863,14 @@ void snd_usb_endpoint_start_quirk(struct
snd_usb_endpoint *ep)
  ep->skip_packets = 4;

  /*
- * M-Audio Fast Track C400 - when packets are not skipped, real world
- * latency varies by approx. +/- 50 frames (at 96KHz) each time the
- * stream is (re)started. When skipping packets 16 at endpoint start
- * up, the real world latency is stable within +/- 1 frame (also
+ * M-Audio Fast Track C400/C600 - when packets are not skipped, real
+ * world latency varies by approx. +/- 50 frames (at 96KHz) each time
+ * the stream is (re)started. When skipping packets 16 at endpoint
+ * start up, the real world latency is stable within +/- 1 frame (also
  * across power cycles).
  */
- if (ep->chip->usb_id == USB_ID(0x0763, 0x2030) &&
+ if ((ep->chip->usb_id == USB_ID(0x0763, 0x2030) ||
+     ep->chip->usb_id == USB_ID(0x0763, 0x2031)) &&
     ep->type == SND_USB_ENDPOINT_TYPE_DATA)
  ep->skip_packets = 16;
 }
--
1.7.9.5
