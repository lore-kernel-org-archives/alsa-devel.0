From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/2] Fixes to couple DAPM widget functions
Date: Thu, 28 Feb 2008 15:29:23 +0200
Message-ID: <20080228152923.b512f6e3.jarkko.nikula@nokia.com>
References: <1204192390-16304-1-git-send-email-jarkko.nikula@nokia.com>
	<20080228122927.GA10610@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 1616D103847
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 14:29:50 +0100 (CET)
In-Reply-To: <20080228122927.GA10610@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Feb 2008 12:29:27 +0000
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Feb 28, 2008 at 11:53:08AM +0200, Jarkko Nikula wrote:
> 
> > to own patch since it is ok in asoc-v2-dev branch. There are other drivers
> > as well with this error in asoc-v2-dev but I don't know are they already in
> > progress? I can post a another patch to them if needed.
> 
> Please go ahead - there's reworking in progress for all the v2 API
> changes but if you've done the work already there's no sense in
> replicating it.  The current work is all public.
>
Did it only now :-)

========================== CUT HERE ==========================
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Thu, 28 Feb 2008 15:18:38 +0200
Subject: [PATCH] ASoC: Fix DAPM widget function types in various drivers. Part asoc-v2 branch

Add kcontrol argument to functions since the API was changed by the commit
9af6d9562414568ecadf96aaef5b88e7e8b19821.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/wm8350.c           |    3 ++-
 sound/soc/pxa/h5000.c               |    3 ++-
 sound/soc/pxa/magician.c            |    9 ++++++---
 sound/soc/pxa/mainstone_bluetooth.c |    3 ++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index abf9bd8..5508dc1 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -274,7 +274,8 @@ static void wm8350_pga_work(struct work_struct *work)
  * WM8350 Controls
  */
 
-static int pga_event(struct snd_soc_dapm_widget *w, int event)
+static int pga_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct wm8350_data *wm8350_data = codec->private_data;
diff --git a/sound/soc/pxa/h5000.c b/sound/soc/pxa/h5000.c
index 58ab1dc..6767fc0 100644
--- a/sound/soc/pxa/h5000.c
+++ b/sound/soc/pxa/h5000.c
@@ -193,7 +193,8 @@ static int h5000_set_spk(struct snd_kcontrol *kcontrol,
 	return 1;
 };
 
-static int h5000_audio_power(struct snd_soc_dapm_widget *widget, int event) 
+static int h5000_audio_power(struct snd_soc_dapm_widget *widget,
+	struct snd_kcontrol *k, int event) 
 {
 	// mp - why do we need the ref count, dapm core should ref count all widget use.
 	static int power_use_count = 0;
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index f83c7fd..5d4f701 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -333,7 +333,8 @@ static int magician_set_input(struct snd_kcontrol * kcontrol,
 	return 1;
 }
 
-static int magician_spk_power(struct snd_soc_dapm_widget *w, int event)
+static int magician_spk_power(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		magician_egpio_enable(&magician_cpld,
@@ -344,7 +345,8 @@ static int magician_spk_power(struct snd_soc_dapm_widget *w, int event)
 	return 0;
 }
 
-static int magician_hp_power(struct snd_soc_dapm_widget *w, int event)
+static int magician_hp_power(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		magician_egpio_enable(&magician_cpld,
@@ -355,7 +357,8 @@ static int magician_hp_power(struct snd_soc_dapm_widget *w, int event)
 	return 0;
 }
 
-static int magician_mic_bias(struct snd_soc_dapm_widget *w, int event)
+static int magician_mic_bias(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *k, int event)
 {
 //	if (SND_SOC_DAPM_EVENT_ON(event))
 //		magician_egpio_enable(&magician_cpld,
diff --git a/sound/soc/pxa/mainstone_bluetooth.c b/sound/soc/pxa/mainstone_bluetooth.c
index c79e97d..53df17e 100644
--- a/sound/soc/pxa/mainstone_bluetooth.c
+++ b/sound/soc/pxa/mainstone_bluetooth.c
@@ -219,7 +219,8 @@ static int soc_card_set_mic(struct snd_kcontrol *kcontrol,
 }
 
 /* turns on board speaker amp on/off */
-static int soc_card_amp_event(struct snd_soc_dapm_widget *w, int event)
+static int soc_card_amp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
 {
 #if 0
 	if (SND_SOC_DAPM_EVENT_ON(event))
-- 
1.5.3.8
