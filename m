From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Warn when control names are truncated
Date: Wed, 29 Oct 2008 14:14:54 +0000
Message-ID: <1225289694-25584-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D77F42443A
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 15:14:55 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is likely to confuse user interfaces since the end of the control
name is interpreted (eg, "Volume", "Switch").

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/core/control.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 6d71f9a..1257ca8 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -225,8 +225,12 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 	kctl.id.iface = ncontrol->iface;
 	kctl.id.device = ncontrol->device;
 	kctl.id.subdevice = ncontrol->subdevice;
-	if (ncontrol->name)
+	if (ncontrol->name) {
+		if (strlen(ncontrol->name) > sizeof(kctl.id.name))
+			snd_printk(KERN_WARNING "Control name '%s' truncated\n",
+				   ncontrol->name);
 		strlcpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name));
+	}
 	kctl.id.index = ncontrol->index;
 	kctl.count = ncontrol->count ? ncontrol->count : 1;
 	access = ncontrol->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
-- 
1.5.6.5
