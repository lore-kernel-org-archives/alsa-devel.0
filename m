From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ASoC: Fix DAPM widget function types in
	pxa machine drivers
Date: Thu, 28 Feb 2008 11:53:09 +0200
Message-ID: <1204192390-16304-2-git-send-email-jarkko.nikula@nokia.com>
References: <1204192390-16304-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 502082452F
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 10:53:20 +0100 (CET)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m1S9rSjQ005933
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 03:54:54 -0600
In-Reply-To: <1204192390-16304-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add kcontrol argument to functions since the API was changed by the commit
9af6d9562414568ecadf96aaef5b88e7e8b19821.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/pxa/corgi.c  |    6 ++++--
 sound/soc/pxa/poodle.c |    3 ++-
 sound/soc/pxa/spitz.c  |    3 ++-
 sound/soc/pxa/tosa.c   |    3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 3f34e53..1a70a6a 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -215,7 +215,8 @@ static int corgi_set_spk(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static int corgi_amp_event(struct snd_soc_dapm_widget *w, int event)
+static int corgi_amp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_APM_ON);
@@ -225,7 +226,8 @@ static int corgi_amp_event(struct snd_soc_dapm_widget *w, int event)
 	return 0;
 }
 
-static int corgi_mic_event(struct snd_soc_dapm_widget *w, int event)
+static int corgi_mic_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MIC_BIAS);
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 5ae59bd..4fbf8bb 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -196,7 +196,8 @@ static int poodle_set_spk(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static int poodle_amp_event(struct snd_soc_dapm_widget *w, int event)
+static int poodle_amp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		locomo_gpio_write(&poodle_locomo_device.dev,
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index d56709e..ecca390 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -215,7 +215,8 @@ static int spitz_set_spk(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static int spitz_mic_bias(struct snd_soc_dapm_widget *w, int event)
+static int spitz_mic_bias(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	if (machine_is_borzoi() || machine_is_spitz()) {
 		if (SND_SOC_DAPM_EVENT_ON(event))
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index e4d40b5..7346d7e 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -135,7 +135,8 @@ static int tosa_set_spk(struct snd_kcontrol *kcontrol,
 }
 
 /* tosa dapm event handlers */
-static int tosa_hp_event(struct snd_soc_dapm_widget *w, int event)
+static int tosa_hp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		set_tc6393_gpio(&tc6393_device.dev,TOSA_TC6393_L_MUTE);
-- 
1.5.3.8
