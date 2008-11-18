From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 0/3] HDMI ELD routines and proc interface
Date: Tue, 18 Nov 2008 11:47:50 +0800
Message-ID: <20081118034750.445933681@linux.intel.com>
Content-Type: multipart/mixed; boundary="===============3202015516683135062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id DEAE324465
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 05:26:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============3202015516683135062==

Hi Takashi,

Here are the patches for separated HDMI ELD routines and proc interface.
They have undergone basic tests on a G45 board and stress test with the
patch below.

	[PATCH 1/3] introduce snd_print_pcm_rates()
	[PATCH 2/3] create hda_eld.c for ELD routines and proc interface
	[PATCH 3/3] ELD proc interface for HDMI sinks

Here are two sample outputs from the stress testing:

	monitor name
	connection_type         2-reserved
	eld_version             [0x0] reserved
	edid_version            [0x0] no CEA EDID Timing Extension block present
	manufacture_id          0x3c93
	product_id              0xc5ac
	port_id                 0x486d85d5a3bfe049
	support_hdcp            1
	support_ai              0
	audio_sync_delay        152
	speakers                [0x6f] FL/FR LFE FC RL/RR FLC/FRC RLC/RRC
	sad_count               8
	sad0_coding_type        [0x0] undefined
	sad0_channels           0
	sad0_sampling_rates     [0x0]
	sad1_coding_type        [0x0] undefined
	sad1_channels           0
	sad1_sampling_rates     [0x0]
	sad2_coding_type        [0x0] undefined
	sad2_channels           0
	sad2_sampling_rates     [0x0]
	sad3_coding_type        [0x0] undefined
	sad3_channels           0
	sad3_sampling_rates     [0x0]
	sad4_coding_type        [0x0] undefined
	sad4_channels           0
	sad4_sampling_rates     [0x0]
	sad5_coding_type        [0x0] undefined
	sad5_channels           0
	sad5_sampling_rates     [0x0]
	sad6_coding_type        [0x0] undefined
	sad6_channels           0
	sad6_sampling_rates     [0x0]
	sad7_coding_type        [0x0] undefined
	sad7_channels           0
	sad7_sampling_rates     [0x0]

	monitor name            �����p
	connection_type         Display Port
	eld_version             [0x0] reserved
	edid_version            [0x7] reserved
	manufacture_id          0x59c7
	product_id              0x3c72
	port_id                 0x323d7444a5fcbdba
	support_hdcp            0
	support_ai              1
	audio_sync_delay        268
	speakers                [0x33] FL/FR LFE RC FLC/FRC
	sad_count               14
	sad0_coding_type        [0x9] DSD (1-bit audio)
	sad0_channels           5
	sad0_sampling_rates     [0xe40] 48000 176400 192000 384000
	sad1_coding_type        [0x6] AAC-LC
	sad1_channels           2
	sad1_sampling_rates     [0x18a0] 44100 88200 384000
	sad1_max_bitrate        1024000
	sad2_coding_type        [0xc] MLP (Dolby TrueHD)
	sad2_channels           8
	sad2_sampling_rates     [0x1ec0] 48000 88200 176400 192000 384000
	sad3_coding_type        [0x8] ATRAC
	sad3_channels           3
	sad3_sampling_rates     [0x1220] 44100 176400
	sad3_max_bitrate        944000
	sad4_coding_type        [0xd] DST
	sad4_channels           3
	sad4_sampling_rates     [0xac0] 48000 88200 176400 384000
	sad5_coding_type        [0x2] AC-3
	sad5_channels           3
	sad5_sampling_rates     [0x1a60] 44100 48000 176400 384000
	sad5_max_bitrate        592000
	sad6_coding_type        [0xc] MLP (Dolby TrueHD)
	sad6_channels           3
	sad6_sampling_rates     [0xc40] 48000 192000 384000
	sad7_coding_type        [0x9] DSD (1-bit audio)
	sad7_channels           6
	sad7_sampling_rates     [0xc20] 44100 192000 384000
	sad8_coding_type        [0x5] MPEG2
	sad8_channels           1
	sad8_sampling_rates     [0x1ac0] 48000 88200 176400 384000
	sad8_max_bitrate        544000
	sad9_coding_type        [0xc] MLP (Dolby TrueHD)
	sad9_channels           7
	sad9_sampling_rates     [0x460] 44100 48000 192000
	sad10_coding_type       [0x1] LPCM
	sad10_channels          4
	sad10_sampling_rates    [0x1260] 44100 48000 176400
	sad10_sample_bits       0x40000
	sad11_coding_type       [0x6] AAC-LC
	sad11_channels          7
	sad11_sampling_rates    [0x1240] 48000 176400
	sad11_max_bitrate       408000
	sad12_coding_type       [0x0] undefined
	sad12_channels          0
	sad12_sampling_rates    [0x0]
	sad13_coding_type       [0x0] undefined
	sad13_channels          0
	sad13_sampling_rates    [0x0]

Thank you,
Fengguang
---

stress testing patch for ELD routines

 sound/pci/hda/hda_eld.c         |   30 ++++++++++++++++++++----------
 sound/pci/hda/patch_intelhdmi.c |    2 ++
 2 files changed, 22 insertions(+), 10 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -27,6 +27,15 @@
 #include "hda_codec.h"
 #include "hda_local.h"

+static unsigned long rand;
+
+static inline unsigned char random(void)
+{
+	/* See "Numerical Recipes in C", second edition, p. 284 */
+	rand = rand * 1664525L + 1013904223L;
+	return (unsigned char) (rand >> 24);
+}
+
 enum eld_versions {
 	ELD_VER_CEA_861D	= 2,
 	ELD_VER_PARTIAL		= 31,
@@ -167,6 +176,8 @@ static unsigned char hdmi_get_eld_byte(s
 	val = snd_hda_codec_read(codec, nid, 0,
 					AC_VERB_GET_HDMI_ELDD, byte_index);

+	val = AC_ELDD_ELD_VALID | random();
+
 #ifdef BE_PARANOID
 	printk(KERN_INFO "ELD data byte %d: 0x%x\n", byte_index, val);
 #endif
@@ -277,7 +288,6 @@ static int hdmi_update_sink_eld(struct s
 	if (e->eld_ver != ELD_VER_CEA_861D &&
 	    e->eld_ver != ELD_VER_PARTIAL) {
 		snd_printd(KERN_INFO "Unknown ELD version %d\n", e->eld_ver);
-		goto out_fail;
 	}

 	e->eld_size = size;
@@ -359,9 +369,6 @@ int snd_hdmi_get_eld(struct sink_eld *el
 	int size;
 	unsigned char *buf;

-	if (!hdmi_eld_valid(codec, nid))
-		return -ENOENT;
-
 	size = snd_hdmi_get_eld_size(codec, nid);
 	if (size == 0) {
 		/* wfg: workaround for ASUS P5E-VM HDMI board */
@@ -516,6 +523,9 @@ int snd_hda_eld_proc_new(struct hda_code
 	struct snd_info_entry *entry;
 	int err;

+	/* Initialize random number generator */
+	rand = jiffies;
+
 	snprintf(name, sizeof(name), "eld#%d", codec->addr);
 	err = snd_card_proc_new(codec->bus->card, name, &entry);
 	if (err < 0)
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -635,6 +635,8 @@ static int patch_intel_hdmi(struct hda_c

 	init_channel_allocations();

+	hdmi_parse_eld(codec);
+
 	return 0;
 }


--===============3202015516683135062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3202015516683135062==--
