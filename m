From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 000/145] ASoC: modern dai_link style support
Date: Fri, 24 May 2019 10:58:29 -0500
Message-ID: <03cf0a3b-3464-57fd-c313-cfe8db01d2cd@linux.intel.com>
References: <87sgt7p3zo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 996D4F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 20:37:08 +0200 (CEST)
In-Reply-To: <87sgt7p3zo.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

> These are for modern dai_link style support patches.
> [001/145] adds missing modern dai_link style for CPU.
> and others are switch to modern style from legacy style.
> Last patch removes legacy style.
> 
> These are based on mark/for-5.3 + v5.2-rc1
> 
> I hope these work well for all sound card, but I can't test for all.
> Please test these at each sound cards.

We're testing for Intel stuff w/ SOF.

One question: I try to enforce the use of checkpatch --strict to avoid 
different styles in the Intel contributions, and your series generates a 
ton of alignment warnings, e.g.

CHECK: Alignment should match open parenthesis
#45: FILE: sound/soc/intel/boards/sof_rt5682.c:373:
+		links[id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
  							"ssp%d-port",

CHECK: Alignment should match open parenthesis
#81: FILE: sound/soc/intel/boards/glk_rt5682_max98357a.c:378:
+SND_SOC_DAILINK_DEF(idisp3_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi3")));

I am not too religious on style as long as there is a style.
I'd be fine if the expectation is that all the dailink definitions use a 
tab for readability (and it's a one-time change), but would like the 
functional code changes to be aligned to avoid future warnings.
Would that work for you? I can send you the Intel changes if that helps.

Thanks
-Pierre
