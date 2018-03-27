From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 5/6] ASoC: topology: Check widget kcontrols
	before deref.
Date: Tue, 27 Mar 2018 14:30:44 +0100
Message-ID: <20180327133045.29351-6-liam.r.girdwood@linux.intel.com>
References: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 752FE2671AB
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 15:31:06 +0200 (CEST)
In-Reply-To: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Validate the topology input before we dereference the pointer.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b1970a05ba44..b578bc938118 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -517,7 +517,7 @@ static void remove_widget(struct snd_soc_component *comp,
 	 */
 	if (dobj->widget.kcontrol_type == SND_SOC_TPLG_TYPE_ENUM) {
 		/* enumerated widget mixer */
-		for (i = 0; i < w->num_kcontrols; i++) {
+		for (i = 0; w->kcontrols != NULL && i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 			struct soc_enum *se =
 				(struct soc_enum *)kcontrol->private_value;
@@ -534,7 +534,7 @@ static void remove_widget(struct snd_soc_component *comp,
 		}
 	} else {
 		/* volume mixer or bytes controls */
-		for (i = 0; i < w->num_kcontrols; i++) {
+		for (i = 0; w->kcontrols != NULL && i < w->num_kcontrols; i++) {
 			struct snd_kcontrol *kcontrol = w->kcontrols[i];
 
 			if (dobj->widget.kcontrol_type
-- 
2.14.1
