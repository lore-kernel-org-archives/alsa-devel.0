From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/7][RFC] ASoC: modern style CPU
Date: Mon, 15 Apr 2019 21:48:23 -0500
Message-ID: <f55ad838-1b1f-26c1-57a5-bf11937156fb@linux.intel.com>
References: <87zhp144vs.wl-kuninori.morimoto.gx@renesas.com>
 <20190412115619.GK6909@sirena.org.uk>
 <87h8ayepjd.wl-kuninori.morimoto.gx@renesas.com>
 <87ftqieo0h.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91010F896E2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 04:48:26 +0200 (CEST)
In-Reply-To: <87ftqieo0h.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


> I know you are already working for it for Intel
> 
> 	https://github.com/plbossart/sound/commits/fix/codec-legacy-dai
> 
> and, it will be conflict to my posted patch style.
> 
> 	https://patchwork.kernel.org/patch/10888741/
> 	https://patchwork.kernel.org/patch/10888745/
> 
> So, I can avoid to posting patch for Intel,
> then, you need to update it again for modern style CPU.
> Or, I can update Intel by using above macro.
> What is your opinion ?

I must admit I didn't look at the new style. With all due respect I am 
not sold, it's becoming a lot less intuitive and readable, e.g.:

+SND_SOC_DAI_LINK_CCP(aif1,
+	SND_SOC_DAI_LINK(SDL_CPU("samsung-i2s.0")),
+	SND_SOC_DAI_LINK(SDL_CODEC("wm8994-codec", "wm8994-aif1")),
+	SND_SOC_DAI_LINK(SDL_PLATFORM("samsung-i2s.0")));
+
+SND_SOC_DAI_LINK_CCP(fifo_tx,
+	SND_SOC_DAI_LINK(SDL_CPU("samsung-i2s-sec")),
+	SND_SOC_DAI_LINK(SDL_CODEC("wm8994-codec", "wm8994-aif1")),
+	SND_SOC_DAI_LINK(SDL_PLATFORM("samsung-i2s-sec")));
+
  static struct snd_soc_dai_link smdk_dai[] = {
  	{ /* Primary DAI i/f */
  		.name = "WM8994 AIF1",
  		.stream_name = "Pri_Dai",
-		.cpu_dai_name = "samsung-i2s.0",
-		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-i2s.0",
-		.codec_name = "wm8994-codec",
  		.init = smdk_wm8994_init_paiftx,
  		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
  			SND_SOC_DAIFMT_CBM_CFM,
  		.ops = &smdk_ops,
+		SND_SOC_LINK_CCP(aif1),

is this really the new direction?
Even the acronyms are not simple, it took me 15mn to figure out that CCP 
stood for CPU/Codec/Platform and I couldn't figure out what SDL means. 
The multiple repetitions of SND_SOC_DAI_LINK is also misleading, it's 
just a property of the *same* dailink that you handle.

I am even more nervous since we have a need to explicitly some cpu and 
codec dai names depending on quirks, with the additional abstraction 
it'll become plain unreadable - or we need new helpers.
