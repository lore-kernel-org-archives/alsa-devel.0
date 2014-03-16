From: "Banajit Goswami" <bgoswami@codeaurora.org>
Subject: Re: compress: adding support for hardware dependent
 params
Date: Sun, 16 Mar 2014 05:55:37 -0000
Message-ID: <77e1ff531b0670bae0c47d32a76bb6f4.squirrel@www.codeaurora.org>
References: <CAES_P+_Wztn3udEbc5vcUgAmFKuNLXh6MwHpcOSzLkah0c0Oxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 7930126089A
 for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2014 07:01:20 +0100 (CET)
In-Reply-To: <CAES_P+_Wztn3udEbc5vcUgAmFKuNLXh6MwHpcOSzLkah0c0Oxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linux.intel.com, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

>>  We have a requirement, where we need to set a number of hardware
>> specific
>> parameters for compressed offload use-cases, before starting a stream.
>> As
>> these parameters need to be set once for the entire session, we would
>> like to explore the best way to set these additional parameters
>> somewhere
>> before calling trigger() function.
>>  Below are few of the proposed solutions that we could think of at this
>> point for getting this done-
> As you have not mentioned what kind of metadata you are talking about
> I am assuming if your meta data can fit in below structure then we already
> have a code in upstream which takes care of your need.
>
> 140 struct snd_compr_metadata {
> 141          __u32 key;
> 142          __u32 value[8];
> 143 };
>
> Structure snd_compr_ops has set_metadata and get_metadata callbacks
> which you can use for your need.
>

 We can probably use the same snd_compr_metadata structure for setting the
hardware specific parameters, but the only issue is that, currently this
structure is being used only from compress_set_gapless_metadata() in
external/tinycompress/compress.c to set metadata specific to gapless
audio. The parameters we are looking to set is not specific to gapless
audio, but rather a few hardware/board specific parameters (for passing
to our driver)

I think, the best way to use the same structure and have the new
requirement fulfilled is that-

1. Define a new KEY inside the enum in
external/kernel-headers/original/sound/compress_offload.h

enum {
	SNDRV_COMPRESS_ENCODER_PADDING = 1,
	SNDRV_COMPRESS_ENCODER_DELAY = 2,
	SNDRV_COMPRESS_HW_SPECIFIC_METADATA = 3,
};

2. Have a new generic function (not specific to gapless audio) in
external/tinycompress/compress.c to call driver IOCTL function, to set the
H/W specific parameters-

int compress_set_metadata(struct compress *compress,
	struct compr_gapless_mdata *mdata)
{
	struct snd_compr_metadata metadata;
	int version;

	if (!is_compress_ready(compress))
		return oops(compress, ENODEV, "device not ready");

	version = get_compress_version(compress);
	if (version <= 0)
		return -1;

	if (version < SNDRV_PROTOCOL_VERSION(0, 1, 1))
		return oops(compress, ENXIO, "gapless apis not supported in kernel");

	metadata.key = SNDRV_COMPRESS_HW_SPECIFIC_METADATA;
	metadata.value[0] = mdata->hw_specific_metadata;
	if (ioctl(compress->fd, SNDRV_COMPRESS_SET_METADATA, &metadata))
		return oops(compress, errno, "can't set metadata for stream\n");

	return 0;
}

Let me know your comment on this.

Thanks,
Banajit

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
