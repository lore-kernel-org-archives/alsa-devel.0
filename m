From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v5 5/5] ALSA: jack: remove export
	snd_kctl_jack_new()
Date: Tue,  7 Apr 2015 12:44:51 +0800
Message-ID: <1428381891-30517-6-git-send-email-yang.jie@intel.com>
References: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 017CB260550
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 06:41:56 +0200 (CEST)
In-Reply-To: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

After created jack embedded kctls and removed hda jack kctls, the func
snd_kctl_jack_new() is merely internal called, so here remove exporting
it.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/core/ctljack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/ctljack.c b/sound/core/ctljack.c
index e4b38fb..8702fb1 100644
--- a/sound/core/ctljack.c
+++ b/sound/core/ctljack.c
@@ -43,7 +43,6 @@ snd_kctl_jack_new(const char *name, int idx, void *private_data)
 	kctl->private_value = 0;
 	return kctl;
 }
-EXPORT_SYMBOL_GPL(snd_kctl_jack_new);
 
 void snd_kctl_jack_report(struct snd_card *card,
 			  struct snd_kcontrol *kctl, bool status)
-- 
1.9.1
