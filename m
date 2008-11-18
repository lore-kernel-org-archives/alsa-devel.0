From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 3/4] hda: HDMI channel allocations for audio
	infoframe
Date: Tue, 18 Nov 2008 16:57:16 +0800
Message-ID: <20081118085809.151205160@linux.intel.com>
References: <20081118085713.252457834@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 429291037EF
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:58:30 +0100 (CET)
Content-Disposition: inline; filename=alsa-speakers.patch
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

To play a 3+ channels LPCM/DSD stream via HDMI,

	- HDMI sink must tell HDMI source about its speaker placements
	  (via ELD, speaker-allocation field)
	- HDMI source must tell the HDMI sink about channel allocation
	  (via audio infoframe, channel-allocation field)

(related docs: HDMI 1.3a spec section 7.4, CEA-861-D section 7.5.3 and 6.6)

This patch attempts to set the CA(channel-allocation) byte in the audio infoframe
according to
	- the number of channels in the current stream
	- the speakers attached to the HDMI sink

A channel_allocations[] line must meet the following two criterions to be
considered as a valid candidate for CA:
	1) its number of allocated channels = substream->runtime->channels
	2) its speakers are a subset of the available ones on the sink side

If there are multiple candidates, the first one is selected.  This simple
policy shall cheat the sink into playing music, but may direct data to the
wrong speakers.

Sorry, this last step is not obvious to me. Any domain experts, please?

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |  189 ++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -89,6 +89,118 @@ struct hdmi_audio_infoframe {
 };
 
 /*
+ * CEA speaker placement:
+ *
+ *        FLH       FCH        FRH
+ *  FLW    FL  FLC   FC   FRC   FR   FRW
+ *
+ *                                  LFE
+ *                     TC
+ *
+ *          RL  RLC   RC   RRC   RR
+ */
+enum cea_speaker_placement {
+	FL  = (1 <<  0),	/* Front Left           */
+	FC  = (1 <<  1),	/* Front Center         */
+	FR  = (1 <<  2),	/* Front Right          */
+	FLC = (1 <<  3),	/* Front Left Center    */
+	FRC = (1 <<  4),	/* Front Right Center   */
+	RL  = (1 <<  5),	/* Rear Left            */
+	RC  = (1 <<  6),	/* Rear Center          */
+	RR  = (1 <<  7),	/* Rear Right           */
+	RLC = (1 <<  8),	/* Rear Left Center     */
+	RRC = (1 <<  9),	/* Rear Right Center    */
+	LFE = (1 << 10),	/* Low Frequency Effect */
+	FLW = (1 << 11),	/* Front Left Wide      */
+	FRW = (1 << 12),	/* Front Right Wide     */
+	FLH = (1 << 13),	/* Front Left High      */
+	FCH = (1 << 14),	/* Front Center High    */
+	FRH = (1 << 15),	/* Front Right High     */
+	TC  = (1 << 16),	/* Top Center           */
+};
+
+/*
+ * ELD SA bits in the CEA Speaker Allocation data block
+ */
+static int eld_speaker_allocation_bits[] = {
+	[0] = FL | FR,
+	[1] = LFE,
+	[2] = FC,
+	[3] = RL | RR,
+	[4] = RC,
+	[5] = FLC | FRC,
+	[6] = RLC | RRC,
+	/* the following are not defined in ELD yet */
+	[7] = FLW | FRW,
+	[8] = FLH | FRH,
+	[9] = TC,
+	[10] = FCH,
+};
+
+struct cea_channel_speaker_allocation {
+	int ca_index;
+	int speakers[8];
+
+	/* derived values, just for convenience */
+	int channels;
+	int spk_mask;
+};
+
+static struct cea_channel_speaker_allocation channel_allocations[] = {
+/* channel number:  8      7     6     5     4      3     2     1 */
+	{0x00,  {   0,     0,    0,    0,    0,     0,   FR,   FL } },
+	{0x01,  {   0,     0,    0,    0,    0,   LFE,   FR,   FL } },
+	{0x02,  {   0,     0,    0,    0,   FC,     0,   FR,   FL } },
+	{0x03,  {   0,     0,    0,    0,   FC,   LFE,   FR,   FL } },
+	{0x04,  {   0,     0,    0,   RC,    0,     0,   FR,   FL } },
+	{0x05,  {   0,     0,    0,   RC,    0,   LFE,   FR,   FL } },
+	{0x06,  {   0,     0,    0,   RC,   FC,     0,   FR,   FL } },
+	{0x07,  {   0,     0,    0,   RC,   FC,   LFE,   FR,   FL } },
+	{0x08,  {   0,     0,   RR,   RL,    0,     0,   FR,   FL } },
+	{0x09,  {   0,     0,   RR,   RL,    0,   LFE,   FR,   FL } },
+	{0x0a,  {   0,     0,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x0b,  {   0,     0,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x0c,  {   0,    RC,   RR,   RL,    0,     0,   FR,   FL } },
+	{0x0d,  {   0,    RC,   RR,   RL,    0,   LFE,   FR,   FL } },
+	{0x0e,  {   0,    RC,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x0f,  {   0,    RC,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x10,  { RRC,   RLC,   RR,   RL,    0,     0,   FR,   FL } },
+	{0x11,  { RRC,   RLC,   RR,   RL,    0,   LFE,   FR,   FL } },
+	{0x12,  { RRC,   RLC,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x13,  { RRC,   RLC,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x14,  { FRC,   FLC,    0,    0,    0,     0,   FR,   FL } },
+	{0x15,  { FRC,   FLC,    0,    0,    0,   LFE,   FR,   FL } },
+	{0x16,  { FRC,   FLC,    0,    0,   FC,     0,   FR,   FL } },
+	{0x17,  { FRC,   FLC,    0,    0,   FC,   LFE,   FR,   FL } },
+	{0x18,  { FRC,   FLC,    0,   RC,    0,     0,   FR,   FL } },
+	{0x19,  { FRC,   FLC,    0,   RC,    0,   LFE,   FR,   FL } },
+	{0x1a,  { FRC,   FLC,    0,   RC,   FC,     0,   FR,   FL } },
+	{0x1b,  { FRC,   FLC,    0,   RC,   FC,   LFE,   FR,   FL } },
+	{0x1c,  { FRC,   FLC,   RR,   RL,    0,     0,   FR,   FL } },
+	{0x1d,  { FRC,   FLC,   RR,   RL,    0,   LFE,   FR,   FL } },
+	{0x1e,  { FRC,   FLC,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x1f,  { FRC,   FLC,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x20,  {   0,   FCH,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x21,  {   0,   FCH,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x22,  {  TC,     0,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x23,  {  TC,     0,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x24,  { FRH,   FLH,   RR,   RL,    0,     0,   FR,   FL } },
+	{0x25,  { FRH,   FLH,   RR,   RL,    0,   LFE,   FR,   FL } },
+	{0x26,  { FRW,   FLW,   RR,   RL,    0,     0,   FR,   FL } },
+	{0x27,  { FRW,   FLW,   RR,   RL,    0,   LFE,   FR,   FL } },
+	{0x28,  {  TC,    RC,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x29,  {  TC,    RC,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x2a,  { FCH,    RC,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x2b,  { FCH,    RC,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x2c,  {  TC,   FCH,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x2d,  {  TC,   FCH,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x2e,  { FRH,   FLH,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x2f,  { FRH,   FLH,   RR,   RL,   FC,   LFE,   FR,   FL } },
+	{0x30,  { FRW,   FLW,   RR,   RL,   FC,     0,   FR,   FL } },
+	{0x31,  { FRW,   FLW,   RR,   RL,   FC,   LFE,   FR,   FL } },
+};
+
+/*
  * HDMI routines
  */
 
@@ -260,6 +372,79 @@ static void hdmi_fill_audio_infoframe(st
 		hdmi_write_dip_byte(codec, PIN_NID, params[i]);
 }
 
+/*
+ * Compute derived values in channel_allocations[].
+ */
+static void init_channel_allocations(void)
+{
+	int i, j;
+	struct cea_channel_speaker_allocation *p;
+
+	for (i = 0; i < ARRAY_SIZE(channel_allocations); i++) {
+		p = channel_allocations + i;
+		for (j = 0; j < ARRAY_SIZE(p->speakers); j++)
+			if (p->speakers[j]) {
+				p->channels++;
+				p->spk_mask |= p->speakers[j];
+			}
+	}
+}
+
+/*
+ * The transformation takes two steps:
+ *
+ * 	eld->spk_alloc => (eld_speaker_allocation_bits[]) => spk_mask
+ * 	      spk_mask => (channel_allocations[])         => ai->CA
+ *
+ * TODO: it could select the wrong CA from multiple candidates.
+*/
+static int hdmi_setup_channel_allocation(struct hda_codec *codec,
+					 struct hdmi_audio_infoframe *ai)
+{
+	struct intel_hdmi_spec *spec = codec->spec;
+	struct sink_eld *eld = &spec->sink;
+	int i;
+	int spk_mask = 0;
+	int channels = 1 + (ai->CC02_CT47 & 0x7);
+	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
+
+	/*
+	 * CA defaults to 0 for basic stereo audio
+	 */
+	if (!eld->eld_ver)
+		return 0;
+	if (!eld->spk_alloc)
+		return 0;
+	if (channels <= 2)
+		return 0;
+
+	/*
+	 * expand ELD's speaker allocation mask
+	 *
+	 * ELD tells the speaker mask in a compact(paired) form,
+	 * expand ELD's notions to match the ones used by audio infoframe.
+	 */
+	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
+		if (eld->spk_alloc & (1 << i))
+			spk_mask |= eld_speaker_allocation_bits[i];
+	}
+
+	/* search for the first working match in the CA table */
+	for (i = 0; i < ARRAY_SIZE(channel_allocations); i++) {
+		if (channels == channel_allocations[i].channels &&
+		    (spk_mask & channel_allocations[i].spk_mask) ==
+				channel_allocations[i].spk_mask) {
+			ai->CA = channel_allocations[i].ca_index;
+			return 0;
+		}
+	}
+
+	snd_print_channel_allocation(eld->spk_alloc, buf, sizeof(buf));
+	snd_printd(KERN_INFO "failed to setup channel allocation: %d of %s\n",
+			channels, buf);
+	return -1;
+}
+
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 					struct snd_pcm_substream *substream)
 {
@@ -270,6 +455,8 @@ static void hdmi_setup_audio_infoframe(s
 		.CC02_CT47	= substream->runtime->channels - 1,
 	};
 
+	hdmi_setup_channel_allocation(codec, &ai);
+
 	hdmi_fill_audio_infoframe(codec, &ai);
 }
 
@@ -455,6 +642,8 @@ static int patch_intel_hdmi(struct hda_c
 
 	snd_hda_eld_proc_new(codec, &spec->sink);
 
+	init_channel_allocations();
+
 	return 0;
 }
 

-- 
