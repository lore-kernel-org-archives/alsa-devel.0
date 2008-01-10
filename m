From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/17] Don't lock the codec list in
	snd_soc_dapm_new_widgets()
Date: Thu, 10 Jan 2008 13:17:08 +0000
Message-ID: <1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 016AE2456E
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:18 +0100 (CET)
In-Reply-To: <1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_new_widgets() takes the codec lock when adding new widgets,
causing lockdep warnings when applications later call down through ALSA
to adjust controls.  Since widgets are only added during probe this lock
should be unneeded so don't take it.

Thanks to Dmitry Baryshkov <dbaryshkov@gmail.com> for reporting this issue.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/soc-dapm.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a4ce882..f99cac1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -972,7 +972,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_widget *w;
 
-	mutex_lock(&codec->mutex);
 	list_for_each_entry(w, &codec->dapm_widgets, list)
 	{
 		if (w->new)
@@ -1007,7 +1006,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
 	}
 
 	dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
-	mutex_unlock(&codec->mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
-- 
1.5.3.8
