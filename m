From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: AMD: free memory on error
Date: Wed, 13 Jan 2016 15:20:02 +0300
Message-ID: <20160113122002.GA19993@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E67C0260447
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 13:20:19 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Murali Krishna Vemuri <murali-krishna.vemuri@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

Static checkers complain if we don't free "adata" before returning.

Fixes: 7c31335a03b6 ('ASoC: AMD: add AMD ASoC ACP 2.x DMA driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3191e0a..d1fb035 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -635,6 +635,7 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
 		dev_err(prtd->platform->dev, "set integer constraint failed\n");
+		kfree(adata);
 		return ret;
 	}
 
