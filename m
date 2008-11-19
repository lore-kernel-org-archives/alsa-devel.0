From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 3/5] hda: minor output message cleanups
Date: Wed, 19 Nov 2008 15:14:01 +0800
Message-ID: <20081119072203.633722146@linux.intel.com>
References: <20081119071358.231716724@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C3CF245C1
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:26:00 +0100 (CET)
Content-Disposition: inline; filename=alsa-print-speakers-cleanup.patch
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

Some minor user visible message cleanups.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -118,7 +118,7 @@ static char *cea_audio_coding_type_names
 	/*  6 */ "AAC-LC",
 	/*  7 */ "DTS",
 	/*  8 */ "ATRAC",
-	/*  9 */ "DSD (1-bit audio)",
+	/*  9 */ "DSD (One Bit Audio)",
 	/* 10 */ "E-AC-3/DD+ (Dolby Digital Plus)",
 	/* 11 */ "DTS-HD",
 	/* 12 */ "MLP (Dolby TrueHD)",
@@ -395,7 +395,7 @@ static void hdmi_show_short_audio_desc(s
 	printk(KERN_INFO "channels: %d\n", a->channels);
 
 	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
-	printk(KERN_INFO "sampling frequencies: %s\n", buf);
+	printk(KERN_INFO "sampling rates: %s\n", buf);
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM)
 		printk(KERN_INFO "sample bits: 0x%x\n", a->sample_bits);
@@ -413,11 +413,9 @@ void snd_print_channel_allocation(int sp
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(cea_speaker_allocation_names); i++) {
 		if (spk_alloc & (1 << i))
-			j += snprintf(buf + j, buflen - j,  "%s ",
+			j += snprintf(buf + j, buflen - j,  " %s",
 					cea_speaker_allocation_names[i]);
 	}
-	if (j)
-		j--;	/* skip last space */
 	buf[j] = '\0';	/* necessary when j == 0 */
 }
 
@@ -464,11 +462,10 @@ static void hdmi_print_sad_info(int i, s
 	snd_iprintf(buffer, "sad%d_channels\t\t%d\n", i, a->channels);
 
 	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
-	snd_iprintf(buffer, "sad%d_sampling_rates\t[0x%x] %s\n",
-			i, a->rates, buf);
+	snd_iprintf(buffer, "sad%d_rates\t\t[0x%x]%s\n", i, a->rates, buf);
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM)
-		snd_iprintf(buffer, "sad%d_sample_bits\t0x%x\n",
+		snd_iprintf(buffer, "sad%d_bits\t\t0x%x\n",
 							i, a->sample_bits);
 
 	if (a->max_bitrate)
@@ -501,7 +498,7 @@ static void hdmi_print_eld_info(struct s
 	snd_iprintf(buffer, "audio_sync_delay\t%d\n", e->aud_synch_delay);
 
 	snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
-	snd_iprintf(buffer, "speakers\t\t[0x%x] %s\n", e->spk_alloc, buf);
+	snd_iprintf(buffer, "speakers\t\t[0x%x]%s\n", e->spk_alloc, buf);
 
 	snd_iprintf(buffer, "sad_count\t\t%d\n", e->sad_count);
 

-- 
