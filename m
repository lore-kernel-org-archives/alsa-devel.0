From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 32/38] bebob: Prepare for device specific operations
Date: Fri, 20 Dec 2013 22:14:23 +0900
Message-ID: <1387545269-3875-33-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit is for some devices which have its own operations or quirks.

Many functionality should be implemented in user land. Then this commit adds
functionality related to stream such as sampling frequency or clock source. For
help to debug, this commit adds the functionality to get metering information
if it's available.

To help these functionalities, this commit adds some AV/C commands defined in
'AV/C Audio Subunit Specification (1394TA).

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile        |  3 +-
 sound/firewire/bebob/bebob.c         | 60 +++++++++++++++++----------
 sound/firewire/bebob/bebob.h         | 33 ++++++++++++++-
 sound/firewire/bebob/bebob_command.c | 79 ++++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_pcm.c     |  3 +-
 sound/firewire/bebob/bebob_proc.c    | 61 +++++++++++++++++++++++++---
 sound/firewire/bebob/bebob_stream.c  | 26 +++++++++---
 7 files changed, 229 insertions(+), 36 deletions(-)

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 7808777..e4b08e3 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,3 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
-		  bebob_pcm.o bebob_hwdep.o \
-		  bebob.o
+		  bebob_pcm.o bebob_hwdep.o bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 881bd1d..4ce8121 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -128,6 +128,7 @@ bebob_probe(struct fw_unit *unit,
 {
 	struct snd_card *card;
 	struct snd_bebob *bebob;
+	const struct snd_bebob_spec *spec;
 	unsigned int card_index;
 	int err;
 
@@ -142,6 +143,12 @@ bebob_probe(struct fw_unit *unit,
 		goto end;
 	}
 
+	spec = (const struct snd_bebob_spec *)entry->driver_data;
+	if (spec == NULL) {
+		err = -ENOSYS;
+		goto end;
+	}
+
 	err = snd_card_create(index[card_index], id[card_index],
 			THIS_MODULE, sizeof(struct snd_bebob), &card);
 	if (err < 0)
@@ -153,6 +160,7 @@ bebob_probe(struct fw_unit *unit,
 	bebob->device = fw_parent_device(unit);
 	bebob->unit = unit;
 	bebob->card_index = -1;
+	bebob->spec = spec;
 	mutex_init(&bebob->mutex);
 	spin_lock_init(&bebob->lock);
 	init_waitqueue_head(&bebob->hwdep_wait);
@@ -221,52 +229,62 @@ static void bebob_remove(struct fw_unit *unit)
 	snd_card_free_when_closed(bebob->card);
 }
 
+struct snd_bebob_rate_spec normal_rate_spec = {
+	.get	= &snd_bebob_stream_get_rate,
+	.set	= &snd_bebob_stream_set_rate
+};
+static const struct snd_bebob_spec spec_normal = {
+	.clock	= NULL,
+	.rate	= &normal_rate_spec,
+	.meter	= NULL
+};
+
 static const struct ieee1394_device_id bebob_id_table[] = {
 	/* Edirol, FA-66 */
-	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010049),
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010049, &spec_normal),
 	/* Edirol, FA-101 */
-	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010048, &spec_normal),
 	/* Presonus, FIREBOX */
-	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010000),
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010000, &spec_normal),
 	/* PreSonus, FIREPOD */
-	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010066),
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010066, &spec_normal),
 	/* PreSonus, Inspire1394 */
-	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010001),
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010001, &spec_normal),
 	/* BridgeCo, RDAudio1 */
-	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010048, &spec_normal),
 	/* BridgeCo, Audio5 */
-	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049),
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049, &spec_normal),
 	/* Mackie, Onyx 820/1220/1620/1640 (Firewire I/O Card) */
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065),
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065, &spec_normal),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067, &spec_normal),
 	/* Mackie, d.2 (Firewire Option) */
-	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067),
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067, &spec_normal),
 	/* Stanton, ScratchAmp */
-	SND_BEBOB_DEV_ENTRY(VEN_STANTON, 0x00000001),
+	SND_BEBOB_DEV_ENTRY(VEN_STANTON, 0x00000001, &spec_normal),
 	/* Tascam, IF-FW DM */
-	SND_BEBOB_DEV_ENTRY(VEN_TASCAM, 0x00010067),
+	SND_BEBOB_DEV_ENTRY(VEN_TASCAM, 0x00010067, &spec_normal),
 	/* ApogeeElectronics, Rosetta 200/400 (X-FireWire card) */
 	/* ApogeeElectronics, DA/AD/DD-16X (X-FireWire card) */
-	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048, &spec_normal),
 	/* ESI, Quatafire610 */
-	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064),
+	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064, &spec_normal),
 	/* AcousticReality, eARMasterOne */
-	SND_BEBOB_DEV_ENTRY(VEN_ACOUSTIC, 0x00000002),
+	SND_BEBOB_DEV_ENTRY(VEN_ACOUSTIC, 0x00000002, &spec_normal),
 	/* CME, MatrixKFW */
-	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000),
+	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000, &spec_normal),
 	/* Phonic, HB 12/12 MkII/12 Universal */
 	/* Phonic, HB 18/18 MkII/18 Universal */
 	/* Phonic, HB 24/24 MkII/24 Universal */
 	/* Phonic, FireFly 202/302 */
-	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000),
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000, &spec_normal),
 	/* Lynx, Aurora 8/16 (LT-FW) */
-	SND_BEBOB_DEV_ENTRY(VEN_LYNX, 0x00000001),
+	SND_BEBOB_DEV_ENTRY(VEN_LYNX, 0x00000001, &spec_normal),
 	/* ICON, FireXon */
-	SND_BEBOB_DEV_ENTRY(VEN_ICON, 0x00000001),
+	SND_BEBOB_DEV_ENTRY(VEN_ICON, 0x00000001, &spec_normal),
 	/* PrismSound, Orpheus */
-	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x00010048),
+	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x00010048, &spec_normal),
 	/* PrismSound, ADA-8XR */
-	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x0000ada8),
+	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x0000ada8, &spec_normal),
 	/* Ids are unknown but able to be supported */
 	/*  Mackie, Digital X Bus x.200 */
 	/*  Mackie, Digital X Bus x.400 */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index d06f3f3..7ff89fa 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -48,6 +48,28 @@ struct snd_bebob_stream_formation {
 /* this is a lookup table for index of stream formations */
 extern const unsigned int snd_bebob_rate_table[SND_BEBOB_STRM_FMT_ENTRIES];
 
+/* device specific operations */
+#define SND_BEBOB_CLOCK_INTERNAL	"Internal"
+struct snd_bebob_clock_spec {
+	unsigned int num;
+	char **labels;
+	int (*get)(struct snd_bebob *bebob, unsigned int *id);
+};
+struct snd_bebob_rate_spec {
+	int (*get)(struct snd_bebob *bebob, unsigned int *rate);
+	int (*set)(struct snd_bebob *bebob, unsigned int rate);
+};
+struct snd_bebob_meter_spec {
+	unsigned int num;
+	char **labels;
+	int (*get)(struct snd_bebob *bebob, u32 *target, unsigned int size);
+};
+struct snd_bebob_spec {
+	struct snd_bebob_clock_spec *clock;
+	struct snd_bebob_rate_spec *rate;
+	struct snd_bebob_meter_spec *meter;
+};
+
 struct snd_bebob {
 	struct snd_card *card;
 	struct fw_device *device;
@@ -57,6 +79,8 @@ struct snd_bebob {
 	struct mutex mutex;
 	spinlock_t lock;
 
+	const struct snd_bebob_spec *spec;
+
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
@@ -94,6 +118,12 @@ snd_bebob_read_quad(struct fw_unit *unit, u64 addr, u32 *buf)
 				  (void *)buf, sizeof(u32), 0);
 }
 
+/* AV/C Audio Subunit Specification 1.0 (Oct 2000, 1394TA) */
+int avc_audio_set_selector(struct fw_unit *unit, unsigned int subunit_id,
+			   unsigned int fb_id, unsigned int num);
+int avc_audio_get_selector(struct fw_unit *unit, unsigned  int subunit_id,
+			   unsigned int fb_id, unsigned int *num);
+
 /*
  * AVC command extensions, AV/C Unit and Subunit, Revision 17
  * (Nov 2003, BridgeCo)
@@ -197,12 +227,13 @@ int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 
 int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 
-#define SND_BEBOB_DEV_ENTRY(vendor, model) \
+#define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
 			  IEEE1394_MATCH_MODEL_ID, \
 	.vendor_id	= vendor, \
 	.model_id	= model, \
+	.driver_data	= (kernel_ulong_t)data \
 }
 
 #endif
diff --git a/sound/firewire/bebob/bebob_command.c b/sound/firewire/bebob/bebob_command.c
index 22a86d0..c63c6d8 100644
--- a/sound/firewire/bebob/bebob_command.c
+++ b/sound/firewire/bebob/bebob_command.c
@@ -11,6 +11,85 @@
 #define BEBOB_COMMAND_MAX_TRIAL	3
 #define BEBOB_COMMAND_WAIT_MSEC	100
 
+int avc_audio_set_selector(struct fw_unit *unit, unsigned int subunit_id,
+			   unsigned int fb_id, unsigned int num)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0]  = 0x00;		/* AV/C CONTROL */
+	buf[1]  = 0x08 | (0x07 & subunit_id);	/* AUDIO SUBUNIT ID */
+	buf[2]  = 0xb8;		/* FUNCTION BLOCK  */
+	buf[3]  = 0x80;		/* type is 'selector'*/
+	buf[4]  = 0xff & fb_id;	/* function block id */
+	buf[5]  = 0x10;		/* control attribute is CURRENT */
+	buf[6]  = 0x02;		/* selector length is 2 */
+	buf[7]  = 0xff & num;	/* input function block plug number */
+	buf[8]  = 0x01;		/* control selector is SELECTOR_CONTROL */
+
+	/* do transaction and check buf[1-8] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(7) | BIT(8));
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x09)) {
+		dev_err(&unit->device,
+			"failed to set selector %d: 0x%02X\n",
+			fb_id, buf[0]);
+		err = -EIO;
+		goto end;
+	}
+end:
+	kfree(buf);
+	return err;
+}
+
+int avc_audio_get_selector(struct fw_unit *unit, unsigned int subunit_id,
+			   unsigned int fb_id, unsigned int *num)
+{
+	u8 *buf;
+	int err;
+
+	buf = kzalloc(12, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	buf[0]  = 0x01;		/* AV/C STATUS */
+	buf[1]  = 0x08 | (0x07 & subunit_id);	/* AUDIO SUBUNIT ID */
+	buf[2]  = 0xb8;		/* FUNCTION BLOCK */
+	buf[3]  = 0x80;		/* type is 'selector'*/
+	buf[4]  = 0xff & fb_id;	/* function block id */
+	buf[5]  = 0x10;		/* control attribute is CURRENT */
+	buf[6]  = 0x02;		/* selector length is 2 */
+	buf[7]  = 0xff;		/* input function block plug number */
+	buf[8]  = 0x01;		/* control selector is SELECTOR_CONTROL */
+
+	/* do transaction and check buf[1-6,8] are the same against command */
+	err = fcp_avc_transaction(unit, buf, 12, buf, 12,
+				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+				  BIT(6) | BIT(8));
+	if (err < 0)
+		goto end;
+	if ((err < 6) || (buf[0] != 0x0c)) {
+		dev_err(&unit->device,
+			"failed to get selector %d: 0x%02X\n",
+			fb_id, buf[0]);
+		err = -EIO;
+		goto end;
+	}
+
+	*num = buf[7];
+	err = 0;
+end:
+	kfree(buf);
+	return err;
+}
+
 static inline void
 avc_bridgeco_fill_command_base(u8 *buf, unsigned int ctype, unsigned int opcode,
 			       unsigned int subfunction,
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 525c4ac..83f2225 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -235,6 +235,7 @@ static int
 pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_bebob *bebob = substream->private_data;
+	struct snd_bebob_rate_spec *spec = bebob->spec->rate;
 	unsigned int sampling_rate;
 	bool internal;
 	int err;
@@ -258,7 +259,7 @@ pcm_open(struct snd_pcm_substream *substream)
 	if (!internal ||
 	    amdtp_stream_pcm_running(&bebob->tx_stream) ||
 	    amdtp_stream_pcm_running(&bebob->rx_stream)) {
-		err = snd_bebob_stream_get_rate(bebob, &sampling_rate);
+		err = spec->get(bebob, &sampling_rate);
 		if (err < 0)
 			goto err_locked;
 
diff --git a/sound/firewire/bebob/bebob_proc.c b/sound/firewire/bebob/bebob_proc.c
index 40099a5..b8ad4b8 100644
--- a/sound/firewire/bebob/bebob_proc.c
+++ b/sound/firewire/bebob/bebob_proc.c
@@ -72,6 +72,42 @@ end:
 }
 
 static void
+proc_read_meters(struct snd_info_entry *entry,
+		 struct snd_info_buffer *buffer)
+{
+	struct snd_bebob *bebob = entry->private_data;
+	struct snd_bebob_meter_spec *spec = bebob->spec->meter;
+	u32 *buf;
+	unsigned int i, c, channels, size;
+	int err;
+
+	if (spec == NULL)
+		return;
+
+	channels = spec->num * 2;
+	size = channels * sizeof(u32);
+	buf = kmalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return;
+
+	err = spec->get(bebob, buf, size);
+	if (err < 0)
+		goto end;
+
+	for (i = 0, c = 1; i < channels; i++) {
+		snd_iprintf(buffer, "%s %d:\t%d\n",
+			    spec->labels[i / 2], c++, buf[i]);
+		if ((i + 1 < channels - 1) &&
+		    (strcmp(spec->labels[i / 2],
+			    spec->labels[(i + 1) / 2]) != 0))
+			c = 1;
+	}
+end:
+	kfree(buf);
+	return;
+}
+
+static void
 proc_read_formation(struct snd_info_entry *entry,
 		struct snd_info_buffer *buffer)
 {
@@ -105,18 +141,26 @@ proc_read_clock(struct snd_info_entry *entry,
 		struct snd_info_buffer *buffer)
 {
 	struct snd_bebob *bebob = entry->private_data;
+	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	unsigned int rate;
 	bool internal;
+	unsigned int id;
 
 	if (snd_bebob_stream_get_rate(bebob, &rate) < 0)
 		return;
-	if (snd_bebob_stream_check_internal_clock(bebob, &internal) < 0)
-		return;
-
-	snd_iprintf(buffer, "Clock Source: %s (MSU-dest: %d)",
-		    (internal) ? "Internal" : "External",
-		    bebob->sync_input_plug);
 	snd_iprintf(buffer, "Sampling rate: %d\n", rate);
+
+	if (!clk_spec) {
+		if (snd_bebob_stream_check_internal_clock(bebob, &internal) < 0)
+			return;
+		snd_iprintf(buffer, "Clock Source: %s (MSU-dest: %d)\n",
+			    (internal) ? "Internal" : "External",
+			    bebob->sync_input_plug);
+	} else {
+		if (clk_spec->get(bebob, &id) < 0)
+			return;
+		snd_iprintf(buffer, "Clock Source: %s\n", clk_spec->labels[id]);
+	}
 }
 
 void snd_bebob_proc_init(struct snd_bebob *bebob)
@@ -132,5 +176,10 @@ void snd_bebob_proc_init(struct snd_bebob *bebob)
 	if (!snd_card_proc_new(bebob->card, "#clock", &entry))
 		snd_info_set_text_ops(entry, bebob, proc_read_clock);
 
+	if (bebob->spec->meter != NULL) {
+		if (!snd_card_proc_new(bebob->card, "#meter", &entry))
+			snd_info_set_text_ops(entry, bebob, proc_read_meters);
+	}
+
 	return;
 }
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 533d49a..76be74b 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -90,13 +90,26 @@ end:
 int
 snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 {
+	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	u8 addr[AVC_BRIDGECO_ADDR_BYTES], input[7];
+	unsigned int id;
 	int err = 0;
 
 	*internal = false;
 
+	/* 1.The device has its own operation to switch source of clock */
+	if (clk_spec) {
+		err = clk_spec->get(bebob, &id);
+		if (err < 0)
+			goto end;
+		if (strncmp(clk_spec->labels[id], SND_BEBOB_CLOCK_INTERNAL,
+			    strlen(SND_BEBOB_CLOCK_INTERNAL)) == 0)
+			*internal = true;
+		goto end;
+	}
+
 	/*
-	 * 1.The device don't support for switching source of clock
+	 * 2.The device don't support for switching source of clock
 	 *   then assumed to use internal clock always
 	 */
 	if (bebob->sync_input_plug < 0) {
@@ -105,7 +118,7 @@ snd_bebob_stream_check_internal_clock(struct snd_bebob *bebob, bool *internal)
 	}
 
 	/*
-	 * 2.The device supports to switch source of clock by an usual way.
+	 * 3.The device supports to switch source of clock by an usual way.
 	 *   Let's check input for 'Music Sub Unit Sync Input' plug.
 	 */
 	avc_bridgeco_fill_subunit_addr(addr, 0x60, AVC_BRIDGECO_PLUG_DIR_IN,
@@ -380,6 +393,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 				  struct amdtp_stream *request,
 				  unsigned int rate)
 {
+	struct snd_bebob_rate_spec *rate_spec = bebob->spec->rate;
 	struct amdtp_stream *master, *slave;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
@@ -413,7 +427,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 	}
 
 	/* get current rate */
-	err = snd_bebob_stream_get_rate(bebob, &curr_rate);
+	err = rate_spec->get(bebob, &curr_rate);
 	if (err < 0)
 		goto end;
 	if (rate == 0)
@@ -443,7 +457,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 		 * If establishing connections at first, Yamaha GO46
 		 * (and maybe Terratec X24) don't generate sound.
 		 */
-		err = snd_bebob_stream_set_rate(bebob, rate);
+		err = rate_spec->set(bebob, rate);
 		if (err < 0)
 			goto end;
 
@@ -694,6 +708,7 @@ end:
 int snd_bebob_stream_discover(struct snd_bebob *bebob)
 {
 	u8 plugs[AVC_PLUG_INFO_BUF_COUNT], addr[AVC_BRIDGECO_ADDR_BYTES];
+	struct snd_bebob_clock_spec *clk_spec = bebob->spec->clock;
 	enum avc_bridgeco_plug_type type;
 	unsigned int i;
 	int err;
@@ -767,7 +782,8 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob)
 	}
 
 	/* for check source of clock later */
-	err = seek_msu_sync_input_plug(bebob);
+	if (!clk_spec)
+		err = seek_msu_sync_input_plug(bebob);
 end:
 	return err;
 }
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
