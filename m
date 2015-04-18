From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v6 5/6] ALSA: jack: remove exporting ctljack
	functions
Date: Sat, 18 Apr 2015 18:04:19 +0800
Message-ID: <1429351460-15932-6-git-send-email-yang.jie@intel.com>
References: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E0D2617BB
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 12:01:08 +0200 (CEST)
In-Reply-To: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

After created jack embedded kctls and removed hda jack kctls, the funcs
snd_kctl_jack_new() and snd_kctl_jack_report() are merely internal called,
so here remove exporting them.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/core/ctljack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/ctljack.c b/sound/core/ctljack.c
index e4b38fb..7a271f5 100644
--- a/sound/core/ctljack.c
+++ b/sound/core/ctljack.c
@@ -43,7 +43,6 @@ snd_kctl_jack_new(const char *name, int idx, void *private_data)
 	kctl->private_value = 0;
 	return kctl;
 }
-EXPORT_SYMBOL_GPL(snd_kctl_jack_new);
 
 void snd_kctl_jack_report(struct snd_card *card,
 			  struct snd_kcontrol *kctl, bool status)
@@ -53,4 +52,3 @@ void snd_kctl_jack_report(struct snd_card *card,
 	kctl->private_value = status;
 	snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
 }
-EXPORT_SYMBOL_GPL(snd_kctl_jack_report);
-- 
1.9.1
