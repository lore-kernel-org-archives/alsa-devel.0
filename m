From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Fix pcm_class sysfs output
Date: Tue, 23 Jun 2015 12:13:03 +0200
Message-ID: <1435054383-17814-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A299B2654D7
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 12:13:04 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5CE0AD8C
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 10:13:04 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The pcm_class sysfs of each PCM substream gives only "none" since the
recent code change to embed the struct device.  Fix the code to point
directly to the embedded device object properly.

Fixes: ef46c7af93f9 ('ALSA: pcm: Embed struct device')
Cc: <stable@vger.kernel.org> # v4.0+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index e53794319ef3..02bd96954dc4 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1027,7 +1027,8 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 static ssize_t show_pcm_class(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct snd_pcm *pcm;
+	struct snd_pcm_str *pstr = container_of(dev, struct snd_pcm_str, dev);
+	struct snd_pcm *pcm = pstr->pcm;
 	const char *str;
 	static const char *strs[SNDRV_PCM_CLASS_LAST + 1] = {
 		[SNDRV_PCM_CLASS_GENERIC] = "generic",
@@ -1036,8 +1037,7 @@ static ssize_t show_pcm_class(struct device *dev,
 		[SNDRV_PCM_CLASS_DIGITIZER] = "digitizer",
 	};
 
-	if (! (pcm = dev_get_drvdata(dev)) ||
-	    pcm->dev_class > SNDRV_PCM_CLASS_LAST)
+	if (pcm->dev_class > SNDRV_PCM_CLASS_LAST)
 		str = "none";
 	else
 		str = strs[pcm->dev_class];
-- 
2.4.4
