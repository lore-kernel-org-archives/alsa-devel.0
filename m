From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 5/5] hda: compact ELD output messages
Date: Wed, 19 Nov 2008 15:14:03 +0800
Message-ID: <20081119072203.838628426@linux.intel.com>
References: <20081119071358.231716724@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F35B245C8
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:26:01 +0100 (CET)
Content-Disposition: inline; filename=alsa-compact-eld-dmesg.patch
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

Strip out some ELD printk messages that end user won't care,
and make the output compact.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c |   58 ++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -389,22 +389,27 @@ int snd_hdmi_get_eld(struct hdmi_eld *el
 static void hdmi_show_short_audio_desc(struct cea_sad *a)
 {
 	char buf[SND_PRINT_RATES_ADVISED_BUFSIZE];
+	char buf2[8 + SND_PRINT_BITS_ADVISED_BUFSIZE] = ", bits =";
 
-	printk(KERN_INFO "coding type: %s\n",
-					cea_audio_coding_type_names[a->format]);
-	printk(KERN_INFO "channels: %d\n", a->channels);
+	if (!a->format)
+		return;
 
 	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
-	printk(KERN_INFO "sampling rates: %s\n", buf);
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM)
-		printk(KERN_INFO "sample bits: 0x%x\n", a->sample_bits);
-
-	if (a->max_bitrate)
-		printk(KERN_INFO "max bitrate: %d\n", a->max_bitrate);
-
-	if (a->profile)
-		printk(KERN_INFO "profile: %d\n", a->profile);
+		snd_print_pcm_rates(a->sample_bits, buf2 + 8, sizeof(buf2 - 8));
+	else if (a->max_bitrate)
+		snprintf(buf2, sizeof(buf2),
+				", max bitrate = %d", a->max_bitrate);
+	else
+		buf2[0] = '\0';
+
+	printk(KERN_INFO "supports coding type %s:"
+			" channels = %d, rates =%s%s\n",
+			cea_audio_coding_type_names[a->format],
+			a->channels,
+			buf,
+			buf2);
 }
 
 void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
@@ -422,29 +427,16 @@ void snd_print_channel_allocation(int sp
 void snd_hdmi_show_eld(struct hdmi_eld *e)
 {
 	int i;
-	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 
-	printk(KERN_INFO "ELD buffer size  is %d\n", e->eld_size);
-	printk(KERN_INFO "ELD baseline len is %d*4\n", e->baseline_len);
-	printk(KERN_INFO "vendor block len is %d\n",
-					e->eld_size - e->baseline_len * 4 - 4);
-	printk(KERN_INFO "ELD version      is %s\n",
-					eld_versoin_names[e->eld_ver]);
-	printk(KERN_INFO "CEA EDID version is %s\n",
-				cea_edid_version_names[e->cea_edid_ver]);
-	printk(KERN_INFO "manufacture id   is 0x%x\n", e->manufacture_id);
-	printk(KERN_INFO "product id       is 0x%x\n", e->product_id);
-	printk(KERN_INFO "port id          is 0x%llx\n", (long long)e->port_id);
-	printk(KERN_INFO "HDCP support     is %d\n", e->support_hdcp);
-	printk(KERN_INFO "AI support       is %d\n", e->support_ai);
-	printk(KERN_INFO "SAD count        is %d\n", e->sad_count);
-	printk(KERN_INFO "audio sync delay is %x\n", e->aud_synch_delay);
-	printk(KERN_INFO "connection type  is %s\n",
-				eld_connection_type_names[e->conn_type]);
-	printk(KERN_INFO "monitor name     is %s\n", e->monitor_name);
-
-	snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
-	printk(KERN_INFO "speaker allocations: (0x%x)%s\n", e->spk_alloc, buf);
+	printk(KERN_INFO "detected monitor %s at connection type %s\n",
+			e->monitor_name,
+			eld_connection_type_names[e->conn_type]);
+
+	if (e->spk_alloc) {
+		char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
+		snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
+		printk(KERN_INFO "available speakers:%s\n", buf);
+	}
 
 	for (i = 0; i < e->sad_count; i++)
 		hdmi_show_short_audio_desc(e->sad + i);

-- 
