From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 6/6] ASoC: topology: Add support for
	compressed PCMs
Date: Tue, 27 Mar 2018 14:30:45 +0100
Message-ID: <20180327133045.29351-7-liam.r.girdwood@linux.intel.com>
References: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 082242671AB
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 15:31:07 +0200 (CEST)
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

Register a compressed PCM if topology defines one.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b578bc938118..81bb0c39a801 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1768,6 +1768,9 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 		set_stream_info(stream, caps);
 	}
 
+	if (pcm->compress)
+		dai_drv->compress_new = snd_soc_new_compress;
+
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
-- 
2.14.1
