From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 9/9] ASoC: Intel: Boards: add support
	for HDA codecs
Date: Fri, 23 Feb 2018 11:04:09 -0600
Message-ID: <2536565b-4783-0829-536e-ee24e435c041@linux.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-10-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DF33326791D
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 18:04:12 +0100 (CET)
In-Reply-To: <1519373550-2545-10-git-send-email-rakesh.a.ughreja@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On 2/23/18 2:12 AM, Rakesh Ughreja wrote:
> Add support for HDA codecs. add required widgets, controls, routes
> and dai links for the same.
> 
> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> ---
>   sound/soc/intel/Kconfig                      |  1 +
>   sound/soc/intel/boards/skl_hda_dsp_common.c  | 24 +++++++++++++++++++++++
>   sound/soc/intel/boards/skl_hda_dsp_common.h  |  2 +-
>   sound/soc/intel/boards/skl_hda_dsp_generic.c | 29 ++++++++++++++++++++++++++++
>   sound/soc/intel/skylake/skl.c                | 27 ++++++++++++++++++++++----
>   5 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index ceb105c..d44cf1e 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -107,6 +107,7 @@ config SND_SOC_INTEL_SKYLAKE
>   	select SND_HDA_DSP_LOADER
>   	select SND_SOC_TOPOLOGY
>   	select SND_SOC_INTEL_SST
> +	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH

This looks odd, it beats the purpose of the clean split between platform 
and machine Kconfig added in 2017. You should select SND_SOC_HDAC_HDA in 
the config for SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH

>   	select SND_SOC_ACPI_INTEL_MATCH
>   	help
>   	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
> diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
> index 7066bed..f5fa475 100644
> --- a/sound/soc/intel/boards/skl_hda_dsp_common.c
> +++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
> @@ -73,6 +73,30 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
>   		.dpcm_playback = 1,
>   		.no_pcm = 1,
>   	},
> +	{
> +		.name = "Analog Playback and Capture",
> +		.id = 4,
> +		.cpu_dai_name = "Analog CPU DAI",
> +		.codec_name = "ehdaudio0D0",
> +		.codec_dai_name = "Analog Codec DAI",
> +		.platform_name = "0000:00:1f.3",
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.init = NULL,
> +		.no_pcm = 1,
> +	},
> +	{
> +		.name = "Digital Playback and Capture",
> +		.id = 5,
> +		.cpu_dai_name = "Digital CPU DAI",
> +		.codec_name = "ehdaudio0D0",
> +		.codec_dai_name = "Digital Codec DAI",
> +		.platform_name = "0000:00:1f.3",
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.init = NULL,
> +		.no_pcm = 1,
> +	},
>   };
>   
>   int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
> diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.h b/sound/soc/intel/boards/skl_hda_dsp_common.h
> index adbf552..a9bc92b 100644
> --- a/sound/soc/intel/boards/skl_hda_dsp_common.h
> +++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
> @@ -13,7 +13,7 @@
>   #include <sound/core.h>
>   #include <sound/jack.h>
>   
> -#define HDA_DSP_MAX_BE_DAI_LINKS 3
> +#define HDA_DSP_MAX_BE_DAI_LINKS 5
>   
>   struct skl_hda_hdmi_pcm {
>   	struct list_head head;
> diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> index 9e925ba..009683d 100644
> --- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
> +++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> @@ -18,8 +18,33 @@
>   
>   static const char *platform_name = "0000:00:1f.3";
>   
> +static const struct snd_kcontrol_new skl_hda_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +};
> +
> +static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone", NULL),
> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +	SND_SOC_DAPM_SPK("Codec Speaker", NULL),
> +	SND_SOC_DAPM_MIC("Codec Mic", NULL),
> +};

what about all the other outputs, e.g. line out? And how does this work 
with pin retasking?

> +
>   static const struct snd_soc_dapm_route skl_hda_map[] = {
>   
> +	/* HP jack connectors - unknown if we have jack detection */
> +	{ "Headphone", NULL, "Codec Output Pin1" },
> +	{ "Codec Speaker", NULL, "Codec Output Pin2" },
> +	{ "Codec Input Pin2", NULL, "Codec Mic" },
> +	{ "Codec Input Pin1", NULL, "Headset Mic" },
> +
> +	/* CODEC BE connections */
> +	{ "Analog Codec Playback", NULL, "Analog CPU Playback" },
> +	{ "Analog CPU Playback", NULL, "codec0_out" },
> +
> +	{ "codec0_in", NULL, "Analog CPU Capture" },
> +	{ "Analog CPU Capture", NULL, "Analog Codec Capture" },
> +
>   	{ "hifi3", NULL, "iDisp3 Tx"},
>   	{ "iDisp3 Tx", NULL, "iDisp3_out"},
>   	{ "hifi2", NULL, "iDisp2 Tx"},
> @@ -56,6 +81,10 @@ static struct snd_soc_card hda_soc_card = {
>   	.owner = THIS_MODULE,
>   	.dai_link = skl_hda_be_dai_links,
>   	.num_links = ARRAY_SIZE(skl_hda_be_dai_links),
> +	.controls = skl_hda_controls,
> +	.num_controls = ARRAY_SIZE(skl_hda_controls),
> +	.dapm_widgets = skl_hda_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets),
>   	.dapm_routes = skl_hda_map,
>   	.num_dapm_routes = ARRAY_SIZE(skl_hda_map),
>   	.add_dai_link = skl_hda_add_dai_link,
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 1a5ac1b..d6a008b 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -36,6 +36,7 @@
>   #include "skl-sst-dsp.h"
>   #include "skl-sst-ipc.h"
>   #include "../../../pci/hda/hda_codec.h"
> +#include "../../../soc/codecs/hdac_hda.h"
>   
>   static struct skl_machine_pdata skl_dmic_data;
>   
> @@ -632,7 +633,9 @@ static int probe_codec(struct hdac_bus *bus, int addr)
>   		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
>   	unsigned int res = -1;
>   	struct skl *skl = bus_to_skl(bus);
> +	struct hdac_hda_priv *hda_codec;
>   	struct hdac_device *hdev;
> +	int err;
>   
>   	mutex_lock(&bus->cmd_mutex);
>   	snd_hdac_bus_send_cmd(bus, cmd);
> @@ -642,11 +645,22 @@ static int probe_codec(struct hdac_bus *bus, int addr)
>   		return -EIO;
>   	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
>   
> -	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
> -	if (!hdev)
> +	hda_codec = devm_kzalloc(&skl->pci->dev, sizeof(*hda_codec),
> +								GFP_KERNEL);
> +	if (!hda_codec)
>   		return -ENOMEM;
>   
> -	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
> +	hda_codec->codec.bus = skl_to_hbus(skl);
> +	hdev = &hda_codec->codec.core;
> +
> +	err = snd_hdac_ext_bus_device_init(bus, addr, hdev);
> +	if (err < 0)
> +		return err;
> +
> +	if ((res & 0xFFFF0000) != 0x80860000)
> +		hdev->type = HDA_DEV_LEGACY;

I don't get what this test does?

> +
> +	return 0;
>   }
>   
>   /* Codec initialization */
> @@ -784,6 +798,7 @@ static int skl_create(struct pci_dev *pci,
>   	struct skl *skl;
>   	struct hdac_bus *bus;
>   	struct hda_bus *hbus;
> +	struct hdac_ext_bus_ops *ext_ops = NULL;
>   
>   	int err;
>   
> @@ -801,7 +816,11 @@ static int skl_create(struct pci_dev *pci,
>   
>   	hbus = skl_to_hbus(skl);
>   	bus = skl_to_bus(skl);
> -	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
> +
> +#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
> +	ext_ops = snd_soc_hdac_hda_get_ops();
> +#endif
> +	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
>   	bus->use_posbuf = 1;
>   	skl->pci = pci;
>   	INIT_WORK(&skl->probe_work, skl_probe_work);
> 
