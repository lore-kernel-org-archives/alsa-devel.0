From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 01/15] ASoC: SOF: Intel: hda: save handle
 to sdev in sof_intel_hda_stream
Date: Thu, 13 Jun 2019 10:00:50 +0200
Message-ID: <20190613092001.2027f42a@xxx>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
 <20190612172347.22338-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE7C5F80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 09:57:04 +0200 (CEST)
In-Reply-To: <20190612172347.22338-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Jun 2019 12:23:33 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> Add a snd_sof_dev member to sof_intel_hda_stream. This will be
> used to access the snd_sof_dev during link hw_params callback.
> 
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> ---
>  sound/soc/sof/intel/hda-stream.c | 4 ++++
>  sound/soc/sof/intel/hda.h        | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/sound/soc/sof/intel/hda-stream.c
> b/sound/soc/sof/intel/hda-stream.c index c92006f89499..1cd94e7631a8
> 100644 --- a/sound/soc/sof/intel/hda-stream.c
> +++ b/sound/soc/sof/intel/hda-stream.c
> @@ -564,6 +564,8 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
>  		if (!hda_stream)
>  			return -ENOMEM;
>  
> +		hda_stream->sdev = sdev;
> +
>  		stream = &hda_stream->hda_stream;
>  
>  		stream->pphc_addr = sdev->bar[HDA_DSP_PP_BAR] +
> @@ -617,6 +619,8 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
>  		if (!hda_stream)
>  			return -ENOMEM;
>  
> +		hda_stream->sdev = sdev;
> +
>  		stream = &hda_stream->hda_stream;
>  

Just one thing, you have two rather big for loops here, one for capture
and other for playback, they are almost identical apart for ~2 lines.
Maybe share this code and only put the differences into ifs?

>  		/* we always have DSP support */
> diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
> index 6c7dee2627d0..502b0a3c2e3c 100644
> --- a/sound/soc/sof/intel/hda.h
> +++ b/sound/soc/sof/intel/hda.h
> @@ -409,6 +409,7 @@ static inline struct hda_bus *sof_to_hbus(struct
> snd_sof_dev *s) }
>  
>  struct sof_intel_hda_stream {
> +	struct snd_sof_dev *sdev;
>  	struct hdac_ext_stream hda_stream;
>  	struct sof_intel_stream stream;
>  	int hw_params_upon_resume; /* set up hw_params upon resume */
