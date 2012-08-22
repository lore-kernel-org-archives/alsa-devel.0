From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/4] ASoC: omap-mcbsp: Single macro for st
	channel volume set/get
Date: Wed, 22 Aug 2012 13:11:43 +0300
Message-ID: <1345630303-26291-5-git-send-email-peter.ujfalusi@ti.com>
References: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
 [74.125.149.246])
 by alsa0.perex.cz (Postfix) with ESMTP id A8EE02660DC
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 12:12:03 +0200 (CEST)
Received: by obqv19 with SMTP id v19so1259787obq.2
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 03:12:03 -0700 (PDT)
In-Reply-To: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Since we always need to have set and get callbacks for McBSP sidetone it
makes sense to combine the two macro to create the two callbacks.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 44c475c..2e91a86 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -619,9 +619,9 @@ static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(channel)			\
+#define OMAP_MCBSP_ST_CHANNEL_VOLUME(channel)				\
 static int								\
-omap_mcbsp_set_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
+omap_mcbsp_set_st_ch##channel##_volume(struct snd_kcontrol *kc,		\
 					struct snd_ctl_elem_value *uc)	\
 {									\
 	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kc);		\
@@ -637,11 +637,10 @@ omap_mcbsp_set_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
 									\
 	/* OMAP McBSP implementation uses index values 0..4 */		\
 	return omap_st_set_chgain(mcbsp, channel, val);			\
-}
-
-#define OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(channel)			\
+}									\
+									\
 static int								\
-omap_mcbsp_get_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
+omap_mcbsp_get_st_ch##channel##_volume(struct snd_kcontrol *kc,		\
 					struct snd_ctl_elem_value *uc)	\
 {									\
 	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kc);		\
@@ -655,10 +654,8 @@ omap_mcbsp_get_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
 	return 0;							\
 }
 
-OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(0)
-OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(1)
-OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(0)
-OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(1)
+OMAP_MCBSP_ST_CHANNEL_VOLUME(0)
+OMAP_MCBSP_ST_CHANNEL_VOLUME(1)
 
 static int omap_mcbsp_st_put_mode(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
-- 
1.7.8.6
