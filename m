From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/2] sst: Remove the aava bits
Date: Thu, 14 Oct 2010 16:59:53 +0100
Message-ID: <20101014155950.27495.57496.stgit@localhost.localdomain>
References: <20101014155933.27495.51005.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 41B0A103B7F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 18:51:50 +0200 (CEST)
In-Reply-To: <20101014155933.27495.51005.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

From: Alan Cox <alan@linux.intel.com>

We don't need these special cases any more.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/intel_sst/TODO                  |    5 
 drivers/staging/intel_sst/intelmid.c            |   17 -
 drivers/staging/intel_sst/intelmid_v1_control.c |  454 +++++++----------------
 3 files changed, 146 insertions(+), 330 deletions(-)


diff --git a/drivers/staging/intel_sst/TODO b/drivers/staging/intel_sst/TODO
index 58d6d2d..a24e5ed 100644
--- a/drivers/staging/intel_sst/TODO
+++ b/drivers/staging/intel_sst/TODO
@@ -2,11 +2,12 @@ TODO
 ----
 
 Get the memrar driver cleaned up and upstream (dependancy blocking SST)
-Get the jack header entries accepted
+Replace long/short press with two virtual buttons
 Review the printks and kill off any left over ST_ERR: messages
 Review the misc device ioctls for 32/64bit safety and sanity
 Review the misc device ioctls for size safety depending on config and decide
 	if space/unused areas should be left
+What the sound folks turn up on full review
+Using the ALSA frameworks properly
 
-Anything the sound folks turn up on full review
 
diff --git a/drivers/staging/intel_sst/intelmid.c b/drivers/staging/intel_sst/intelmid.c
index 63138b3..4c0264c 100644
--- a/drivers/staging/intel_sst/intelmid.c
+++ b/drivers/staging/intel_sst/intelmid.c
@@ -639,7 +639,7 @@ void sst_mad_jackdetection_mx(u8 intsts, struct snd_intelmad *intelmaddata)
 					jack = &intelmaddata->jack[3].jack;
 					present = 1;
 					jack_event_flag = 1;
-				}	else	{
+				} else {
 					pr_debug("sst: short press detected\n");
 					/* send headphone detect/undetect */
 					jack = &intelmaddata->jack[2].jack;
@@ -649,21 +649,8 @@ void sst_mad_jackdetection_mx(u8 intsts, struct snd_intelmad *intelmaddata)
 			}
 
 		}
-		intelmaddata->jack_prev_state  = value ;
-
-	}
-	if (is_aava() && jack) {
-		if (present) {
-			pr_debug("sst: Jack... YES\n");
-			scard_ops->set_output_dev(STEREO_HEADPHONE);
-
-		} else {
-			pr_debug("sst: Jack... NO\n");
-			scard_ops->set_output_dev(INTERNAL_SPKR);
-
-		}
+		intelmaddata->jack_prev_state = value;
 	}
-
 	if (jack_event_flag)
 		sst_mad_send_jack_report(jack, buttonpressflag, present);
 }
diff --git a/drivers/staging/intel_sst/intelmid_v1_control.c b/drivers/staging/intel_sst/intelmid_v1_control.c
index 94d30a9..9de86b2 100644
--- a/drivers/staging/intel_sst/intelmid_v1_control.c
+++ b/drivers/staging/intel_sst/intelmid_v1_control.c
@@ -76,131 +76,60 @@ enum _reg_v2 {
  */
 static int mx_init_card(void)
 {
-	if (is_aava())  {
-
-		struct sc_reg_access sc_access[] = {
-			{0x200, 0x00, 0x0},
-			{0x201, 0xC0, 0x0},
-			{0x202, 0x00, 0x0},
-			{0x203, 0x00, 0x0},
-			{0x204, 0x0e, 0x0},
-			{0x205, 0x20, 0x0},
-			{0x206, 0x00, 0x0},
-			{0x207, 0x00, 0x0},
-			{0x208, 0x00, 0x0},
-			{0x209, 0x51, 0x0},
-			{0x20a, 0x00, 0x0},
-			{0x20b, 0x5a, 0x0},
-			{0x20c, 0xbe, 0x0},
-			{0x20d, 0x90, 0x0},
-			{0x20e, 0x51, 0x0},
-			{0x20f, 0x00, 0x0},
-			{0x210, 0x21, 0x0},
-			{0x211, 0x00, 0x0},
-			{0x212, 0x00, 0x0},
-			{0x213, 0x00, 0x0},
-			{0x214, 0x41, 0x0},
-			{0x215, 0x81, 0x0},
-			{0x216, 0x00, 0x0},
-			{0x217, 0x00, 0x0},
-			{0x218, 0x00, 0x0},
-			{0x219, 0x00, 0x0},
-			{0x21a, 0x00, 0x0},
-			{0x21b, 0x00, 0x0},
-			{0x21c, 0x00, 0x0},
-			{0x21d, 0x00, 0x0},
-			{0x21e, 0x00, 0x0},
-			{0x21f, 0x00, 0x0},
-			{0x220, 0x00, 0x0},
-			{0x221, 0x00, 0x0},
-			{0x222, 0x51, 0x0},
-			{0x223, 0x20, 0x0}, /* Jack detection: 00 -> 01 */
-			{0x224, 0x40, 0x0},
-			{0x225, 0x80, 0x0}, /* JAck detection: 00 -> 80 */
-			{0x226, 0x00, 0x0},
-			{0x227, 0x00, 0x0},
-			{0xf9, 0x40, 0x0},
-			{0xfa, 0x1F, 0x0},
-			{0xfb, 0x1F, 0x0},
-			{0xfc, 0x1F, 0x0},
-			{0xfd, 0x1F, 0x0},
-			{0xfe, 0x00, 0x0},
-			{0xff, 0x00, 0x0}, /* Removed sel_output */
-		};
-		int retval;
-
-		/*init clock sig to voice codec*/
-		retval = gpio_request(KOSKI_VOICE_CODEC_ENABLE,
-					"sound_voice_codec");
-		if (retval) {
-			pr_err("sst: Error enabling voice codec clock\n");
-		} else {
-			gpio_direction_output(KOSKI_VOICE_CODEC_ENABLE, 1);
-			pr_debug("sst: Voice codec clock enabled\n");
-		}
-
-		snd_pmic_ops_mx.card_status = SND_CARD_INIT_DONE;
-		snd_pmic_ops_mx.master_mute = UNMUTE;
-		snd_pmic_ops_mx.mute_status = UNMUTE;
-		snd_pmic_ops_mx.num_channel = 2;
-		pr_debug("**************inside aava\n");
-		return sst_sc_reg_access(sc_access, PMIC_WRITE, 47);
-	} else {
-		struct sc_reg_access sc_access[] = {
-			{0x200, 0x80, 0x00},
-			{0x201, 0xC0, 0x00},
-			{0x202, 0x00, 0x00},
-			{0x203, 0x00, 0x00},
-			{0x204, 0x02, 0x00},
-			{0x205, 0x10, 0x00},
-			{0x206, 0x60, 0x00},
-			{0x207, 0x00, 0x00},
-			{0x208, 0x90, 0x00},
-			{0x209, 0x51, 0x00},
-			{0x20a, 0x00, 0x00},
-			{0x20b, 0x10, 0x00},
-			{0x20c, 0x00, 0x00},
-			{0x20d, 0x00, 0x00},
-			{0x20e, 0x21, 0x00},
-			{0x20f, 0x00, 0x00},
-			{0x210, 0x84, 0x00},
-			{0x211, 0xB3, 0x00},
-			{0x212, 0x00, 0x00},
-			{0x213, 0x00, 0x00},
-			{0x214, 0x41, 0x00},
-			{0x215, 0x00, 0x00},
-			{0x216, 0x00, 0x00},
-			{0x217, 0x00, 0x00},
-			{0x218, 0x03, 0x00},
-			{0x219, 0x03, 0x00},
-			{0x21a, 0x00, 0x00},
-			{0x21b, 0x00, 0x00},
-			{0x21c, 0x00, 0x00},
-			{0x21d, 0x00, 0x00},
-			{0x21e, 0x00, 0x00},
-			{0x21f, 0x00, 0x00},
-			{0x220, 0x20, 0x00},
-			{0x221, 0x20, 0x00},
-			{0x222, 0x51, 0x00},
-			{0x223, 0x20, 0x00},
-			{0x224, 0x04, 0x00},
-			{0x225, 0x80, 0x00},
-			{0x226, 0x0F, 0x00},
-			{0x227, 0x08, 0x00},
-			{0xf9,  0x40, 0x00},
-			{0xfa,  0x1f, 0x00},
-			{0xfb,  0x1f, 0x00},
-			{0xfc,  0x1f, 0x00},
-			{0xfd,  0x1f, 0x00},
-			{0xfe,  0x00, 0x00},
-			{0xff,  0x0c, 0x00},
-		};
-		snd_pmic_ops_mx.card_status = SND_CARD_INIT_DONE;
-		snd_pmic_ops_mx.num_channel = 2;
-		snd_pmic_ops_mx.master_mute = UNMUTE;
-		snd_pmic_ops_mx.mute_status = UNMUTE;
-		return sst_sc_reg_access(sc_access, PMIC_WRITE, 47);
-	}
+	struct sc_reg_access sc_access[] = {
+		{0x200, 0x80, 0x00},
+		{0x201, 0xC0, 0x00},
+		{0x202, 0x00, 0x00},
+		{0x203, 0x00, 0x00},
+		{0x204, 0x02, 0x00},
+		{0x205, 0x10, 0x00},
+		{0x206, 0x60, 0x00},
+		{0x207, 0x00, 0x00},
+		{0x208, 0x90, 0x00},
+		{0x209, 0x51, 0x00},
+		{0x20a, 0x00, 0x00},
+		{0x20b, 0x10, 0x00},
+		{0x20c, 0x00, 0x00},
+		{0x20d, 0x00, 0x00},
+		{0x20e, 0x21, 0x00},
+		{0x20f, 0x00, 0x00},
+		{0x210, 0x84, 0x00},
+		{0x211, 0xB3, 0x00},
+		{0x212, 0x00, 0x00},
+		{0x213, 0x00, 0x00},
+		{0x214, 0x41, 0x00},
+		{0x215, 0x00, 0x00},
+		{0x216, 0x00, 0x00},
+		{0x217, 0x00, 0x00},
+		{0x218, 0x03, 0x00},
+		{0x219, 0x03, 0x00},
+		{0x21a, 0x00, 0x00},
+		{0x21b, 0x00, 0x00},
+		{0x21c, 0x00, 0x00},
+		{0x21d, 0x00, 0x00},
+		{0x21e, 0x00, 0x00},
+		{0x21f, 0x00, 0x00},
+		{0x220, 0x20, 0x00},
+		{0x221, 0x20, 0x00},
+		{0x222, 0x51, 0x00},
+		{0x223, 0x20, 0x00},
+		{0x224, 0x04, 0x00},
+		{0x225, 0x80, 0x00},
+		{0x226, 0x0F, 0x00},
+		{0x227, 0x08, 0x00},
+		{0xf9,  0x40, 0x00},
+		{0xfa,  0x1f, 0x00},
+		{0xfb,  0x1f, 0x00},
+		{0xfc,  0x1f, 0x00},
+		{0xfd,  0x1f, 0x00},
+		{0xfe,  0x00, 0x00},
+		{0xff,  0x0c, 0x00},
+	};
+	snd_pmic_ops_mx.card_status = SND_CARD_INIT_DONE;
+	snd_pmic_ops_mx.num_channel = 2;
+	snd_pmic_ops_mx.master_mute = UNMUTE;
+	snd_pmic_ops_mx.mute_status = UNMUTE;
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, 47);
 }
 
 static int mx_init_capture_card(void)
@@ -300,8 +229,6 @@ static int mx_power_up_pb(unsigned int port)
 		if (retval)
 			return retval;
 	}
-	if ((is_aava()) && port == 1)
-		mx_init_playback_card();
 	retval = mx_enable_audiodac(MUTE);
 	if (retval)
 		return retval;
@@ -372,13 +299,7 @@ static int mx_power_up_cp(unsigned int port)
 			return retval;
 	}
 
-	if (is_aava()) {
-		retval = mx_init_capture_card();
-		if (retval)
-			return retval;
-		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
-	} else
-		return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	return sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
 }
 
 static int mx_power_down_cp(void)
@@ -499,181 +420,101 @@ static int mx_set_pcm_audio_params(int sfreq, int word_size, int num_channel)
 {
 	int retval = 0;
 
-	if (!is_aava()) {
-		int config1 = 0, config2 = 0, filter = 0xB3;
-		struct sc_reg_access sc_access[5];
-
-		if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
-			retval = mx_init_card();
-			if (retval)
-				return retval;
-		}
-
-		switch (sfreq) {
-		case 8000:
-			config1 = 0x10;
-			config2 = 0x00;
-			filter = 0x33;
-			break;
-		case 11025:
-			config1 = 0x16;
-			config2 = 0x0d;
-			break;
-		case 12000:
-			config1 = 0x18;
-			config2 = 0x00;
-			break;
-		case 16000:
-			config1 = 0x20;
-			config2 = 0x00;
-			break;
-		case 22050:
-			config1 = 0x2c;
-			config2 = 0x1a;
-			break;
-		case 24000:
-			config1 = 0x30;
-			config2 = 0x00;
-			break;
-		case 32000:
-			config1 = 0x40;
-			config2 = 0x00;
-			break;
-		case 44100:
-			config1 = 0x58;
-			config2 = 0x33;
-			break;
-		case 48000:
-			config1 = 0x60;
-			config2 = 0x00;
-			break;
-		}
-
-		snd_pmic_ops_mx.num_channel = num_channel;
-		/*mute the right channel if MONO*/
-		if (snd_pmic_ops_mx.num_channel == 1)	{
-
-			sc_access[0].reg_addr = VOL_CTRL_RT;
-			sc_access[0].value = 0x40;
-			sc_access[0].mask = MASK6;
-
-			sc_access[1].reg_addr = 0x224;
-			sc_access[1].value = 0x05;
-			sc_access[1].mask = MASK0|MASK1|MASK2;
-
-			retval = sst_sc_reg_access(sc_access,
-					PMIC_READ_MODIFY, 2);
-			if (retval)
-				return retval;
-		} else {
-			sc_access[0].reg_addr = VOL_CTRL_RT;
-			sc_access[0].value = 0x00;
-			sc_access[0].mask = MASK6;
-
-			sc_access[1].reg_addr = 0x224;
-			sc_access[1].value = 0x04;
-			sc_access[1].mask = MASK0|MASK1|MASK2;
+	int config1 = 0, config2 = 0, filter = 0xB3;
+	struct sc_reg_access sc_access[5];
 
-			retval = sst_sc_reg_access(sc_access,
-					PMIC_READ_MODIFY, 2);
-			if (retval)
-				return retval;
-		}
-		sc_access[0].reg_addr =	0x206;
-		sc_access[0].value = config1;
-		sc_access[1].reg_addr = 0x207;
-		sc_access[1].value = config2;
-
-		if (word_size == 16) {
-			sc_access[2].value = 0x51;
-			sc_access[3].value = 0x31;
-		} else if (word_size == 24) {
-			sc_access[2].value = 0x52;
-			sc_access[3].value = 0x92;
-		}
+	if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
+		retval = mx_init_card();
+		if (retval)
+			return retval;
+	}
 
-		sc_access[2].reg_addr = 0x209;
-		sc_access[3].reg_addr = 0x20e;
+	switch (sfreq) {
+	case 8000:
+		config1 = 0x10;
+		config2 = 0x00;
+		filter = 0x33;
+		break;
+	case 11025:
+		config1 = 0x16;
+		config2 = 0x0d;
+		break;
+	case 12000:
+		config1 = 0x18;
+		config2 = 0x00;
+		break;
+	case 16000:
+		config1 = 0x20;
+		config2 = 0x00;
+		break;
+	case 22050:
+		config1 = 0x2c;
+		config2 = 0x1a;
+		break;
+	case 24000:
+		config1 = 0x30;
+		config2 = 0x00;
+		break;
+	case 32000:
+		config1 = 0x40;
+		config2 = 0x00;
+		break;
+	case 44100:
+		config1 = 0x58;
+		config2 = 0x33;
+		break;
+	case 48000:
+		config1 = 0x60;
+		config2 = 0x00;
+		break;
+	}
+	snd_pmic_ops_mx.num_channel = num_channel;
+	/*mute the right channel if MONO*/
+	if (snd_pmic_ops_mx.num_channel == 1)	{
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		sc_access[0].value = 0x40;
+		sc_access[0].mask = MASK6;
 
-		sc_access[4].reg_addr = 0x211;
-		sc_access[4].value = filter;
+		sc_access[1].reg_addr = 0x224;
+		sc_access[1].value = 0x05;
+		sc_access[1].mask = MASK0|MASK1|MASK2;
 
-		return sst_sc_reg_access(sc_access, PMIC_WRITE, 5);
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+		if (retval)
+			return retval;
 	} else {
-		int config1 = 0, config2 = 0, filter = 0x00;
-		struct sc_reg_access sc_access[5];
-
-		pr_debug("sst: mx_set_pcm_audio_params - inside AAVA\n");
-
-		if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT) {
-			retval = mx_init_card();
-			if (retval)
-				return retval;
-		}
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
 
-		switch (sfreq) {
-		case 8000:
-			config1 = 0x20;
-			config2 = 0x0f;
-			filter = 0x33;
-			break;
-		case 11025:
-			config1 = 0x14;
-			config2 = 0xd8;
-			break;
-		case 12000:
-			config1 = 0x16;
-			config2 = 0xaf;
-			break;
-		case 16000:
-			config1 = 0x1e;
-			config2 = 0x3f;
-			break;
-		case 22050:
-			config1 = 0x29;
-			config2 = 0xaf;
-			break;
-		case 24000:
-			config1 = 0x2d;
-			config2 = 0x5f;
-			break;
-		case 32000:
-			config1 = 0x3c;
-			config2 = 0x7f;
-			break;
-		case 44100:
-			config1 = 0x53;
-			config2 = 0x5f;
-			break;
-		case 48000:
-			config1 = 0x5a;
-			config2 = 0xbe;
-			break;
-		}
+		sc_access[1].reg_addr = 0x224;
+		sc_access[1].value = 0x04;
+		sc_access[1].mask = MASK0|MASK1|MASK2;
 
-		snd_pmic_ops_mx.num_channel = num_channel;
-		/*mute the right channel if MONO*/
-		sc_access[0].reg_addr =	0x20b;
-		sc_access[0].value = config1;
-		sc_access[1].reg_addr = 0x20c;
-		sc_access[1].value = config2;
-		if (word_size == 16) {
-			sc_access[2].value = 0x51;
-			sc_access[3].value = 0x51;
-		} else if (word_size == 24) {
-			sc_access[2].value = 0x52;
-			sc_access[3].value = 0x92;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+		if (retval)
+			return retval;
+	}
+	sc_access[0].reg_addr =	0x206;
+	sc_access[0].value = config1;
+	sc_access[1].reg_addr = 0x207;
+	sc_access[1].value = config2;
+
+	if (word_size == 16) {
+		sc_access[2].value = 0x51;
+		sc_access[3].value = 0x31;
+	} else if (word_size == 24) {
+		sc_access[2].value = 0x52;
+		sc_access[3].value = 0x92;
+	}
 
-		}
+	sc_access[2].reg_addr = 0x209;
+	sc_access[3].reg_addr = 0x20e;
 
-		sc_access[2].reg_addr = 0x209;
-		sc_access[3].reg_addr = 0x20e;
-		sc_access[4].reg_addr = 0x211;
-		sc_access[4].value = filter;
+	sc_access[4].reg_addr = 0x211;
+	sc_access[4].value = filter;
 
-		return sst_sc_reg_access(sc_access, PMIC_WRITE, 5);
-	}
-	return 0;
+	return sst_sc_reg_access(sc_access, PMIC_WRITE, 5);
 }
 
 static int mx_set_selected_output_dev(u8 dev_id)
@@ -742,20 +583,7 @@ static int mx_set_voice_port(int status)
 
 static int mx_set_audio_port(int status)
 {
-	int retval = 0;
-	if (is_aava()) {
-		if (snd_pmic_ops_mx.card_status == SND_CARD_UN_INIT)
-			retval = mx_init_card();
-		if (retval)
-			return retval;
-		if (status == ACTIVATE) {
-			mx_init_card();
-			mx_set_selected_output_dev
-					(snd_pmic_ops_mx.output_dev_id);
-		}
-	}
-	return retval;
-
+	return 0;
 }
 
 static int mx_set_selected_input_dev(u8 dev_id)
