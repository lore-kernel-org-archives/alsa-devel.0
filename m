From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Missing 4-channel support on older NVIDIA MCP HW
Date: Wed, 1 Sep 2010 12:03:09 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FF9E2B78@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FEF39906@HQMAIL01.nvidia.com>
	<s5h4oebyk72.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF02FF9E2A63@HQMAIL01.nvidia.com>
	<s5hzkw1h29k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 50F3724454
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 21:03:18 +0200 (CEST)
In-Reply-To: <s5hzkw1h29k.wl%tiwai@suse.de>
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
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Tue, 31 Aug 2010 08:41:53 -0700,
> Stephen Warren wrote:
> >
> > Takashi Iwai wrote:
> > >
> > > At Mon, 30 Aug 2010 10:11:09 -0700,
> > > Stephen Warren wrote:
> > > >
> > > > It looks like even though some NVIDIA MCPs have min/max channel of 2/8, not
> > > > all HW supports the intermediate # channels (4 and 6) over HDMI. Various
> > > > combinations are supported on various HW: 2, 2/8, 2/6/8, 2/4/6/8.
> > > >
> > > > At present, when an application uses an unsupported number of channels,
> > > > playback appears to operate correctly, but the HW doesn't actually send the
> > > > audio data over HDMI.
> > > >
> > > > Is it possible for patch_nvhdmi.c to simply program codec the HW in 8-channel
> > > > mode even though the controller is only sending 4-/6-channel data?
> > >
> > > I'm not sure whether HD-audio codec can have a /dev/zero-kind of stream.
> > > It's possible to set up but I don't think it's worth.
> > > It'd be far easier to omit 4 and 6-channels for such a case.
> > >
> > > > I'm not
> > > > sure if this would cause the codec to get out of sync with the controller's
> > > > data stream. Would the controller end up grabbing 8 channels worth of data
> > > > from the stream at a time, have no way to synchronize to the start of each
> > > > sample, and hence end up packing e.g. 2 complete 4 channel samples into a
> > > > single 8 channel sample?
> > > >
> > > > If not, it seems that patch_nvhdmi.c should be modified so that each codec's
> > > > _open() function returns an error for unsupported rates. I can code that up
> > > > if we need.
> > >
> > > Do you mean for unsupported channels?
n >
> > Oops, yes.
> >
> > Do you think that's the correct fix?
> >
> > If the driver errors out the open, will a plug: (or other non hw:) ALSA device
> > dynamically "upsample" a 4-channel stream to the next supported (8-channel), or
> > will the user application have to handle this?
> 
> alsa-lib can do make working (e.g. via upmix plugin).  But other audio
> backend can do it by itself.
> IMO, telling the truth is a better approach.  It is 4-channel, after
> all.

Sorry to be dense, but when you say "audio backend", I'm not sure what you're
referring to; the ALSA driver, the HW itself, or something else.

Are you saying that I should modify patch_nvhdmi.c to somehow reformat the
data before sending it to the device?

Or, are you saying it'd be best if the HW handled it. That's true, but
unfortunately, there's no way to fix that now!

Finally, you mentioned the alsa-lib's upmix plugin. Will that automatically be
used for a 4-channel stream when the HW only supports 8-channel, or will the
application (or a config file) have to specifically activate this?

> > > > Unfortunately, it doesn't look like it's possible for applications to query
> > > > this information from ALSA, since a hw_params_t exposes just a min/max
> > > > channel count rather than a mask.
> > >
> > > It can be also masked.
> >
> > Are you saying the APIs already support a mask for channel count, and I just
> > didn't find it, or that the APIUs should be updated to report a mask?
> 
> You can pass the list as hw_constraint.  Look for drivers using
> struct snd_pcm_hw_constraint_list.

Thanks, the intel8x0.c code looks pretty similar to what's required.

-- 
nvpublic
