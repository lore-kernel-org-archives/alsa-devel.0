From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v9 6/7] ALSA: jack: remove exporting ctljack
	functions
Date: Thu, 23 Apr 2015 10:32:45 +0800
Message-ID: <1429756366-22520-7-git-send-email-yang.jie@intel.com>
References: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AFCD4265B46
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 04:29:39 +0200 (CEST)
In-Reply-To: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
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
index 6435e82..8f8d103 100644
--- a/sound/core/ctljack.c
+++ b/sound/core/ctljack.c
@@ -74,7 +74,6 @@ snd_kctl_jack_new(const char *name, struct snd_card *card)
 	kctl->private_value = 0;
 	return kctl;
 }
-EXPORT_SYMBOL_GPL(snd_kctl_jack_new);
 
 void snd_kctl_jack_report(struct snd_card *card,
 			  struct snd_kcontrol *kctl, bool status)
@@ -84,4 +83,3 @@ void snd_kctl_jack_report(struct snd_card *card,
 	kctl->private_value = status;
 	snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
 }
-EXPORT_SYMBOL_GPL(snd_kctl_jack_report);
-- 
1.9.1
