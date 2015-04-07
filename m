From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v5 4/5] ASoC: jack: create kctls according to
	jack pins info
Date: Tue,  7 Apr 2015 12:44:50 +0800
Message-ID: <1428381891-30517-5-git-send-email-yang.jie@intel.com>
References: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF8D260565
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 06:41:54 +0200 (CEST)
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

In the new jack kctls design, we can create kctls according to
pins info:

1. during jack creating, snd_jack_new() with NULL jack_kctl;
2. for each pin, call snd_jack_add_kctls() to add one kctl
(it will call snd_ctl_add() to add kctl to card);

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/soc-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 3c87e32..7099222 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -197,6 +197,7 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 
 		INIT_LIST_HEAD(&pins[i].list);
 		list_add(&(pins[i].list), &jack->pins);
+		snd_jack_add_new_kctls(jack->jack, pins[i].pin, pins[i].mask);
 	}
 
 	/* Update to reflect the last reported status; canned jack
-- 
1.9.1
