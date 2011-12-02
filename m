From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 4/6] compress: add API header and driver
 header	files
Date: Fri, 2 Dec 2011 21:09:42 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCA82D17@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AB6424423
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 16:40:06 +0100 (CET)
In-Reply-To: <1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> +struct snd_compr_runtime {
> +	snd_pcm_state_t state;
> +	struct snd_compr_ops *ops;
> +	void *buffer;
> +	size_t buffer_size;
> +	size_t fragment_size;
> +	unsigned int fragments;
> +	size_t hw_pointer;
> +	size_t app_pointer;
> +	size_t bytes_written;
Is it the bytes written to the ring buffer? 

> +	size_t bytes_copied;
Is it the bytes copied by the DSP from ring buffer?

> +	wait_queue_head_t sleep;
> +};
> +
> +/**
> +mandatory  */ struct snd_compr_ops {
> +	int (*open)(struct snd_compr_stream *stream);
> +	int (*free)(struct snd_compr_stream *stream);
> +	int (*set_params)(struct snd_compr_stream *stream,
> +			struct snd_compr_params *params);
> +	int (*get_params)(struct snd_compr_stream *stream,
> +			struct snd_compr_params *params);
> +	int (*trigger)(struct snd_compr_stream *stream, int cmd);
> +	int (*pointer)(struct snd_compr_stream *stream,
> +			struct snd_compr_tstamp *tstamp);
> +	int (*copy)(struct snd_compr_stream *stream, const char __user *buf,
> +		       size_t count);
> +	int (*mmap)(struct snd_compr_stream *stream,
> +			struct vm_area_struct *vma);
> +	int (*ack)(struct snd_compr_stream *stream, size_t bytes);
> +	int (*get_caps) (struct snd_compr_stream *stream,
> +			struct snd_compr_caps *caps);
> +	int (*get_codec_caps) (struct snd_compr_stream *stream,
> +			struct snd_compr_codec_caps *codec); };

Documentation (PATCH 1/6) talks about  get_codecs which is missing? 
Fix the documentation or add the API?

> + */
> +struct snd_compr {
> +	const char *name;
> +	unsigned int pb;
> +	unsigned int cap;

Can we use a single variable if it just 

> +	struct device *dev;
> +	struct snd_compr_ops *ops;
> +	void *private_data;
> +	struct snd_card *card;
> +	struct mutex lock;
> +	int device;
> +};
> +
> + * For recording: we may want to know when a frame is available or when
> + * at least one frame is available for userspace, a different
> + * snd_compress_frame_elapsed() callback should be used  */ void
> +snd_compr_fragment_elapsed(struct snd_compr_stream *stream); void
> +snd_compr_frame_elapsed(struct snd_compr_stream *stream);

What is the use of this API? DSP could send only fragment elapsed.
Not sure we need to received interrupt for every frame. The system will be flooded
with interrupts.

> +/**
> + * struct snd_compr_tstamp: timestamp descriptor
> + * @copied_bytes: Number of bytes offset in ring buffer to DSP
> + * @copied_total: Total number of bytes copied from ring buffer to DSP
> + * @decoded: Frames decoded by DSP
> + * @rendered: Frames rendered by DSP into a mixer or an audio output
> + * @sampling_rate: sampling rate of audio  */ struct snd_compr_tstamp {
> +	size_t copied_bytes;
> +	size_t copied_total;
> +	size_t decoded;
> +	size_t rendered;
> +	__u32 sampling_rate;

Is it possible to track the rendering sampling rate in the driver itself? 

> +struct snd_compr_caps {
> +	__u32 num_codecs;
> +	__u32 min_fragment_size;
> +	__u32 max_fragment_size;
> +	__u32 min_fragments;
> +	__u32 max_fragments;
> +	__u32 codecs[MAX_NUM_CODECS];
> +	__u32 reserved[11];

Can we add number of compress streams supported in DSP?

> +};
> +
> +/**
> + * struct snd_compr_codec_caps: query capability of codec
> + * @codec: codec for which capability is queried
> + * @num_descriptors: number of codec descriptors
> + * @descriptor: array of codec capability descriptor  */ struct
> +snd_compr_codec_caps {
> +	__u32 codec;
> +	__u32 num_descriptors;
> +	struct snd_codec_desc descriptor[MAX_NUM_CODEC_DESCRIPTORS];
> +};
> +
