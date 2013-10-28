From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Mon, 28 Oct 2013 22:35:56 +0200
Message-ID: <526ECAAC.306@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <s5hli1imfsi.wl%tiwai@suse.de> <20131025165452.GA89428@deflower.internal>
 <526AA924.5070508@iki.fi> <20131028175206.GA70365@localhost>
 <526EA91B.3090607@iki.fi> <20131028181743.GA70502@localhost>
 <526EAC12.5000905@iki.fi> <20131028183554.GB70502@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080707050808050807040503"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E74F260320
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 21:36:02 +0100 (CET)
In-Reply-To: <20131028183554.GB70502@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andre Heider <a.heider@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080707050808050807040503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

28.10.2013 20:35, Andre Heider kirjoitti:
> On Mon, Oct 28, 2013 at 08:25:22PM +0200, Anssi Hannula wrote:
>> 28.10.2013 20:17, Andre Heider kirjoitti:
>>> On Mon, Oct 28, 2013 at 08:12:43PM +0200, Anssi Hannula wrote:
>>>> 28.10.2013 19:52, Andre Heider kirjoitti:
>>>>> On Fri, Oct 25, 2013 at 08:23:48PM +0300, Anssi Hannula wrote:
>>>>>> 25.10.2013 19:54, Andre Heider kirjoitti:
>>>>>>> cat /proc/asound/card0/eld\#0.0
>>>>>>> 	monitor_present		1
>>>>>>> 	eld_valid		0
>>>>>>
>>>>>> However, this should have eld_valid=1 and contain more info. To get a
>>>>>> hint on whether it is a bug in audio or video driver, could you give a
>>>>>> log with CONFIG_SND_DEBUG ?
>>>>>>
>>>>>> AFAICS the sound git master tree should have the necessary support in
>>>>>> the radeon video driver to allow the audio driver to generate a valid
>>>>>> ELD with your card.
>>>>>
>>>>> With CONFIG_SND_DEBUG=y I get a bunch of
>>>>> "HDMI ATI/AMD: no speaker allocation for ELD"
>>>>> but afaics that's about it.
>>>>
>>>> Thanks, that is exactly what I was looking for.
>>>>
>>>> Looks like a radeon driver issue - it does not seem to setup the speaker
>>>> allocation registers properly (so that ALSA could read them from there),
>>>> and I verified that the EDID you posted has a valid speaker allocation
>>>> byte 0x4f.
>>>>
>>>> Just to recheck - you are running sound git master, or something else?
>>>
>>> This is from 3.12-rc7 with today's sound/master (3fbdaf9b) merged on top.
>>>
>>
>> Ah, OK, that certainly explains it. 3.12-x has this one:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/radeon?id=555b1b651acf44bf27ebbb04235d38a8fd2d58dc
>>
>> Could you revert that for testing, just to see if you get proper ELD
>> info then?
> 
> Blergh, guess that's my fault for not just using sound/master.
> 
> But that looks better:
> 
> cat /proc/asound/card0/eld\#0.0
> 	monitor_present		1
> 	eld_valid		1
> 	monitor_name		
> 	connection_type		HDMI
> 	eld_version		[0x2] CEA-861D or below
> 	edid_version		[0x0] no CEA EDID Timing Extension block present
> 	manufacture_id		0x0
> 	product_id		0x0
> 	port_id			0x0
> 	support_hdcp		0
> 	support_ai		0
> 	audio_sync_delay	0
> 	speakers		[0x4f] FL/FR LFE FC RL/RR RLC/RRC
> 	sad_count		4
> 	sad0_coding_type	[0x1] LPCM
> 	sad0_channels		2
> 	sad0_rates		[0x1ee0] 32000 44100 48000 88200 96000 176400 192000
> 	sad0_bits		[0xe0000] 16 20 24

Thanks.

Hmm, seems we have bug in the radeon driver, we are missing the
8-channel PCM SAD here.

Can you try the attached patch?

> 	sad1_coding_type	[0x2] AC-3
> 	sad1_channels		8
> 	sad1_rates		[0xe0] 32000 44100 48000
> 	sad1_max_bitrate	640000
> 	sad2_coding_type	[0x6] AAC-LC
> 	sad2_channels		8
> 	sad2_rates		[0xe0] 32000 44100 48000
> 	sad2_max_bitrate	640000
> 	sad3_coding_type	[0x7] DTS
> 	sad3_channels		8
> 	sad3_rates		[0xe0] 32000 44100 48000
> 	sad3_max_bitrate	1536000


-- 
Anssi Hannula

--------------080707050808050807040503
Content-Type: text/x-patch;
 name="0001-drm-radeon-audio-fix-missing-multichannel-PCM-SAD-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-radeon-audio-fix-missing-multichannel-PCM-SAD-in.pa";
 filename*1="tch"

>From e9b1708c50a5679eabf0af9489b1a3265e2081bb Mon Sep 17 00:00:00 2001
From: Anssi Hannula <anssi.hannula@iki.fi>
Date: Mon, 28 Oct 2013 22:18:10 +0200
Subject: [PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in some
 cases

The current code writing SADs to the audio registers seems to assume
that there is at most a single SAD per audio format.

However, that is not the case. Especially for PCM it is somewhat common
for sinks to have two SADs, one for 8-channel and one for 2-channel
audio, which may have different supported sample rates (i.e. the sink
supports stereo audio at higher sample rates than multichannel audio).
While multiple SADs per non-PCM audio format is also allowed, I have not
seen this and it would indeed not be useful in normal circumstances.

Because of this, only the 2-channel SAD may be used if it appears before
the 8-channel SAD.

Fix the code to pick the PCM SAD with the highest number of channels,
while merging the rate masks of PCM SADs with lower amount of channels
into the stereo rate mask.

Reported-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>

---
 drivers/gpu/drm/radeon/dce6_afmt.c      | 20 +++++++++++++++-----
 drivers/gpu/drm/radeon/evergreen_hdmi.c | 20 +++++++++++++++-----
 drivers/gpu/drm/radeon/r600_hdmi.c      | 20 +++++++++++++++-----
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/radeon/dce6_afmt.c b/drivers/gpu/drm/radeon/dce6_afmt.c
index 85a69d2..0a0fcee 100644
--- a/drivers/gpu/drm/radeon/dce6_afmt.c
+++ b/drivers/gpu/drm/radeon/dce6_afmt.c
@@ -198,20 +198,30 @@ void dce6_afmt_write_sad_regs(struct drm_encoder *encoder)
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
 		u32 value = 0;
+		u8 stereo_freqs = 0;
+		int max_channels = -1;
 		int j;
 
 		for (j = 0; j < sad_count; j++) {
 			struct cea_sad *sad = &sads[j];
 
 			if (sad->format == eld_reg_to_type[i][1]) {
-				value = MAX_CHANNELS(sad->channels) |
-					DESCRIPTOR_BYTE_2(sad->byte2) |
-					SUPPORTED_FREQUENCIES(sad->freq);
+				if (sad->channels > max_channels) {
+					value = MAX_CHANNELS(sad->channels) |
+						DESCRIPTOR_BYTE_2(sad->byte2) |
+						SUPPORTED_FREQUENCIES(sad->freq);
+					max_channels = sad->channels;
+				}
+
 				if (sad->format == HDMI_AUDIO_CODING_TYPE_PCM)
-					value |= SUPPORTED_FREQUENCIES_STEREO(sad->freq);
-				break;
+					stereo_freqs |= sad->freq;
+				else
+					break;
 			}
 		}
+
+		value |= SUPPORTED_FREQUENCIES_STEREO(stereo_freqs);
+
 		WREG32_ENDPOINT(offset, eld_reg_to_type[i][0], value);
 	}
 
diff --git a/drivers/gpu/drm/radeon/evergreen_hdmi.c b/drivers/gpu/drm/radeon/evergreen_hdmi.c
index f71ce39..2a4837d 100644
--- a/drivers/gpu/drm/radeon/evergreen_hdmi.c
+++ b/drivers/gpu/drm/radeon/evergreen_hdmi.c
@@ -139,20 +139,30 @@ static void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder)
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
 		u32 value = 0;
+		u8 stereo_freqs = 0;
+		int max_channels = -1;
 		int j;
 
 		for (j = 0; j < sad_count; j++) {
 			struct cea_sad *sad = &sads[j];
 
 			if (sad->format == eld_reg_to_type[i][1]) {
-				value = MAX_CHANNELS(sad->channels) |
-					DESCRIPTOR_BYTE_2(sad->byte2) |
-					SUPPORTED_FREQUENCIES(sad->freq);
+				if (sad->channels > max_channels) {
+					value = MAX_CHANNELS(sad->channels) |
+						DESCRIPTOR_BYTE_2(sad->byte2) |
+						SUPPORTED_FREQUENCIES(sad->freq);
+					max_channels = sad->channels;
+				}
+
 				if (sad->format == HDMI_AUDIO_CODING_TYPE_PCM)
-					value |= SUPPORTED_FREQUENCIES_STEREO(sad->freq);
-				break;
+					stereo_freqs |= sad->freq;
+				else
+					break;
 			}
 		}
+
+		value |= SUPPORTED_FREQUENCIES_STEREO(stereo_freqs);
+
 		WREG32(eld_reg_to_type[i][0], value);
 	}
 
diff --git a/drivers/gpu/drm/radeon/r600_hdmi.c b/drivers/gpu/drm/radeon/r600_hdmi.c
index f443010..da5cfa4 100644
--- a/drivers/gpu/drm/radeon/r600_hdmi.c
+++ b/drivers/gpu/drm/radeon/r600_hdmi.c
@@ -364,20 +364,30 @@ static void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder)
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
 		u32 value = 0;
+		u8 stereo_freqs = 0;
+		int max_channels = -1;
 		int j;
 
 		for (j = 0; j < sad_count; j++) {
 			struct cea_sad *sad = &sads[j];
 
 			if (sad->format == eld_reg_to_type[i][1]) {
-				value = MAX_CHANNELS(sad->channels) |
-					DESCRIPTOR_BYTE_2(sad->byte2) |
-					SUPPORTED_FREQUENCIES(sad->freq);
+				if (sad->channels > max_channels) {
+					value = MAX_CHANNELS(sad->channels) |
+						DESCRIPTOR_BYTE_2(sad->byte2) |
+						SUPPORTED_FREQUENCIES(sad->freq);
+					max_channels = sad->channels;
+				}
+
 				if (sad->format == HDMI_AUDIO_CODING_TYPE_PCM)
-					value |= SUPPORTED_FREQUENCIES_STEREO(sad->freq);
-				break;
+					stereo_freqs |= sad->freq;
+				else
+					break;
 			}
 		}
+
+		value |= SUPPORTED_FREQUENCIES_STEREO(stereo_freqs);
+
 		WREG32(eld_reg_to_type[i][0], value);
 	}
 
-- 
1.8.1.5


--------------080707050808050807040503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080707050808050807040503--
