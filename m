From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v8 5/7] ASoC: jack: create kctls according to
	jack pins info
Date: Wed, 22 Apr 2015 14:03:51 +0800
Message-ID: <1429682633-10765-6-git-send-email-yang.jie@intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACF4265CAB
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 08:00:38 +0200 (CEST)
In-Reply-To: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
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

In the new jack kctls design, we can create kctls according to
pins info:

1. during jack creating, snd_jack_new() with NULL jack_kctl;
2. for each pin, call snd_jack_add_kctl() to add one kctl
(it will call snd_ctl_add() to add kctl to card);

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/soc-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 70a9bdd..87ca980 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -197,6 +197,7 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 
 		INIT_LIST_HEAD(&pins[i].list);
 		list_add(&(pins[i].list), &jack->pins);
+		snd_jack_add_new_kctl(jack->jack, pins[i].pin, pins[i].mask);
 	}
 
 	/* Update to reflect the last reported status; canned jack
-- 
1.9.1
