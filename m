From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ASoC: DAPM: Add private data pointer
	for DAPM widget
Date: Fri, 19 Aug 2011 10:41:18 +0300
Message-ID: <1313739679-8975-2-git-send-email-peter.ujfalusi@ti.com>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 464C0103909
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 09:41:28 +0200 (CEST)
In-Reply-To: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Support for using custom private data assigned
per DAPM widget.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc-dapm.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 602024d..84114e7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -467,6 +467,7 @@ struct snd_soc_dapm_widget {
 	unsigned char force:1;			/* force state */
 	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
 	int subseq;				/* sort within widget type */
+	void *private_data;
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
 
-- 
1.7.6
