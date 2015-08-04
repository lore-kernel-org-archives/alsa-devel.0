From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: fix element object type is switch()
Date: Tue,  4 Aug 2015 18:06:55 +0100
Message-ID: <1438708015-16171-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E476260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:07:29 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Use the correct type for this object.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/elem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/topology/elem.c b/src/topology/elem.c
index 32ba2c1..d7a1fd7 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -137,7 +137,7 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		list_add_tail(&elem->list, &tplg->enum_list);
 		obj_size = sizeof(struct snd_soc_tplg_enum_control);
 		break;
-	case SND_SOC_TPLG_TYPE_MIXER:
+	case OBJECT_TYPE_MIXER:
 		list_add_tail(&elem->list, &tplg->mixer_list);
 		obj_size = sizeof(struct snd_soc_tplg_mixer_control);
 		break;
-- 
2.1.4
