From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 4/6] compress: add API header and driver
 header	files
Date: Sun, 4 Dec 2011 13:11:47 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7952@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D17@bgsmsx502.gar.corp.intel.com>
	<000301ccb124$72a53370$57ef9a50$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A23BE245D7
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 08:41:56 +0100 (CET)
In-Reply-To: <000301ccb124$72a53370$57ef9a50$@bossart@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 'Vinod Koul' <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> > > + * @decoded: Frames decoded by DSP
> > > + * @rendered: Frames rendered by DSP into a mixer or an audio
> > > + output
> > > + * @sampling_rate: sampling rate of audio  */ struct
> > snd_compr_tstamp {
> > > +	size_t copied_bytes;
> > > +	size_t copied_total;
> > > +	size_t decoded;
> > > +	size_t rendered;
> > > +	__u32 sampling_rate;
> >
> > Is it possible to track the rendering sampling rate in the driver
> > itself?
> 
> What do you mean? This is a streaming API, the actual rendering rate will depend on
> what endpoint you play on.

I guess the driver should know the sampling rate of the endpoint. If only the DSP knows 
about the endpoint sampling rate, this will make sense.

> 
> > > +struct snd_compr_caps {
> > > +	__u32 num_codecs;
> > > +	__u32 min_fragment_size;
> > > +	__u32 max_fragment_size;
> > > +	__u32 min_fragments;
> > > +	__u32 max_fragments;
> > > +	__u32 codecs[MAX_NUM_CODECS];
> > > +	__u32 reserved[11];
> >
> > Can we add number of compress streams supported in DSP?
> 
> You are confusing number of formats supported with number of streams supported.
> The latter is exposed through the actual devices supported.

No, DSP may be able to support only so many simultaneous streams at any point of time. 
Yet, DSP can support any number of formats. Though the device entry may be created for
each compressed stream, how will the user space programs get the number of compressed streams supported?
