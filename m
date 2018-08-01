From: "Zhi, Yong" <yong.zhi@intel.com>
Subject: Re: [PATCH] ASoC: Intel: bxt: Use refcap device for
 mono recording
Date: Wed, 1 Aug 2018 23:18:34 +0000
Message-ID: <C193D76D23A22742993887E6D207B54D341F9E15@ORSMSX106.amr.corp.intel.com>
References: <1533143039-5428-1-git-send-email-yong.zhi@intel.com>
 <2675f41e-ffd8-b583-ef79-509392ff9b0c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1302676E2
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 01:18:38 +0200 (CEST)
In-Reply-To: <2675f41e-ffd8-b583-ef79-509392ff9b0c@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "N,
 Harshapriya" <harshapriya.n@intel.com>, "M, Naveen" <naveen.m@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vkoul@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi, Bossart,

Thanks for the quick review.

> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Wednesday, August 1, 2018 3:52 PM
> To: Zhi, Yong <yong.zhi@intel.com>; broonie@kernel.org
> Cc: alsa-devel@alsa-project.org; N, Harshapriya <harshapriya.n@intel.com>;
> M, Naveen <naveen.m@intel.com>; Tc, Jenny <jenny.tc@intel.com>; Vinod
> Koul <vkoul@kernel.org>
> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bxt: Use refcap device for
> mono recording
> 
> On 8/1/18 10:03 AM, Yong Zhi wrote:
> > The refcap capture device supports mono recording only, this patch
> > adds the channel constraints, also change stream_name to "Wake on
> Voice".
> 
> the part on the channel constraints is legit, but I wonder if the renaming to
> "Wake-on-voice" is required or meaningful. IIRC the reference signal is just a
> downmixed/downsampled version whatever is being played to be used for
> echo cancellation, I don't see a link with Wake-on-voice?
> 

The cras audio server defined HOTWORD_DEV as "Wake on Voice", but we can also use UCM file to tell the server that the Refcap is the HOTWORD_DEV, so the renaming is not straightly required, I can remove it in v2.

https://chromium.googlesource.com/chromiumos/third_party/adhd/+/master/cras/src/server/cras_alsa_io.c

> >
> > Signed-off-by: Yong Zhi <yong.zhi@intel.com>
> > ---
> >   sound/soc/intel/boards/bxt_da7219_max98357a.c | 16
> +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > index be6e4b4..097a089 100644
> > --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> > @@ -319,6 +319,15 @@ static const unsigned int rates_16000[] = {
> >   	16000,
> >   };
> >
> > +static const unsigned int ch_mono[] = {
> > +	1,
> > +};
> > +
> > +static const struct snd_pcm_hw_constraint_list constraints_refcap = {
> > +	.count = ARRAY_SIZE(ch_mono),
> > +	.list  = ch_mono,
> > +};
> > +
> >   static const struct snd_pcm_hw_constraint_list constraints_16000 = {
> >   	.count = ARRAY_SIZE(rates_16000),
> >   	.list  = rates_16000,
> > @@ -326,6 +335,11 @@ static const struct snd_pcm_hw_constraint_list
> > constraints_16000 = {
> >
> >   static int broxton_refcap_startup(struct snd_pcm_substream
> *substream)
> >   {
> > +	substream->runtime->hw.channels_max = 1;
> > +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> > +				   SNDRV_PCM_HW_PARAM_CHANNELS,
> > +				   &constraints_refcap);
> > +
> >   	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> >   			SNDRV_PCM_HW_PARAM_RATE,
> >   			&constraints_16000);
> > @@ -372,7 +386,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
> >   	[BXT_DPCM_AUDIO_REF_CP] =
> >   	{
> >   		.name = "Bxt Audio Reference cap",
> > -		.stream_name = "Refcap",
> > +		.stream_name = "Wake on Voice",
> >   		.cpu_dai_name = "Reference Pin",
> >   		.codec_name = "snd-soc-dummy",
> >   		.codec_dai_name = "snd-soc-dummy-dai",
> >
