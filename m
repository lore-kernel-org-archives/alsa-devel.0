From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: topology: Fix to store enum text values
Date: Tue, 11 Apr 2017 13:06:22 +0530
Message-ID: <1491896182-14199-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id AE70126648D
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 09:49:13 +0200 (CEST)
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
Cc: tiwai@suse.de, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, lgirdwood@gmail.com, Mousumi Jana <mousumix.jana@intel.com>, "Kranthikumar,
 GudishaX" <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mousumi Jana <mousumix.jana@intel.com>

Add missing enum texts store in soc_enum.

Signed-off-by: Mousumi Jana <mousumix.jana@intel.com>
Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Kranthikumar, GudishaX <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 3e9b1c0bb1ce..058bc99c6c34 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -933,6 +933,7 @@ static int soc_tplg_denum_create_texts(struct soc_enum *se,
 		}
 	}
 
+	se->texts = (const char * const *)se->dobj.control.dtexts;
 	return 0;
 
 err:
-- 
1.9.1
