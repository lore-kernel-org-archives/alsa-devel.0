From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: hda - Do not wrongly restrict
 min_channels based on ELD
Date: Tue, 7 Dec 2010 09:26:16 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030E07019B@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF030E070176@HQMAIL01.nvidia.com>
	<4CFE6A47.5050404@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A3DE72438C
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 18:26:43 +0100 (CET)
In-Reply-To: <4CFE6A47.5050404@iki.fi>
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
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@kernel.org" <stable@kernel.org>, Jean-Yves Avenard <jyavenard@gmail.com>
List-Id: alsa-devel@alsa-project.org

Anssi Hannula wrote:
> 
> On 07.12.2010 18:58, Stephen Warren wrote:
> > Anssi Hannula wrote:
> >> Commit bbbe33900d1f3c added functionality to restrict PCM parameters
> >> based on ELD info (derived from EDID data) of the audio sink.
> >>
> >> However, it wrongly assumes that the bits 0-2 of the first byte of
> >> CEA Short Audio Descriptors mean a supported number of channels. In
> >> reality, they mean the maximum number of channels (as per CEA-861-D
> >> 7.5.2). This means that the channel count can only be used to restrict
> >> max_channels, not min_channels.
> >>
> >> Restricting min_channels causes us to deny opening the device in stereo
> >> mode if the sink only has SADs that declare larger numbers of channels
> >> (like Primare SP32 AV Processor does).
> >>
> >> Fix that by not restricting min_channels based on ELD information.
> >
> > Yes, re-reading the CEA-861-D spec, that makes sense. Comments inline
> > though.
> >
> > BTW, I noticed that no SADs are required if only basic audio is
> > supported. Is that case handled by the ELD parser? I.e. instead of:
> >
> >     pcm->channels_max = 0;
> >
> > Should it be:
> >
> >     pcm->channels_max = 0;
> >     if supports basic audio:
> >         pcm->channels_max = 2;
> >
> > or something like that?
> 
> Yes, same for rates. I'll followup on that with a separate patch, thanks :)

Sounds good to me.

> >> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> >> Reported-by: Jean-Yves Avenard <jyavenard@gmail.com>
> >> Tested-by: Jean-Yves Avenard <jyavenard@gmail.com>
> >> Cc: stable@kernel.org
> >> ---
> >>
> >> I think this should go to 2.6.36 stable tree as well. It does not affect
> >> earlier stable releases.
> >>
> >>  sound/pci/hda/hda_eld.c    |    4 ----
> >>  sound/pci/hda/patch_hdmi.c |    1 -
> >>  2 files changed, 0 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
> >> index cb0c23a..47ef8aa 100644
> >> --- a/sound/pci/hda/hda_eld.c
> >> +++ b/sound/pci/hda/hda_eld.c
> >> @@ -601,13 +601,10 @@ void hdmi_eld_update_pcm_info(struct hdmi_eld *eld, struct
> >> hda_pcm_stream *pcm,
> >>  	pcm->rates = 0;
> >>  	pcm->formats = 0;
> >>  	pcm->maxbps = 0;
> >> -	pcm->channels_min = -1;
> >>  	pcm->channels_max = 0;
> >>  	for (i = 0; i < eld->sad_count; i++) {
> >>  		struct cea_sad *a = &eld->sad[i];
> >>  		pcm->rates |= a->rates;
> >> -		if (a->channels < pcm->channels_min)
> >> -			pcm->channels_min = a->channels;
> >>  		if (a->channels > pcm->channels_max)
> >>  			pcm->channels_max = a->channels;
> >>  		if (a->format == AUDIO_CODING_TYPE_LPCM) {
> >
> > That all looks OK.
> >
> >> @@ -635,7 +632,6 @@ void hdmi_eld_update_pcm_info(struct hdmi_eld *eld, struct
> >> hda_pcm_stream *pcm,
> >>  	/* restrict the parameters by the values the codec provides */
> >>  	pcm->rates &= codec_pars->rates;
> >>  	pcm->formats &= codec_pars->formats;
> >> -	pcm->channels_min = max(pcm->channels_min, codec_pars->channels_min);
> >
> > Shouldn't that be:
> >
> >       pcm->channels_min = pcm->channels_min;
> >
> > Or, is that assignment already made earlier as a default?
> 
> pcm->channels_min = pcm->channels_min;
> does not make sense, I assume you meant
> pcm->channels_min = codec_pars->channels_min;

Oops.

> *codec_pars is originally copied from *pcm in hdmi_pcm_open() of
> patch_hdmi.c, so yes, the assignment would be superfluous.

OK.

> >>  	pcm->channels_max = min(pcm->channels_max, codec_pars->channels_max);
> >>  	pcm->maxbps = min(pcm->maxbps, codec_pars->maxbps);
> >>  }
> >> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> >> index d3e49aa..31df774 100644
> >> --- a/sound/pci/hda/patch_hdmi.c
> >> +++ b/sound/pci/hda/patch_hdmi.c
> >> @@ -834,7 +834,6 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> >>  			return -ENODEV;
> >>  	} else {
> >>  		/* fallback to the codec default */
> >> -		hinfo->channels_min = codec_pars->channels_min;
> >
> > Isn't this still required to default the value?
> 
> Not AFAICS. By default *hinfo has the codec provided parameters, and if
> we never update it from the ELD info, we don't need to restore it either.

OK. Doesn't the same argument apply to the following 3 lines too then?

> >>  		hinfo->channels_max = codec_pars->channels_max;
> >>  		hinfo->rates = codec_pars->rates;
> >>  		hinfo->formats = codec_pars->formats;
> >> --
> >> 1.7.3

-- 
nvpublic
