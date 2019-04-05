From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH] ASoC: topology: Use the correct dobj to free
	enum control values and texts
Date: Thu,  4 Apr 2019 19:48:33 -0700
Message-ID: <20190405024833.12189-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 912B5F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:48:35 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The control values and texts of the enum kcontrol associated
with a widget need to be freed when the widget is removed.
However, both struct snd_soc_dapm_widget and struct soc_enum
contain a dobj member, which resulted in a confusion.
The existing code generates a null pointer dereference by
attempting to free the values and texts from the dobj which
belongs to the widget instead of the dobj belonging to the
enum kcontrol.

The suggested fix is to use the correct dobj member (se->dobj)
of the enum kcontrol.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 472f7705da93..0f6a6ad01570 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -482,10 +482,11 @@ static void remove_widget(struct snd_soc_component *comp,
 
 			snd_ctl_remove(card, kcontrol);
 
-			kfree(dobj->control.dvalues);
+			/* free enum kcontrol's dvalues and dtexts */
+			kfree(se->dobj.control.dvalues);
 			for (j = 0; j < se->items; j++)
-				kfree(dobj->control.dtexts[j]);
-			kfree(dobj->control.dtexts);
+				kfree(se->dobj.control.dtexts[j]);
+			kfree(se->dobj.control.dtexts);
 
 			kfree(se);
 			kfree(w->kcontrol_news[i].name);
-- 
2.17.1
