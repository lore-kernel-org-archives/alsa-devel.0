From: Jenny TC <jenny.tc@intel.corp-partner.google.com>
Subject: [PATCH v2] ASoC: Intel: Skylake: enable S24_LE format
	support
Date: Sat, 23 Mar 2019 18:40:10 +0530
Message-ID: <1553346610-1012-1-git-send-email-jenny.tc@intel.corp-partner.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F330BF801DB
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2019 14:10:20 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ughreja Rakesh A <rakesh.a.ughreja@intel.com>, Periyasamy SriramX <sriramx.periyasamy@intel.com>, Kumar Abhijeet <abhijeet.kumar@intel.com>, Kale Sanyog R <sanyog.r.kale@intel.com>
Cc: N Harshapriya <harshapriya.n@intel.com>, M Naveen <naveen.m@intel.com>, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, Jenny TC <jenny.tc@intel.com>, Nujella Sathyanarayana <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jenny TC <jenny.tc@intel.com>

To enable S24_LE format, sample_type in topology fw has to be set to 1.
But sample_type defined in topology firmware configuration is not
getting reflected in the dsp param. This patch sets sample_type in base
config so that the sample type defined in the topology firmware is reflected
in the dsp params. This issues was uncovered while debugging the S24_LE format
which require the MSB byte in 32 bit word to be skipped. Setting sample_type
in topology firmware to 1 helps to skip MSB byte word.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 28c4806..4bf70b4 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -483,6 +483,7 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 	base_cfg->audio_fmt.bit_depth = format->bit_depth;
 	base_cfg->audio_fmt.valid_bit_depth = format->valid_bit_depth;
 	base_cfg->audio_fmt.ch_cfg = format->ch_cfg;
+	base_cfg->audio_fmt.sample_type = format->sample_type;
 
 	dev_dbg(ctx->dev, "bit_depth=%x valid_bd=%x ch_config=%x\n",
 			format->bit_depth, format->valid_bit_depth,
-- 
1.9.1
