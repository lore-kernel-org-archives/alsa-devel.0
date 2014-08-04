From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl_asrc: Don't access members of config before checking it
Date: Mon, 4 Aug 2014 12:19:49 +0800
Message-ID: <31ec001e493008c1d6e55f1d9d0787028112c4dc.1407125653.git.nicoleotsuka@gmail.com>
References: <cover.1407125653.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1407125653.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

sound/soc/fsl/fsl_asrc.c:250 fsl_asrc_config_pair()
	warn: variable dereferenced before check 'config' (see line 243)

git remote add next git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git remote update next
git checkout 3117bb3109dc223e186302f5dc8ce9ed04adca90
vim +/config +250 sound/soc/fsl/fsl_asrc.c

  237   */
  238  static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
  239  {
  240   struct asrc_config *config = pair->config;
  241   struct fsl_asrc *asrc_priv = pair->asrc_priv;
  242   enum asrc_pair_index index = pair->index;
 @243   u32 inrate = config->input_sample_rate, indiv;
  244   u32 outrate = config->output_sample_rate, outdiv;
  245   bool ideal = config->inclk == INCLK_NONE;
  246   u32 clk_index[2], div[2];
  247   int in, out, channels;
  248   struct clk *clk;
  249
 @250   if (!config) {
  251           pair_err("invalid pair config\n");
  252           return -EINVAL;
  253   }

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 06a96f3..86f45a1 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -240,12 +240,11 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	struct asrc_config *config = pair->config;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
 	enum asrc_pair_index index = pair->index;
-	u32 inrate = config->input_sample_rate, indiv;
-	u32 outrate = config->output_sample_rate, outdiv;
-	bool ideal = config->inclk == INCLK_NONE;
+	u32 inrate, outrate, indiv, outdiv;
 	u32 clk_index[2], div[2];
 	int in, out, channels;
 	struct clk *clk;
+	bool ideal;
 
 	if (!config) {
 		pair_err("invalid pair config\n");
@@ -264,6 +263,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 		return -EINVAL;
 	}
 
+	inrate = config->input_sample_rate;
+	outrate = config->output_sample_rate;
+	ideal = config->inclk == INCLK_NONE;
+
 	/* Validate input and output sample rates */
 	for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
 		if (inrate == supported_input_rate[in])
-- 
1.8.4
