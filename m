From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v4 7/8] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Wed, 25 Jul 2018 21:59:14 +0530
Message-ID: <20180725162914.GX3661@vkoul-mobl>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-8-pierre-louis.bossart@linux.intel.com>
 <20180725114745.GN3661@vkoul-mobl>
 <bdff9535-3443-41e3-5866-698253eb28bc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 5106126774A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:29:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bdff9535-3443-41e3-5866-698253eb28bc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On 25-07-18, 09:27, Pierre-Louis Bossart wrote:
> On 7/25/18 6:47 AM, Vinod wrote:

> > > +static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
> > > +			     struct snd_soc_dai *dai)
> > > +{
> > > +	struct snd_soc_component *component = dai->component;
> > > +	struct hdac_hda_priv *hda_pvt;
> > > +	struct hda_pcm_stream *hda_stream;
> > > +	struct hda_pcm *pcm;
> > > +	int ret = -ENODEV;
> > > +
> > > +	hda_pvt = snd_soc_component_get_drvdata(component);
> > > +	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
> > > +	if (!pcm)
> > > +		return -EINVAL;
> > > +
> > > +	snd_hda_codec_pcm_get(pcm);
> > > +
> > > +	hda_stream = &pcm->stream[substream->stream];
> > > +	if (hda_stream->ops.open)
> > > +		ret = hda_stream->ops.open(hda_stream, &hda_pvt->codec,
> > > +								substream);
> > 
> > are the ops not mandatory? Do you expect them to not be present?
> 
> I believe they are required and there should an error flags otherwise.

if they are required then check can be skipped

> > > +static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
> > > +			       struct snd_soc_dai *dai)
> > 
> > aligning second line the opening brace of former will help readability
> > 
> > > +static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
> > > +						 struct snd_soc_dai *dai)
> > 
> > align here too please
> 
> Yes. it feels like payback for my SoundWire comments :-)

Well it's karma :D

> > > +	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
> > > +	if (!hlink) {
> > > +		dev_err(&hdev->dev, "hdac link not found\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
> > 
> > snd_hdac_ext_bus_get_link and snd_hdac_ext_bus_link_get, yeah naming is
> > hard ;-)
> 
> Yeah. I am not happy about this one, but this is a separate problem.

Agreed and maybe that should be fixed too ;-)

> > > +	ret = snd_hda_codec_device_new(hcodec->bus,
> > > +			component->card->snd_card, hdev->addr, hcodec);
> > > +	if (ret < 0) {
> > > +		dev_err(&hdev->dev, "failed to create hda codec %d\n", ret);
> > 
> > you should drop the link reference grabbed in previous calls in error
> > here and rest of error returns?
> 
> did you mean add a link_put() ? I didn't pay attention to this part and
> indeed this needs more work.

Yes on err link_put() should be invoked. The link refcount will go for a
toss otherwise

> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright(c) 2015-17 Intel Corporation.
> > > + */
> > 
> > same patch different style ;/
> 
> ok. Checkpatch reports different things for SPDX but I'll align on the C++
> version.

Yeah we still have bunch of versions floating out. Only consensus seems
to be for SPDX line in C99 style. So pick one you like and be consistent
with it.

> > > +static void load_codec_module(struct hda_codec *codec)
> > > +{
> > > +#ifdef MODULE
> > > +	char modalias[MODULE_NAME_LEN];
> > > +	const char *mod = NULL;
> > > +
> > > +	snd_hdac_codec_modalias(&codec->core, modalias, sizeof(modalias));
> > > +	mod = modalias;
> > > +	dev_dbg(&codec->core.dev, "loading %s codec module\n", mod);
> > > +	request_module(mod);
> > 
> > any reason why we dont want to use standard loading mechanisms for
> > these?
> 
> what standard loading mechanisms are you referring to here? There is no ACPI
> doing the work for us.

Standard linux driver loading. udev loads the driver when the device is
created and we match. Like the one we do for soundwire, hdmi (ext hda)
etc.

-- 
~Vinod
