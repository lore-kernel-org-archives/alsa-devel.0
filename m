From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc.h: add sound dai_link
	connection macro
Date: Mon, 13 May 2019 08:47:30 -0500
Message-ID: <ea411ee1-f3c9-c98e-48d2-005c9e7034fe@linux.intel.com>
References: <87o94daivm.wl-kuninori.morimoto.gx@renesas.com>
 <87mujxaiuo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A832CF89633
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 16:41:41 +0200 (CEST)
In-Reply-To: <87mujxaiuo.wl-kuninori.morimoto.gx@renesas.com>
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

Sorry about the delays in reviewing.

> +/*
> + * Sample 1 : Single CPU/Codec/Platform
> + *
> + * SND_SOC_DAILINK_DEFS(test,
> + *	DAILINK_COMPONENT_ARRAY(COMPONENT_FE("cpu_dai")),
> + *	DAILINK_COMPONENT_ARRAY(COMPONENT_BE("codec", "codec_dai")),
> + *	DAILINK_COMPONENT_ARRAY(COMPONENT_DMA("platform")));

the syntax looks fine, but the _FE/_BE/_DMA suffix is a bit misleading. 
The _FE in the examples is actually a DPCM BE, and the _BE is really a 
codec which isn't related to DPCM at all, and platform has typically 
nothing to do with DMA?

Why not keep the initial conventions and use e.g. COMPONENT_CPU, 
COMPONENT_CODEC, COMPONENT_PLATFORM to avoid introducing new concepts? 
If it's starting to be too many letters, then we can use the COMP 
acronym e.g DAILINK_COMP_ARRAY(COMP_CPU("cpu_dai"))

Thanks
-Pierre




> + *
> + * struct snd_soc_dai_link link = {
> + *	...
> + *	SND_SOC_DAILINK_REG(test),
> + * };
> + *
> + * Sample 2 : Multi CPU/Codec, no Platform
> + *
> + * SND_SOC_DAILINK_DEFS(test,
> + *	DAILINK_COMPONENT_ARRAY(COMPONENT_FE("cpu_dai1"),
> + *				COMPONENT_FE("cpu_dai2")),
> + *	DAILINK_COMPONENT_ARRAY(COMPONENT_BE("codec1", "codec_dai1"),
> + *				COMPONENT_BE("codec2", "codec_dai2")));
> + *
> + * struct snd_soc_dai_link link = {
> + *	...
> + *	SND_SOC_DAILINK_REG(test),
> + * };
> + *
> + * Sample 3 : Define each CPU/Codec/Platform manually
> + *
> + * SND_SOC_DAILINK_DEF(test_cpu,
> + *		DAILINK_COMPONENT_ARRAY(COMPONENT_FE("cpu_dai1"),
> + *					COMPONENT_FE("cpu_dai2")));
> + * SND_SOC_DAILINK_DEF(test_codec,
> + *		DAILINK_COMPONENT_ARRAY(COMPONENT_BE("codec1", "codec_dai1"),
> + *					COMPONENT_BE("codec2", "codec_dai2")));
> + * SND_SOC_DAILINK_DEF(test_platform,
> + *		DAILINK_COMPONENT_ARRAY(COMPONENT_DMA("platform")));
> + *
> + * struct snd_soc_dai_link link = {
> + *	...
> + *	SND_SOC_DAILINK_REG(test_cpu,
> + *			    test_codec,
> + *			    test_platform),
> + * };
> + *
> + * Sample 4 : Sample3 without platform
> + *
> + * struct snd_soc_dai_link link = {
> + *	...
> + *	SND_SOC_DAILINK_REG(test_cpu,
> + *			    test_codec);
> + * };
> + */
> +
> +#define SND_SOC_DAILINK_REG1(name)	 SND_SOC_DAILINK_REG3(name##_cpus, name##_codecs, name##_platforms)
> +#define SND_SOC_DAILINK_REG2(cpu, codec) SND_SOC_DAILINK_REG3(cpu, codec, null_dailink_component)
> +#define SND_SOC_DAILINK_REG3(cpu, codec, platform)	\
> +	.cpus		= cpu,				\
> +	.num_cpus	= ARRAY_SIZE(cpu),		\
> +	.codecs		= codec,			\
> +	.num_codecs	= ARRAY_SIZE(codec),		\
> +	.platforms	= platform,			\
> +	.num_platforms	= ARRAY_SIZE(platform)
> +
> +#define SND_SOC_DAILINK_REGx(_1, _2, _3, func, ...) func
> +#define SND_SOC_DAILINK_REG(...) \
> +	SND_SOC_DAILINK_REGx(__VA_ARGS__,		\
> +			SND_SOC_DAILINK_REG3,	\
> +			SND_SOC_DAILINK_REG2,	\
> +			SND_SOC_DAILINK_REG1)(__VA_ARGS__)
> +
> +#define SND_SOC_DAILINK_DEF(name, def...)		\
> +	static struct snd_soc_dai_link_component name[]	= { def }
> +
> +#define SND_SOC_DAILINK_DEFS(name, cpu, codec, platform...)	\
> +	SND_SOC_DAILINK_DEF(name##_cpus, cpu);			\
> +	SND_SOC_DAILINK_DEF(name##_codecs, codec);		\
> +	SND_SOC_DAILINK_DEF(name##_platforms, platform)
> +
> +#define DAILINK_COMPONENT_ARRAY(param...)	param
> +#define COMPONENT_EMPTY()			{ }
> +#define COMPONENT_FE(_dai)			{ .dai_name = _dai, }
> +#define COMPONENT_BE(_name, _dai)		{ .name = _name, .dai_name = _dai, }
> +#define COMPONENT_DMA(_name)			{ .name = _name }
> +#define COMPONENT_DUMMY()			{ .name = "snd-soc-dummy", .dai_name = "snd-soc-dummy-dai", }
> +
> +extern struct snd_soc_dai_link_component null_dailink_component[0];
> +
> +
>   struct snd_soc_codec_conf {
>   	/*
>   	 * specify device either by device name, or by
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index f6765b0..dd0c625 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -58,6 +58,12 @@ static LIST_HEAD(unbind_card_list);
>   	list_for_each_entry(component, &component_list, list)
>   
>   /*
> + * This is used if driver don't need to have CPU/Codec/Platform
> + * dai_link. see soc.h
> + */
> +struct snd_soc_dai_link_component null_dailink_component[0];
> +
> +/*
>    * This is a timeout to do a DAPM powerdown after a stream is closed().
>    * It can be used to eliminate pops between different playback streams, e.g.
>    * between two audio tracks.
> 
