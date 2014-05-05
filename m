From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix check for pdata usage before
	dereference.
Date: Mon,  5 May 2014 13:20:23 +0100
Message-ID: <1399292423-4675-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBDC260799
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 14:20:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the following dereference check ordering.

 sound/soc/intel/sst-haswell-pcm.c:749 hsw_pcm_probe() warn: variable dereferenced before check 'pdata' (see line 746)

 git remote add asoc git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
 git remote update asoc
 git checkout 0b708c87f66a15190fb43661c2320fd48c4dc6c8
 vim +/pdata +749 sound/soc/intel/sst-haswell-pcm.c

 a4b12990 Mark Brown    2014-03-12  740  };
 a4b12990 Mark Brown    2014-03-12  741
 a4b12990 Mark Brown    2014-03-12  742  static int hsw_pcm_probe(struct snd_soc_platform *platform)
 a4b12990 Mark Brown    2014-03-12  743  {
 a4b12990 Mark Brown    2014-03-12  744  	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
 a4b12990 Mark Brown    2014-03-12  745  	struct hsw_priv_data *priv_data;
 0b708c87 Liam Girdwood 2014-05-02 @746  	struct device *dma_dev = pdata->dma_dev;
 0b708c87 Liam Girdwood 2014-05-02  747  	int i, ret = 0;
 a4b12990 Mark Brown    2014-03-12  748
 a4b12990 Mark Brown    2014-03-12 @749  	if (!pdata)
 a4b12990 Mark Brown    2014-03-12  750  		return -ENODEV;
 a4b12990 Mark Brown    2014-03-12  751
 a4b12990 Mark Brown    2014-03-12  752  	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data), GFP_KERNEL);

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 8c6bd33..9d5f64a 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -772,12 +772,14 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 {
 	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
 	struct hsw_priv_data *priv_data;
-	struct device *dma_dev = pdata->dma_dev;
+	struct device *dma_dev;
 	int i, ret = 0;
 
 	if (!pdata)
 		return -ENODEV;
 
+	dma_dev = pdata->dma_dev;
+
 	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data), GFP_KERNEL);
 	priv_data->hsw = pdata->dsp;
 	snd_soc_platform_set_drvdata(platform, priv_data);
-- 
1.9.1
