From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/2] ASoC: core: Add API to use DMI name in
 sound card long name
Date: Wed, 21 Dec 2016 16:01:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A04E2E@shsmsx102.ccr.corp.intel.com>
References: <cover.1482324245.git.mengdong.lin@linux.intel.com>
 <748589b74f8f4a6fefe7e545c21a6db5e71a74e1.1482324245.git.mengdong.lin@linux.intel.com>
 <9511f55d-8a49-7e32-7faf-9d3fa26820ca@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 87B982668DC
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 17:01:47 +0100 (CET)
In-Reply-To: <9511f55d-8a49-7e32-7faf-9d3fa26820ca@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Wednesday, December 21, 2016 10:37 PM
> To: mengdong.lin@linux.intel.com; alsa-devel@alsa-project.org;
> broonie@kernel.org
> Cc: tiwai@suse.de; Lin, Mengdong <mengdong.lin@intel.com>;
> liam.r.girdwood@linux.intel.com; Koul, Vinod <vinod.koul@intel.com>;
> Bossart, Pierre-louis <pierre-louis.bossart@intel.com>
> Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: core: Add API to use DMI name in
> sound card long name
> 
> 
> >  /* Utility functions to get clock rates from various things */  int
> > snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
> > int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
> @@
> > -1094,6 +1096,8 @@ struct snd_soc_card {
> >  	const char *name;
> >  	const char *long_name;
> >  	const char *driver_name;
> > +	char dmi_longname[80];
> 
> why 80? is this linked to DMI restrictions on board/product names?

Because kernel uses a 80-character array to give the card long name to user space, in struct snd_ctl_card_info in include/uapi/sound/asound.h
 
> >
> > +/**
> > + * snd_soc_set_dmi_name() - Register DMI names to card
> > + * @card: The card to register DMI names
> > + * @flavour: The flavour "differentiator" for the card amongst its peers.
> > + *
> > + * Intel DSP platform drivers are used by many different devices but
> > +are
> > + * difficult for userspace to differentiate, since machine drivers
> > +ususally
> > + * use their own name as the card name (short name) and leave the
> > +card long
> > + * name blank. This function will allow DMI info to be used in the
> > +sound
> > + * card long name, thereby helping userspace load the correct UCM
> > +(Use Case
> > + * Manager) configuration.
> > + * Possible card long names may be:
> > + * broadwell-rt286-Dell Inc.-XPS 13 9343-0310JH
> > + * broadwell-rt286-Intel Corp.-Broadwell Client platform-Wilson Beach
> > +SDS
> > + * bytcr-rt5640-ASUSTeK COMPUTER INC.-T100TA-T100TA
> > + * bytcr-rt5651-Circuitco-Minnowboard Max D0 PLATFORM-MinnowBoard
> MAX
> 
> You may want to add a comment that the '.' is not a separator but part of
> the DMI name. I was trying to figure out why there were cases with .-

Okay, I'll add the comment. Actually the '-' is not necessary for the user space UCM code to do the matching. It's just give a hint to the developer to identify DMI fields in the card long name. I choose '-'  since both '.' and SPACE can be part of the DMI vendor or product names. I'll to add a UCM command to show both the card long name and its best matched configuration file, for developers to revise the name for a new configuration file.
 
Thanks
Mengdong
