From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Topology: Add subsequence in topology
Date: Mon, 29 Jun 2015 17:36:44 +0100
Message-ID: <1435595806-7000-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 527B9265750
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:37:05 +0200 (CEST)
In-Reply-To: <1435595806-7000-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Some widgets may need sorting within, So add this support in topology.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 include/uapi/sound/asoc.h | 1 +
 sound/soc/soc-topology.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 1221520..7ae13fb 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -347,6 +347,7 @@ struct snd_soc_tplg_dapm_widget {
 	__le32 reg;		/* negative reg = no direct dapm */
 	__le32 shift;		/* bits to shift */
 	__le32 mask;		/* non-shifted mask */
+	__le32 subseq;		/* sort within widget type */
 	__u32 invert;		/* invert the power bit */
 	__u32 ignore_suspend;	/* kept enabled over suspend */
 	__u16 event_flags;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 7a19df3..f23b9ef 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1350,6 +1350,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	template.reg = w->reg;
 	template.shift = w->shift;
 	template.mask = w->mask;
+	template.subseq = w->subseq;
 	template.on_val = w->invert ? 0 : 1;
 	template.off_val = w->invert ? 1 : 0;
 	template.ignore_suspend = w->ignore_suspend;
-- 
2.1.4
