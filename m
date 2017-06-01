From: "Singh, Guneshwor" <guneshwor.o.singh@intel.com>
Subject: Re: [PATCH 1/3] pcm: add support to get PCM sample
	rate from name
Date: Thu, 1 Jun 2017 09:39:53 +0530
Message-ID: <20170601040953.GA16589@g2>
References: <20170531134646.9081-1-guneshwor.o.singh@intel.com>
 <s5h37bl16ay.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4E5266FD0
 for <alsa-devel@alsa-project.org>; Thu,  1 Jun 2017 06:09:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h37bl16ay.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: vinod.koul@intel.com, mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 31, 2017 at 03:53:25PM +0200, Takashi Iwai wrote:
> On Wed, 31 May 2017 15:46:44 +0200,
> <guneshwor.o.singh@intel.com> wrote:
> > 
> > From: Guneshwor Singh <guneshwor.o.singh@intel.com>
> > 
> > Get PCM sample rate from rate name similar to snd_pcm_format_value() which
> > retrieves format from format name.
> > 
> > Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
> 
> The enum is only for internal, so it shouldn't be exposed as a public
> API.  I don't mind if it's only for alsa-lib internals, though.
> 
It is only for alsa-lib internals and required to be used in topology
conf parsing. Is it okay to have the enum in src/topology/pcm.c ?
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  include/pcm.h | 38 ++++++++++++++++++++++++++++++++++++++
> >  src/pcm/pcm.c | 37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> > 
> > diff --git a/include/pcm.h b/include/pcm.h
> > index 0be1a321..81bc55b1 100644
> > --- a/include/pcm.h
> > +++ b/include/pcm.h
> > @@ -119,6 +119,43 @@ typedef enum _snd_pcm_access {
> >  	SND_PCM_ACCESS_LAST = SND_PCM_ACCESS_RW_NONINTERLEAVED
> >  } snd_pcm_access_t;
> >  
> > +/** PCM sample rate */
> > +typedef enum _snd_pcm_rates {
> > +	/** Unknown */
> > +	SND_PCM_RATE_UNKNOWN = -1,
> > +	/** 5512 Hz sample rate */
> > +	SND_PCM_RATE_5512 = 0,
> > +	/** 8000 Hz sample rate */
> > +	SND_PCM_RATE_8000,
> > +	/** 11025 Hz sample rate */
> > +	SND_PCM_RATE_11025,
> > +	/** 16000 Hz sample rate */
> > +	SND_PCM_RATE_16000,
> > +	/** 22050 Hz sample rate */
> > +	SND_PCM_RATE_22050,
> > +	/** 32000 Hz sample rate */
> > +	SND_PCM_RATE_32000,
> > +	/** 44100 Hz sample rate */
> > +	SND_PCM_RATE_44100,
> > +	/** 48000 Hz sample rate */
> > +	SND_PCM_RATE_48000,
> > +	/** 64000 Hz sample rate */
> > +	SND_PCM_RATE_64000,
> > +	/** 88200 Hz sample rate */
> > +	SND_PCM_RATE_88200,
> > +	/** 96000 Hz sample rate */
> > +	SND_PCM_RATE_96000,
> > +	/** 176400 Hz sample rate */
> > +	SND_PCM_RATE_176400,
> > +	/** 192000 Hz sample rate */
> > +	SND_PCM_RATE_192000,
> > +	/** continuous range within rate_min and rate_max */
> > +	SND_PCM_RATE_CONTINUOUS = 30,
> > +	/** more continuous range */
> > +	SND_PCM_RATE_KNOT = 31,
> > +	SND_PCM_RATE_LAST = SND_PCM_RATE_KNOT,
> > +} snd_pcm_rates_t;
> > +
> >  /** PCM sample format */
> >  typedef enum _snd_pcm_format {
> >  	/** Unknown */
> > @@ -1047,6 +1084,7 @@ const char *snd_pcm_format_description(const snd_pcm_format_t format);
> >  const char *snd_pcm_subformat_name(const snd_pcm_subformat_t subformat);
> >  const char *snd_pcm_subformat_description(const snd_pcm_subformat_t subformat);
> >  snd_pcm_format_t snd_pcm_format_value(const char* name);
> > +snd_pcm_rates_t snd_pcm_rate_value(const char* name);
> >  const char *snd_pcm_tstamp_mode_name(const snd_pcm_tstamp_t mode);
> >  const char *snd_pcm_state_name(const snd_pcm_state_t state);
> >  
> > diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> > index 200b10c2..bff1b949 100644
> > --- a/src/pcm/pcm.c
> > +++ b/src/pcm/pcm.c
> > @@ -1722,6 +1722,7 @@ static int __snd_pcm_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds,
> >  #define START(v) [SND_PCM_START_##v] = #v
> >  #define HW_PARAM(v) [SND_PCM_HW_PARAM_##v] = #v
> >  #define SW_PARAM(v) [SND_PCM_SW_PARAM_##v] = #v
> > +#define RATE(v) [SND_PCM_RATE_##v] = #v
> >  #define FORMAT(v) [SND_PCM_FORMAT_##v] = #v
> >  #define SUBFORMAT(v) [SND_PCM_SUBFORMAT_##v] = #v 
> >  
> > @@ -1754,6 +1755,24 @@ static const char *const snd_pcm_access_names[] = {
> >  	ACCESS(RW_NONINTERLEAVED),
> >  };
> >  
> > +static const char *const snd_pcm_rate_names[] = {
> > +	RATE(5512),
> > +	RATE(8000),
> > +	RATE(11025),
> > +	RATE(16000),
> > +	RATE(22050),
> > +	RATE(32000),
> > +	RATE(44100),
> > +	RATE(48000),
> > +	RATE(64000),
> > +	RATE(88200),
> > +	RATE(96000),
> > +	RATE(176400),
> > +	RATE(192000),
> > +	RATE(CONTINUOUS),
> > +	RATE(KNOT),
> > +};
> > +
> >  static const char *const snd_pcm_format_names[] = {
> >  	FORMAT(S8),
> >  	FORMAT(U8),
> > @@ -1978,6 +1997,24 @@ const char *snd_pcm_format_description(snd_pcm_format_t format)
> >  }
> >  
> >  /**
> > + * \brief get PCM sample rate from name
> > + * \param name PCM sample rate name (case insensitive)
> > + * \return PCM sample rate
> > + */
> > +snd_pcm_rates_t snd_pcm_rate_value(const char* name)
> > +{
> > +	snd_pcm_rates_t rate;
> > +	for (rate = 0; rate <= SND_PCM_RATE_LAST; rate++) {
> > +		if (snd_pcm_rate_names[rate] &&
> > +		    strcasecmp(name, snd_pcm_rate_names[rate]) == 0) {
> > +			return rate;
> > +		}
> > +	}
> > +
> > +	return SND_PCM_RATE_UNKNOWN;
> > +}
> > +
> > +/**
> >   * \brief get PCM sample format from name
> >   * \param name PCM sample format name (case insensitive)
> >   * \return PCM sample format
> > -- 
> > 2.13.0
> > 
> > 
