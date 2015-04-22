From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Wed, 22 Apr 2015 12:16:11 +0100
Message-ID: <1429701371.2695.12.camel@loki>
References: <1429217295.7100.19.camel@loki> <5536825B.3060302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8539C26057F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 13:16:20 +0200 (CEST)
In-Reply-To: <5536825B.3060302@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-04-21 at 19:01 +0200, Lars-Peter Clausen wrote:
> On 04/16/2015 10:48 PM, Liam Girdwood wrote:
> > The ASoC topology UAPI header defines the structures required to define
> > any DSP firmware audio topology and control objects from userspace.
> >
> > The following objects are supported :-
> >   o kcontrols including TLV controls.
> >   o DAPM widgets and graph elements
> >   o Vendor bespoke objects.
> >   o Coefficient data
> >   o FE PCM capabilities and config.
> >   o BE link capabilities and config.
> >   o Codec <-> codec link capabilities and config.
> >   o Topology object manifest.
> >
> > The file format is simple and divided into blocks for each object type and
> > each block has a header that defines it's size and type. Blocks can be in
> > any order of type and can either all be in a single file or spread across
> > more than one file. Blocks also have a group identifier ID so that they can
> > be loaded and unloaded by ID.
> >
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> I'm a bit concerned with how much ASoC internals this makes ABI, set in 
> stone forever. Not all our internal abstractions are that great and 
> exporting them sets them in stone forever.

You should have seen V1 about 2 years ago ... many internal structures
were exported at that time !

> 
> [...]
> > diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> > new file mode 100644
> > index 0000000..dde7133
> > --- /dev/null
> > +++ b/include/uapi/sound/asoc.h
> > @@ -0,0 +1,420 @@
> > +/*
> > + * uapi/sound/asoc.h -- ALSA SoC Firmware Controls and DAPM
> > + *
> > + * Copyright (C) 2012 Texas Instruments Inc.
> > + * Copyright (C) 2015 Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Simple file API to load FW that includes mixers, coefficients, DAPM graphs,
> > + * algorithms, equalisers, DAIs, widgets etc.
> > +*/
> > +
> > +#ifndef __LINUX_UAPI_SND_ASOC_H
> > +#define __LINUX_UAPI_SND_ASOC_H
> > +
> > +#include <linux/types.h>
> > +#include <sound/asound.h>
> > +
> > +/*
> > + * Numeric IDs for stock mixer types that are used to map and enumerate FW
> > + * based mixers.
> > + */
> > +#define SOC_CONTROL_ID_PUT(p)	((p & 0xff) << 16)
> > +#define SOC_CONTROL_ID_GET(g)	((g & 0xff) << 8)
> > +#define SOC_CONTROL_ID_INFO(i)	((i & 0xff) << 0)
> > +#define SOC_CONTROL_ID(g, p, i)	\
> > +	(SOC_CONTROL_ID_PUT(p) | SOC_CONTROL_ID_GET(g) |\
> > +	SOC_CONTROL_ID_INFO(i))
> > +
> > +#define SOC_CONTROL_GET_ID_PUT(id)	((id & 0xff0000) >> 16)
> > +#define SOC_CONTROL_GET_ID_GET(id)	((id & 0x00ff00) >> 8)
> > +#define SOC_CONTROL_GET_ID_INFO(id)	((id & 0x0000ff) >> 0)
> > +
> > +/* individual kcontrol info types - can be mixed with other types */
> > +#define SOC_CONTROL_TYPE_EXT		0	/* driver defined */
> > +#define SOC_CONTROL_TYPE_VOLSW		1
> > +#define SOC_CONTROL_TYPE_VOLSW_SX	2
> > +#define SOC_CONTROL_TYPE_VOLSW_S8	3
> > +#define SOC_CONTROL_TYPE_VOLSW_XR_SX	4
> > +#define SOC_CONTROL_TYPE_ENUM		6
> > +#define SOC_CONTROL_TYPE_ENUM_EXT	7
> > +#define SOC_CONTROL_TYPE_BYTES		8
> > +#define SOC_CONTROL_TYPE_BOOL_EXT	9
> > +#define SOC_CONTROL_TYPE_ENUM_VALUE	10
> > +#define SOC_CONTROL_TYPE_RANGE		11
> > +#define SOC_CONTROL_TYPE_STROBE		12
> > +#define SOC_CONTROL_TYPE_BYTES_EXT	13
> > +#define SOC_CONTROL_TYPE_VOLSW_EXT	14
> > +
> > +/* convenience macros for compound control type mappings */
> > +#define SOC_CONTROL_IO_VOLSW \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_VOLSW, \
> > +		SOC_CONTROL_TYPE_VOLSW, \
> > +		SOC_CONTROL_TYPE_VOLSW)
> > +#define SOC_CONTROL_IO_VOLSW_SX \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_VOLSW_SX, \
> > +		SOC_CONTROL_TYPE_VOLSW_SX, \
> > +		SOC_CONTROL_TYPE_VOLSW)
> > +#define SOC_CONTROL_IO_VOLSW_S8 \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_VOLSW_S8, \
> > +		SOC_CONTROL_TYPE_VOLSW_S8, \
> > +		SOC_CONTROL_TYPE_VOLSW_S8)
> 
> S8, is just a special case of the normal VOLSW

These macros are just mirroring the kernel versions for completeness, I
could remove it but that could mean confusion for anyone expecting it to
be present. 

> 
> > +#define SOC_CONTROL_IO_VOLSW_XR_SX \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_VOLSW_XR_SX, \
> > +		SOC_CONTROL_TYPE_VOLSW_XR_SX, \
> > +		SOC_CONTROL_TYPE_VOLSW_XR_SX)
> > +#define SOC_CONTROL_IO_EXT \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_VOLSW)
> > +#define SOC_CONTROL_IO_ENUM \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_ENUM, \
> > +		SOC_CONTROL_TYPE_ENUM, \
> > +		SOC_CONTROL_TYPE_ENUM)
> > +#define SOC_CONTROL_IO_ENUM_EXT \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_ENUM_EXT)
> > +#define SOC_CONTROL_IO_BYTES \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_BYTES, \
> > +		SOC_CONTROL_TYPE_BYTES, \
> > +		SOC_CONTROL_TYPE_BYTES)
> > +#define SOC_CONTROL_IO_BOOL_EXT \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_BOOL_EXT)
> > +#define SOC_CONTROL_IO_ENUM_VALUE \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_ENUM_VALUE, \
> > +		SOC_CONTROL_TYPE_ENUM_VALUE, \
> > +		SOC_CONTROL_TYPE_ENUM)
> > +#define SOC_CONTROL_IO_RANGE \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_RANGE, \
> > +		SOC_CONTROL_TYPE_RANGE, \
> > +		SOC_CONTROL_TYPE_RANGE)
> > +#define SOC_CONTROL_IO_STROBE \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_STROBE, \
> > +		SOC_CONTROL_TYPE_STROBE, \
> > +		SOC_CONTROL_TYPE_STROBE)
> > +#define SOC_CONTROL_IO_BYTES_EXT \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_BYTES_EXT)
> > +#define SOC_CONTROL_IO_VOLSW_EXT \
> > +	SOC_CONTROL_ID(SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_EXT, \
> > +		SOC_CONTROL_TYPE_VOLSW)
> > +
> 
> How exactly are the _EXT controls going to work? They need callbacks for 
> reading and writing the control state.

The info/get/put methods can be bound to component driver callback using
ID numbers.

> 
> [...]
> > +/* dapm widget types */
> > +enum snd_soc_dapm_type {
> > +	snd_soc_dapm_input = 0,		/* input pin */
> > +	snd_soc_dapm_output,		/* output pin */
> > +	snd_soc_dapm_mux,		/* selects 1 analog signal from many inputs */
> > +	snd_soc_dapm_mixer,		/* mixes several analog signals together */
> > +	snd_soc_dapm_mixer_named_ctl,	/* mixer with named controls */
> > +	snd_soc_dapm_pga,		/* programmable gain/attenuation (volume) */
> > +	snd_soc_dapm_out_drv,		/* output driver */
> > +	snd_soc_dapm_adc,		/* analog to digital converter */
> > +	snd_soc_dapm_dac,		/* digital to analog converter */
> > +	snd_soc_dapm_micbias,		/* microphone bias (power) */
> > +	snd_soc_dapm_mic,		/* microphone */
> > +	snd_soc_dapm_hp,		/* headphones */
> > +	snd_soc_dapm_spk,		/* speaker */
> > +	snd_soc_dapm_line,		/* line input/output */
> > +	snd_soc_dapm_switch,		/* analog switch */
> > +	snd_soc_dapm_vmid,		/* codec bias/vmid - to minimise pops */
> > +	snd_soc_dapm_pre,		/* machine specific pre widget - exec first */
> > +	snd_soc_dapm_post,		/* machine specific post widget - exec last */
> > +	snd_soc_dapm_supply,		/* power/clock supply */
> > +	snd_soc_dapm_regulator_supply,	/* external regulator */
> > +	snd_soc_dapm_clock_supply,	/* external clock */
> > +	snd_soc_dapm_aif_in,		/* audio interface input */
> > +	snd_soc_dapm_aif_out,		/* audio interface output */
> > +	snd_soc_dapm_siggen,		/* signal generator */
> > +	snd_soc_dapm_dai_in,		/* link to DAI structure */
> > +	snd_soc_dapm_dai_out,
> > +	snd_soc_dapm_dai_link,		/* link between two DAI structures */
> > +	snd_soc_dapm_kcontrol,		/* Auto-disabled kcontrol */
> > +};
> > +
> 
> This is leaking to much internals in my opinion. Some of those are only 
> meant to be used by the DAPM core, some of those only work if they have 
> proper callbacks specified, some of them are deprecated. Exporting all of 
> them makes them ABI, impossible to ever modify or remove. In my opinion we 
> should limit this to the types of widgets that make sense to be used in a 
> firmware.

The alternative here is to map them to macro ID numbers which I dont
mind doing. Btw, we should really mark the deprecated widget types so
they are not used in new drivers and then can eventually be removed.

Liam

> 
> [...]
