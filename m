From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/10] ASoC: build fix for snd_soc_info_bool_ext
Date: Tue, 13 May 2008 12:40:06 +0100
Message-ID: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B0A0E24AC0
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:40:17 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Philipp Zabel <philipp.zabel@gmail.com>

I suspect that snd_ctl_boolean_mono should have been
snd_ctl_boolean_mono_info instead. This fixes the build for magician.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e6ea6f7..d3c8c03 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -238,7 +238,7 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_info_volsw_ext(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
-#define snd_soc_info_bool_ext		snd_ctl_boolean_mono
+#define snd_soc_info_bool_ext		snd_ctl_boolean_mono_info
 int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
-- 
1.5.5.1
