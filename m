From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Missing 4-channel support on older NVIDIA MCP HW
Date: Wed, 1 Sep 2010 09:54:40 +0800
Message-ID: <AANLkTimCoX7KhJXh+8xbGfxQak8Xh1D47Eg91uaXcZk=@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FEF39906@HQMAIL01.nvidia.com>
	<s5h4oebyk72.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF02FF9E2A63@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A9EF2246E2
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 03:54:41 +0200 (CEST)
Received: by eyd9 with SMTP id 9so3978729eyd.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2010 18:54:40 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FF9E2A63@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/31 Stephen Warren <swarren@nvidia.com>

> Takashi Iwai wrote:
> >
>
> > > Unfortunately, it doesn't look like it's possible for applications to
> query
> > > this information from ALSA, since a hw_params_t exposes just a min/max
> > > channel count rather than a mask.
> >
> > It can be also masked.
>
> Are you saying the APIs already support a mask for channel count, and I
> just
> didn't find it, or that the APIUs should be updated to report a mask?
>
> Thanks.
>
> you can find the examples in intel8x0.c



static unsigned int channels2and8[] = {
    2,  8,
};

static struct snd_pcm_hw_constraint_list hw_constraints_channels2and8 = {
    .count = ARRAY_SIZE(channels2and8),
    .list = channels8,
    .mask = 0,
};

        runtime->hw.channels_max = 8;
        snd_pcm_hw_constraint_list(runtime, 0,
                        SNDRV_PCM_HW_PARAM_CHANNELS,
                        &hw_constraints_channels2and8);



The ALSA application need to snd_pcm_hw_params_test_channels() to find the
supported channel one by one
