From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: [PATCH 4/4] AC97 wm9713 support
Date: Fri, 25 Feb 2005 14:23:42 +0000
Message-ID: <1109341422.30473.677.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uwMz8tqYW57aIG/pvWfD"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-uwMz8tqYW57aIG/pvWfD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is against ac97_patch.c/h

Changes:-

  o Added basic wm9713 support for playback and record

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>


--=-uwMz8tqYW57aIG/pvWfD
Content-Disposition: attachment; filename=ac97_patch.diff
Content-Type: text/x-patch; name=ac97_patch.diff; charset=
Content-Transfer-Encoding: 7bit

diff -u -r1.75 ac97_patch.c
--- pci/ac97/ac97_patch.c	23 Feb 2005 14:04:02 -0000	1.75
+++ pci/ac97/ac97_patch.c	24 Feb 2005 16:49:55 -0000
@@ -305,6 +305,132 @@
 	return 0;
 }
 
+static const char* wm9713_mic_mixer[] = {"Stereo", "Mic1", "Mic2", "Mute"};
+static const char* wm9713_rec_mux[] = {"Stereo", "Left", "Right", "Mute"};
+static const char* wm9713_rec_src_l[] = {"Mic1", "Mic2", "Line L", "Mono In", "HP Mix L", "Spk Mix", "Mono Mix", "Zh"};
+static const char* wm9713_rec_src_r[] = {"Mic1", "Mic2", "Line R", "Mono In", "HP Mix R", "Spk Mix", "Mono Mix", "Zh"};
+
+static const struct ac97_enum wm9713_enum[] = {
+AC97_ENUM(AC97_LINE, 3, 0, 4, wm9713_mic_mixer),
+AC97_ENUM(AC97_VIDEO, 14, 0, 4, wm9713_rec_mux),
+AC97_ENUM(AC97_VIDEO, 9, 0, 4, wm9713_rec_mux),
+AC97_ENUM(AC97_VIDEO, 3, 0, 8, wm9713_rec_src_l),
+AC97_ENUM(AC97_VIDEO, 0, 0, 8, wm9713_rec_src_r),
+};
+
+static const snd_kcontrol_new_t wm13_snd_ac97_controls_line_in[] = {
+AC97_DOUBLE("Line In Volume", AC97_PC_BEEP, 8, 0, 31, 1),
+AC97_SINGLE("Line In to Headphone Mute", AC97_PC_BEEP, 15, 1, 1),
+AC97_SINGLE("Line In to Speaker Mute", AC97_PC_BEEP, 14, 1, 1),
+AC97_SINGLE("Line In to Mono Mute", AC97_PC_BEEP, 13, 1, 1),
+};
+
+static const snd_kcontrol_new_t wm13_snd_ac97_controls_dac[] = {
+AC97_DOUBLE("DAC Volume", AC97_PHONE, 8, 0, 31, 1),
+AC97_SINGLE("DAC to Headphone Mute", AC97_PHONE, 15, 1, 1),
+AC97_SINGLE("DAC to Speaker Mute", AC97_PHONE, 14, 1, 1),
+AC97_SINGLE("DAC to Mono Mute", AC97_PHONE, 13, 1, 1),
+};
+
+static const snd_kcontrol_new_t wm13_snd_ac97_controls_mic[] = {
+AC97_SINGLE("MICA Volume", AC97_MIC, 8, 31, 1),
+AC97_SINGLE("MICB Volume", AC97_MIC, 0, 31, 1),
+AC97_SINGLE("MICA to Mono Mute", AC97_LINE, 7, 1, 1),
+AC97_SINGLE("MICB to Mono Mute", AC97_LINE, 6, 1, 1),
+AC97_SINGLE("MIC Boost (+20dB)", AC97_LINE, 5, 1, 1),
+AC97_ENUM_SINGLE("MIC Headphone Routing", wm9713_enum[0]),
+AC97_SINGLE("MIC Headphone Mixer Volume", AC97_LINE, 0, 7, 1)
+};
+
+static const snd_kcontrol_new_t wm13_snd_ac97_controls_adc[] = {
+AC97_SINGLE("ADC Mute", AC97_CD, 15, 1, 1),
+AC97_DOUBLE("Gain Step Size (1.5dB/0.75dB)", AC97_CD, 14, 6, 1, 1),
+AC97_DOUBLE("ADC Volume",AC97_CD, 8, 0, 15, 0),
+AC97_SINGLE("ADC Zero Cross", AC97_CD, 7, 1, 1),
+};
+
+static const snd_kcontrol_new_t wm13_snd_ac97_controls_recsel[] = {
+AC97_ENUM_SINGLE("Record to Headphone Path", wm9713_enum[1]),
+AC97_SINGLE("Record to Headphone Volume", AC97_VIDEO, 11, 7, 0),
+AC97_ENUM_SINGLE("Record to Mono Path", wm9713_enum[2]),
+AC97_SINGLE("Record to Mono Boost (+20dB)", AC97_VIDEO, 8, 1, 0),
+AC97_SINGLE("Record ADC Boost (+20dB)", AC97_VIDEO, 6, 1, 0),
+AC97_ENUM_SINGLE("Record Select Left", wm9713_enum[3]),
+AC97_ENUM_SINGLE("Record Select Right", wm9713_enum[4]),
+};
+
+static int patch_wolfson_wm9713_specific(ac97_t * ac97)
+{
+	int err, i;
+	
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_line_in); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_line_in[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97, AC97_PC_BEEP, 0x0808);
+	
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_dac); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_dac[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97, AC97_PHONE, 0x0808);
+	
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_mic); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_mic[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97, AC97_MIC, 0x0808);
+	snd_ac97_write_cache(ac97, AC97_LINE, 0x00da);
+	
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_adc); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_adc[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97, AC97_CD, 0x0808);
+	
+	for (i = 0; i < ARRAY_SIZE(wm13_snd_ac97_controls_recsel); i++) {
+		if ((err = snd_ctl_add(ac97->bus->card, snd_ac97_cnew(&wm13_snd_ac97_controls_recsel[i], ac97))) < 0)
+			return err;
+	}
+	snd_ac97_write_cache(ac97, AC97_VIDEO, 0xd612);
+	snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x1ba0);
+	
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int patch_wolfson_wm9713_suspend (ac97_t * ac97)
+{
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_MID, 0xfeff);
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0xffff);
+}
+
+static int patch_wolfson_wm9713_resume (ac97_t * ac97)
+{
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_MID, 0xda00);
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0x3810);
+	snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0x0);
+}
+#endif
+
+static struct snd_ac97_build_ops patch_wolfson_wm9713_ops = {
+	.build_specific = patch_wolfson_wm9713_specific,
+#ifdef CONFIG_PM	
+	.suspend = patch_wolfson_wm9713_suspend,
+	.resume = patch_wolfson_wm9713_resume
+#endif
+};
+
+int patch_wolfson13(ac97_t * ac97)
+{
+	ac97->build_ops = &patch_wolfson_wm9713_ops;
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_MID, 0xda00);
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0x3810);
+	snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0x0);
+
+	return 0;
+}
+
 /*
  * Tritech codec
  */
diff -u -r1.19 ac97_patch.h
--- pci/ac97/ac97_patch.h	16 Feb 2005 18:27:19 -0000	1.19
+++ pci/ac97/ac97_patch.h	24 Feb 2005 16:49:55 -0000
@@ -28,6 +28,7 @@
 int patch_wolfson04(ac97_t * ac97);
 int patch_wolfson05(ac97_t * ac97);
 int patch_wolfson11(ac97_t * ac97);
+int patch_wolfson13(ac97_t * ac97);
 int patch_tritech_tr28028(ac97_t * ac97);
 int patch_sigmatel_stac9700(ac97_t * ac97);
 int patch_sigmatel_stac9708(ac97_t * ac97);

--=-uwMz8tqYW57aIG/pvWfD--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
