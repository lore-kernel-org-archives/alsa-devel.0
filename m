From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/6] compress: add API header and driver
	header	files
Date: Fri, 2 Dec 2011 10:58:56 -0800
Message-ID: <24122.7302853533$1322852354@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D17@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 653ED245FD
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 19:59:02 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCA82D17@bgsmsx502.gar.corp.intel.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>, 'Vinod Koul' <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> > + * @decoded: Frames decoded by DSP
> > + * @rendered: Frames rendered by DSP into a mixer or an audio output
> > + * @sampling_rate: sampling rate of audio  */ struct
> snd_compr_tstamp {
> > +	size_t copied_bytes;
> > +	size_t copied_total;
> > +	size_t decoded;
> > +	size_t rendered;
> > +	__u32 sampling_rate;
> 
> Is it possible to track the rendering sampling rate in the driver
> itself?

What do you mean? This is a streaming API, the actual rendering rate will
depend on what endpoint you play on.

> > +struct snd_compr_caps {
> > +	__u32 num_codecs;
> > +	__u32 min_fragment_size;
> > +	__u32 max_fragment_size;
> > +	__u32 min_fragments;
> > +	__u32 max_fragments;
> > +	__u32 codecs[MAX_NUM_CODECS];
> > +	__u32 reserved[11];
> 
> Can we add number of compress streams supported in DSP?

You are confusing number of formats supported with number of streams
supported. The latter is exposed through the actual devices supported.
