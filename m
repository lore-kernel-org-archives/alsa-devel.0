From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/13] ASoC: Add snd_soc_kcontrol_platform()
	helper function
Date: Tue, 18 Mar 2014 09:02:05 +0100
Message-ID: <1395129736-11938-3-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id F26DC261AEC
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:39 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For platform controls snd_kcontrol_chip() currently returns a pointer to the
platform that registered the control. With the upcoming consolidation of
platform and CODEC controls this will change. Prepare for this by introducing
the snd_soc_kcontrol_platform() helper function that will hide the
implementation details of how the platform for a control can be obtained. This
will allow us to change this easily in the future.

The patch also updates all platforms to use this new helper function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h               | 14 ++++++++++++++
 sound/soc/intel/sst-haswell-pcm.c |  8 ++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d7cef6b..0233cd3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1229,6 +1229,20 @@ static inline struct snd_soc_codec *snd_soc_kcontrol_codec(
 	return snd_kcontrol_chip(kcontrol);
 }
 
+/**
+ * snd_soc_kcontrol_platform() - Returns the platform that registerd the control
+ * @kcontrol: The control for which to get the platform
+ *
+ * Note: This function will only work correctly if the control has been
+ * registered with snd_soc_add_platform_controls() or via table based setup of
+ * a snd_soc_platform_driver. Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_codec *snd_soc_kcontrol_platform(
+	struct snd_kcontrol *kcontrol)
+{
+	return snd_kcontrol_chip(kcontrol);
+}
+
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 0a32dd1..67a5eb3 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -136,7 +136,7 @@ static inline unsigned int hsw_ipc_to_mixer(u32 value)
 static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct hsw_priv_data *pdata =
@@ -174,7 +174,7 @@ static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct hsw_priv_data *pdata =
@@ -206,7 +206,7 @@ static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
 	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
@@ -231,7 +231,7 @@ static int hsw_volume_put(struct snd_kcontrol *kcontrol,
 static int hsw_volume_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_platform *platform = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_platform *platform = snd_soc_kcontrol_platform(kcontrol);
 	struct hsw_priv_data *pdata = snd_soc_platform_get_drvdata(platform);
 	struct sst_hsw *hsw = pdata->hsw;
 	unsigned int volume = 0;
-- 
1.8.0
