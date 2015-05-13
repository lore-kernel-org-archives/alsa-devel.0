From: han.lu@intel.com
Subject: [PATCH 1/1] ALSA: core: Fix regression for ELD/codec
	information files
Date: Wed, 13 May 2015 16:36:33 +0800
Message-ID: <1431506193-28265-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C1C6C2605EF
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 10:38:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, libin.yang@intel.com, mengdong.lin@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

The commit c560a6797e3b ("ALSA: core: Remove child proc file elements
recursively") introduced a regression that ELD/codec information files
can not be found on /proc/asound/cardX/. This patch corrects it.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/include/sound/info.h b/include/sound/info.h
index 1626995..ae8d30a 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -149,6 +149,10 @@ static inline int snd_card_proc_new(struct snd_card *card, const char *name,
 				    struct snd_info_entry **entryp)
 {
 	*entryp = snd_info_create_card_entry(card, name, card->proc_root);
+	if (snd_info_register(*entryp) < 0) {
+		snd_info_free_entry(*entryp);
+		*entryp = NULL;
+	}
 	return *entryp ? 0 : -ENOMEM;
 }
 
-- 
1.9.1
