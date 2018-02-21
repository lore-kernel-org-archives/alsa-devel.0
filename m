From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: soc-generic-dmaengine-pcm: Add a DMA
	debugfs_prefix entry
Date: Wed, 21 Feb 2018 14:57:33 -0300
Message-ID: <1519235853-29856-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B70812675FD
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 18:57:32 +0100 (CET)
Received: by mail-qt0-f196.google.com with SMTP id d26so2993199qtk.10
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 09:57:32 -0800 (PST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

After the conversion from platform to component the following warnings
are seen:

fsl-ssi-dai 2028000.ssi: ASoC: Failed to create component debugfs
directory
fsl-spdif-dai 2004000.spdif: ASoC: Failed to create component debugfs
directory

As explained by Mark Brown:

"It's a legit warning - we shouldn't really be creating two components
for the same device.  However this is a bit of a corner case as it's the
dmaengine platform driver which is kind of a virtual device, it's not
really the device that we use with DMA that's being represented but
rather the link between that and the DMA controller."

Disambiguate the DMA component name by adding a "dma" debugfs_prefix
entry.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Fixed typo in commit log "createcomponent"

 sound/soc/soc-generic-dmaengine-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index c07d5c7..768247f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -442,6 +442,9 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (!pcm)
 		return -ENOMEM;
 
+#ifdef CONFIG_DEBUG_FS
+	pcm->component.debugfs_prefix = "dma";
+#endif
 	pcm->config = config;
 	pcm->flags = flags;
 
-- 
2.7.4
