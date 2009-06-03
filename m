From: Alan Alan <alanwww1@gmail.com>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Thu, 4 Jun 2009 01:28:24 +0200
Message-ID: <410e92830906031628t64c4cbf3y104062f2147ea44d@mail.gmail.com>
References: <410e92830906021458x3d47a1d6jebba8bbe1150e76d@mail.gmail.com>
	<200906030022.07693.marek.vasut@gmail.com>
	<410e92830906021530l767478c4tae72c4b161583b6@mail.gmail.com>
	<200906030200.54455.marek.vasut@gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B058A63F1@hkemmail01.nvidia.com>
	<410e92830906030100m5a3d045dsa856382fa2396e60@mail.gmail.com>
	<s5heiu1ybsk.wl%tiwai@suse.de>
	<410e92830906030234u49a1e618kdf2d1e0550f00cdc@mail.gmail.com>
	<s5hab4psl2s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 306B91038E5
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 01:28:25 +0200 (CEST)
Received: by bwz11 with SMTP id 11so373954bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 16:28:24 -0700 (PDT)
In-Reply-To: <s5hab4psl2s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peer Chen <pchen@nvidia.com>, Marek Vasut <marek.vasut@gmail.com>, Wei Ni <wni@nvidia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi !

I tried to apply the patch that removes restrictions to 16bits 48khz format.
Well now we have the following:
16bit 48khz                                     works
32bit 48khz                                     works
32bit 44khz, 96khz, 192khz              don't work
24bit 44khz, 48khz, 96khz, 192khz   don't work
16bit 44khz, 96khz, 192khz              don't work

I only get
Sample format not available for playback:
Setting of hwparams failed:

I enclosed to pastebin my alsainfo script output.

http://pastebin.com/m77dcfb3f

Thanks for the help !

2009/6/3 Takashi Iwai <tiwai@suse.de>

> At Wed, 3 Jun 2009 11:34:00 +0200,
> Alan Alan wrote:
> >
> > Hello Takashi !
> >
> > What should this patch do ?
>
> The patch removes the restriction patch_nvhdmi.c sets.  Instead,
> the driver tries to detect the supported format, rate, etc from the
> codec widget information.
>
> > Is it a cure for the 96, 192khz or 24bit sample playback problem ?
>
> Possibly.
>
> > If so, will it resample or natievly pass the stream to the amplifier ?
>
> It just enables the native support, possibly.
>
> And, don't forget to give back the alsa-info.sh output (run with
> --no-upload option).
>
>
> Takashi
>
> >
> > Thank you
> >
> > Alan
> >
> > 2009/6/3 Takashi Iwai <tiwai@suse.de>
> >
> >     At Wed, 3 Jun 2009 10:00:24 +0200,
> >     Alan Alan wrote:
> >     >
> >     > Hello Wei !
> >     >
> >     > Thanks for replying.
> >     > I tested it with speaker-test and xbmc babylon. Both had problems
> with
> >     > channel mapping.
> >     > I used this command:
> >     >
> >     > speaker-test -Dhdmi -c6
> >     > or
> >     > speaker-test -Dhdmi -c8
> >     >
> >     > alternatively you could try
> >     >
> >     > speaker-test -Dhw:0,3 -c6
> >     >
> >     >
> >     > I had to rund Xorg first and have the command from an xterm,
> becasue
> >     from a
> >     > normal terminal it would not work.
> >     > I think that is normal as a limitation of hdmi.
> >     >
> >     > What about the support for 24bits 192khz sound ?
> >     >
> >     > speaker-test -Dhdmi -c6  -r192000 does not work.
> >
> >     How about the patch below?
> >
> >     Also, could you give alsa-info.sh output?
> >
> >     Takashi
> >
> >     ---
> >     diff --git a/sound/pci/hda/patch_nvhdmi.c
> b/sound/pci/hda/patch_nvhdmi.c
> >     index f5792e2..48443de 100644
> >     --- a/sound/pci/hda/patch_nvhdmi.c
> >     +++ b/sound/pci/hda/patch_nvhdmi.c
> >     @@ -258,9 +258,11 @@ static struct hda_pcm_stream
> >     nvhdmi_pcm_digital_playback_8ch = {
> >            .channels_min = 2,
> >            .channels_max = 8,
> >            .nid = Nv_Master_Convert_nid,
> >     +#if 0
> >            .rates = SNDRV_PCM_RATE_48000,
> >            .maxbps = 16,
> >            .formats = SNDRV_PCM_FMTBIT_S16_LE,
> >     +#endif
> >            .ops = {
> >                    .open = nvhdmi_dig_playback_pcm_open,
> >                    .close = nvhdmi_dig_playback_pcm_close_8ch,
> >     @@ -273,9 +275,11 @@ static struct hda_pcm_stream
> >     nvhdmi_pcm_digital_playback_2ch = {
> >            .channels_min = 2,
> >            .channels_max = 2,
> >            .nid = Nv_Master_Convert_nid,
> >     +#if 0
> >            .rates = SNDRV_PCM_RATE_48000,
> >            .maxbps = 16,
> >            .formats = SNDRV_PCM_FMTBIT_S16_LE,
> >     +#endif
> >            .ops = {
> >                    .open = nvhdmi_dig_playback_pcm_open,
> >                    .close = nvhdmi_dig_playback_pcm_close_2ch,
> >
> >
>
