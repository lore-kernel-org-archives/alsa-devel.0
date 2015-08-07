From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH 2/2] ASoC: max98090: Enforce correct device
 sequencing when configuring a new
Date: Fri, 7 Aug 2015 20:50:03 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718D699C1@ORSMSX113.amr.corp.intel.com>
References: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
 <1438902946-49633-2-git-send-email-yang.a.fang@intel.com>
 <20150807104311.GM20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E8E7B260713
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 22:50:06 +0200 (CEST)
In-Reply-To: <20150807104311.GM20873@sirena.org.uk>
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
To: 'Mark Brown' <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Anish.Kumar@maximintegrated.com" <Anish.Kumar@maximintegrated.com>, "Jain,
 Praveen K" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "Eoff,
 Ullysses A" <ullysses.a.eoff@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, August 07, 2015 3:43 AM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> dgreid@chromium.org; Nujella, Sathyanarayana;
> kevin.strasser@linux.intel.com; Sripathi, Srinivas; Iriawan, Denny; Jain,
> Praveen K; Anish.Kumar@maximintegrated.com; Eoff, Ullysses A
> Subject: Re: [PATCH 2/2] ASoC: max98090: Enforce correct device sequencing
> when configuring a new
> 
> On Thu, Aug 06, 2015 at 04:15:45PM -0700, yang.a.fang@intel.com wrote:
> 
> > +static int max98090_shdn_event(struct snd_soc_dapm_widget *w,
> > +				 struct snd_kcontrol *kcontrol, int event) {
> > +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> > +	struct max98090_priv *max98090 =
> snd_soc_codec_get_drvdata(codec);
> > +
> > +	if (event & SND_SOC_DAPM_POST_PMU)
> > +		max98090->shdn_pending = TRUE;
> 
> TRUE?  Please use normal C99 booleans like we normally do in the kernel.
I will fix this
> 
> > +static void max98090_seq_notifier(struct snd_soc_dapm_context *dapm,
> > +	enum snd_soc_dapm_type event, int subseq, bool power_up) {
> > +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
> > +	struct max98090_priv *max98090 =
> snd_soc_codec_get_drvdata(codec);
> > +
> > +	if (max98090->shdn_pending && power_up) {
> > +		snd_soc_update_bits(codec,
> M98090_REG_DEVICE_SHUTDOWN,
> > +				M98090_SHDNN_MASK, 0);
> > +		msleep(40);
> > +		snd_soc_update_bits(codec,
> M98090_REG_DEVICE_SHUTDOWN,
> > +				M98090_SHDNN_MASK,
> M98090_SHDNN_MASK);
> > +		max98090->shdn_pending = FALSE;
> > +	}
> > +}
> 
> Why did you change the API for this?  As far as I can tell power_up is
> redundant here, we already know we're powering things up because we got
> a _PMU event, the main effect here appears to be to just run this at the next
> sequence point after we've powered up a widget with a shutdown event.
> The general concept with the seq_notifier is that we record things we need
> to do in the per-widget events and then implement them in the seq_notifier
> and I'm not seeing anything else going on here.
Thanks Mark.   Right , _PMU already indicates it is power_up event.. I will drop
This API change.
