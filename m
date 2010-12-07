From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: hda - Do not wrongly restrict
 min_channels based on ELD
Date: Tue, 7 Dec 2010 09:52:17 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030E0701B8@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF030E070176@HQMAIL01.nvidia.com>
	<4CFE6A47.5050404@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF030E07019B@HQMAIL01.nvidia.com>
	<4CFE6F4F.9000007@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 52AB0103839
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 18:52:37 +0100 (CET)
In-Reply-To: <4CFE6F4F.9000007@iki.fi>
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
> On 07.12.2010 19:26, Stephen Warren wrote:
> > Anssi Hannula wrote:
> >>
> >> On 07.12.2010 18:58, Stephen Warren wrote:
> >>> Anssi Hannula wrote:
> >>>> Commit bbbe33900d1f3c added functionality to restrict PCM parameters
> >>>> based on ELD info (derived from EDID data) of the audio sink.
> >>>>
> >>>> However, it wrongly assumes that the bits 0-2 of the first byte of
> >>>> CEA Short Audio Descriptors mean a supported number of channels. In
> >>>> reality, they mean the maximum number of channels (as per CEA-861-D
> >>>> 7.5.2). This means that the channel count can only be used to restrict
> >>>> max_channels, not min_channels.
> >>>>
> >>>> Restricting min_channels causes us to deny opening the device in stereo
> >>>> mode if the sink only has SADs that declare larger numbers of channels
> >>>> (like Primare SP32 AV Processor does).
> >>>>
> >>>> Fix that by not restricting min_channels based on ELD information.
> [...]
> >>>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> >>>> Reported-by: Jean-Yves Avenard <jyavenard@gmail.com>
> >>>> Tested-by: Jean-Yves Avenard <jyavenard@gmail.com>
> >>>> Cc: stable@kernel.org
> [...]
> >>>>  	pcm->channels_max = min(pcm->channels_max, codec_pars->channels_max);
> >>>>  	pcm->maxbps = min(pcm->maxbps, codec_pars->maxbps);
> >>>>  }
> >>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> >>>> index d3e49aa..31df774 100644
> >>>> --- a/sound/pci/hda/patch_hdmi.c
> >>>> +++ b/sound/pci/hda/patch_hdmi.c
> >>>> @@ -834,7 +834,6 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
> >>>>  			return -ENODEV;
> >>>>  	} else {
> >>>>  		/* fallback to the codec default */
> >>>> -		hinfo->channels_min = codec_pars->channels_min;
> >>>
> >>> Isn't this still required to default the value?
> >>
> >> Not AFAICS. By default *hinfo has the codec provided parameters, and if
> >> we never update it from the ELD info, we don't need to restore it either.
> >
> > OK. Doesn't the same argument apply to the following 3 lines too then?
> 
> Nope. hinfo is persistent across open() calls, so we need to reset them
> if they were ever updated from ELD earlier.
> 
> >>>>  		hinfo->channels_max = codec_pars->channels_max;
> >>>>  		hinfo->rates = codec_pars->rates;
> >>>>  		hinfo->formats = codec_pars->formats;

OK. It seems a little risky to assume that hdmi_eld_update_pcm_info will
never touch channels_min, but it's certainly true after this patch, so the
patch will function correctly.

Sorry for the confusion/noise.

-- 
nvpublic
