From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Set sample_type in
	base config
Date: Thu, 28 Feb 2019 04:19:04 +0000
Message-ID: <20ADAB092842284E95860F279283C5645697C7AB@BGSMSX104.gar.corp.intel.com>
References: <1551250158-27591-1-git-send-email-jenny.tc@intel.corp-partner.google.com>
 <c75aeb33-bb4a-a1d1-bb37-3e1e12c19b0a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1474DF8968F
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 05:19:13 +0100 (CET)
In-Reply-To: <c75aeb33-bb4a-a1d1-bb37-3e1e12c19b0a@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jenny TC <jenny.tc@intel.corp-partner.google.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, "Kumar, Abhijeet" <abhijeet.kumar@intel.com>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>
Cc: "N, Harshapriya" <harshapriya.n@intel.com>, "M,
 Naveen" <naveen.m@intel.com>, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org



>>sample_type defined in topology configuration is not getting reflected
>>in the dsp param. This patch sets sample_type in base config so that
>>the sample type defined in the topology is reflected int eh dsp params.
>>This issues was uncovered while debugging the S24_LE format which
>>require the MSB byte in 32 bit word to be skipped. Setting sample_type
>>to 1 helps to fix this.
>skl_set_base_module_format() is called from a variety of places, so am I correct in stating that S24_LE never worked with this driver? If so, the patch should really be titled "ASoC: Intel: Skylake: enable S24_LE format >support"

Yes, S24_LE is being enabled for first time, I'll update the title

>Also your commit message is confusing in the last sentence. What do you mean by "Setting sample_type to " when you only use what's provided by the topology?

Yes, setting sample type to 1 in topology firmware helps to fix this. I'll update the commit message to make it clear.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index b0e6fb9..9260e9a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -483,6 +483,7 @@ static void skl_set_base_module_format(struct skl_sst *ctx,
 	base_cfg->audio_fmt.bit_depth = format->bit_depth;
 	base_cfg->audio_fmt.valid_bit_depth = format->valid_bit_depth;
 	base_cfg->audio_fmt.ch_cfg = format->ch_cfg;
+	base_cfg->audio_fmt.sample_type = format->sample_type;
 
 	dev_dbg(ctx->dev, "bit_depth=%x valid_bd=%x ch_config=%x\n",
 			format->bit_depth, format->valid_bit_depth,
