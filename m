From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH baohua] ASoC: sirf: atlas7: atlas7_iacc_dai_ops
	can be static
Date: Fri, 6 Feb 2015 01:03:52 +0800
Message-ID: <20150205170352.GA49811@snb>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B8A44264F3D
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 18:05:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201502060130.hszyNa1F%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rongjun Ying <rongjun.ying@csr.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Barry Song <Barry.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 atlas7-iacc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sirf/atlas7-iacc.c b/sound/soc/sirf/atlas7-iacc.c
index ca17e90..a359d8b 100644
--- a/sound/soc/sirf/atlas7-iacc.c
+++ b/sound/soc/sirf/atlas7-iacc.c
@@ -165,7 +165,7 @@ static int atlas7_iacc_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-struct snd_soc_dai_ops atlas7_iacc_dai_ops = {
+static struct snd_soc_dai_ops atlas7_iacc_dai_ops = {
 	.hw_params = atlas7_iacc_hw_params,
 	.trigger = atlas7_iacc_trigger,
 };
