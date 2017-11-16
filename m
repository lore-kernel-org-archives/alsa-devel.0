From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] ASoC: fsl_asrc: Fix line continuation
	format
Date: Thu, 16 Nov 2017 08:25:46 -0800
Message-ID: <370a4a8e3963eb4dc4c4e13defda5170eee72753.1510849466.git.joe@perches.com>
References: <cover.1510849466.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0067.hostedemail.com
 [216.40.44.67]) by alsa0.perex.cz (Postfix) with ESMTP id BAC69267729
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:25:56 +0100 (CET)
In-Reply-To: <cover.1510849466.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Line continuations with excess spacing causes unexpected output

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/fsl/fsl_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 806d39927318..ed683fe8b94a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -288,8 +288,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 
 	if ((outrate > 8000 && outrate < 30000) &&
 	    (outrate/inrate > 24 || inrate/outrate > 8)) {
-		pair_err("exceed supported ratio range [1/24, 8] for \
-				inrate/outrate: %d/%d\n", inrate, outrate);
+		pair_err("exceed supported ratio range [1/24, 8] for inrate/outrate: %d/%d\n",
+			 inrate, outrate);
 		return -EINVAL;
 	}
 
-- 
2.15.0
