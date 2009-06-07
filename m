From: Alan Alan <alanwww1@gmail.com>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Sun, 7 Jun 2009 23:43:04 +0200
Message-ID: <410e92830906071443p4bfbc173ud97b9288ce119f09@mail.gmail.com>
References: <410e92830906021458x3d47a1d6jebba8bbe1150e76d@mail.gmail.com>
	<s5heiu1ybsk.wl%tiwai@suse.de>
	<410e92830906030234u49a1e618kdf2d1e0550f00cdc@mail.gmail.com>
	<s5hab4psl2s.wl%tiwai@suse.de>
	<410e92830906031628t64c4cbf3y104062f2147ea44d@mail.gmail.com>
	<s5h63fcx4zr.wl%tiwai@suse.de>
	<410e92830906032318v4ed6987cr41c8f73a8a54a9e6@mail.gmail.com>
	<s5hy6s84iej.wl%tiwai@suse.de>
	<410e92830906041620n1e911c3fjb4eafe6112996c4f@mail.gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B058A63F7@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BFAC2469C
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Jun 2009 23:43:05 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2688253bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 07 Jun 2009 14:43:04 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B058A63F7@hkemmail01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wei Ni <wni@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, Peer Chen <pchen@nvidia.com>, alsa-devel@alsa-project.org, Marek Vasut <marek.vasut@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Wei !

I made the tests changig the values in the sound/pci/hda/patch_nvhdmi.c file
manually.
To summarize the results i have perfect sound up to 192khz/32bits(S32_LE
format). But only one configuration at a time.

How can we set multiple formats here, or let the system pass all formats to
the av receiver ?

Here are the detailed results i tested.

In the source code
        .rates = SNDRV_PCM_RATE_A
        .maxbps = B,
        .formats = SNDRV_PCM_FMTBIT_SC_LE,

case.

1. A=192000, B=24, C=16,      perfect sound, with speaker-test -Dhdmi -c6
-r192000 -FS16_LE, no other setting working
2. A= 192000, B=24, C=32,     perfect sound, with speaker-test -Dhdmi -c6
-r192000 -FS32_LE, no other setting working
3. A= 96000, B=24, C=32,       perfect sound, with speaker-test -Dhdmi -c6
-r96000 -FS32_LE, no other setting working
4. A=192000, B=24, C=24,      strange high pitched sound from all speakers,
with speaker-test -Dhdmi -c6 -r192000 -FS24_LE, no other settings working
5. A=  96000, B=24, C=24,      strange high pitched sound from all speakers,
with speaker-test -Dhdmi -c6 -r96000 -FS24_LE, no other settings working

If you want i will test more. But i think it can be seen that S24 formats
are not working, but all S16, S32 formats working up to 192khz.

Regards

Alan


2009/6/5 Wei Ni <wni@nvidia.com>

>  Some HDTVs generally only support 32kHz-48kHz, and most (newer) receivers
> could be able to support 192kHz.
>
> In windows, the display driver will indicates which formats are supported
> in the CEA registers.
>
> But the linux display driver will not do it.
>
>
>
> Could you please add
>
>                 .rates = SNDRV_PCM_RATE_192000,
>
>                 .maxbps = 24,
>
> And then try to play 192khz/24bit
>
>
>
> I also will try it.
>
>
>
> Thanks
>
> Wei.
>
>
>
> *From:* Alan Alan [mailto:alanwww1@gmail.com]
> *Sent:* Friday, June 05, 2009 7:21 AM
> *To:* Takashi Iwai
> *Cc:* Wei Ni; Peer Chen; Marek Vasut; alsa-devel@alsa-project.org
> *Subject:* Re: [alsa-devel] ALSA patch Nvidia 8 channel hdmi audio
>
>
>
> I made a test on Windows. And it seems that my codec MCP7A does support up
> to 8channels 192khz, 24bits no problem.
>
> One important thing i noticed:
>  If i plug the hdmi to the lcd TV, the windows control panel only shows up
> to 2ch, 48khz. When i plug it into the Onkyo-TXSR605 av receiver and reboot,
> only than it shows up the HD options.
>
> I enclosed a screenshout about it. When i press test button, the audio
> sounds in the receiver even with 192/24
>
> Strange thing here that on win, it does not even show the 88.2khz number.
> And sample rates depend on what device is plugged, but on alsa i always get
> the same output (48, 88.2khz) whatever device i plug on.
>
>
>  2009/6/4 Takashi Iwai <tiwai@suse.de>
>
> At Thu, 4 Jun 2009 08:18:23 +0200,
>
> Alan Alan wrote:
> >
> > 2009/6/4 Takashi Iwai <tiwai@suse.de>
> >
> >     At Thu, 4 Jun 2009 01:28:24 +0200,
> >     Alan Alan wrote:
> >     >
> >     > Hello Takashi !
> >     >
> >     > I tried to apply the patch that removes restrictions to 16bits
> 48khz
> >     format.
> >     > Well now we have the following:
> >     > 16bit 48khz                                     works
> >     > 32bit 48khz                                     works
> >     > 32bit 44khz, 96khz, 192khz              don't work
> >     > 24bit 44khz, 48khz, 96khz, 192khz   don't work
> >     > 16bit 44khz, 96khz, 192khz              don't work
> >     >
> >     > I only get
> >     > Sample format not available for playback:
> >     > Setting of hwparams failed:
> >
> >     As you can find in alsa-info output, it seems that the codec supports
> >     only 48kHz and 88.2kHz, strangely.  I don't know whether it's a
> >     (hardware) bug or not.
> >
> > The codec surely supports up to 192khz as it works on Windows.
> >
> > I think this line is completely wrong as here it says:
>
> It is not "wrong".  These are values that the codec reports, so it's
> more or less correct as the h/w information.
>
> >   rates [0xc0]: 48000 88200
>
> Wei, is it right?  Or is anything missing here?
>
>
>
> >     bits [0xf]: 8 16 20 24
> >
> > 8, 20, 24bits are supported, but they all give an error message.
>
> 24bit here means 24bit in 4 bytes, thus it's essentially 32bit format.
> 24bit in 3 bytes format isn't supported on HD-audio.
>
>
> > 32 bits are not supposed to be supported but it works with 48 and
> 88.2khz.
> >
> > How can we change the software side to accept 96 or 192khz spample
> formats and
> > 24 bits ?
>
> As long as the codec reports so, it's no "software" problem.
>
>
> > I think it is not hardware limited and we just need to change the allowed
> > formats to be played.
>
> If it's just a hardware problem that reports wrong values, you can
> override the information, simply replacing the bits my patch disabled
> to the right values.
>
>
>
> Takashi
>
> >
> >     >
> >     > I enclosed to pastebin my alsainfo script output.
> >     >
> >     > http://pastebin.com/m77dcfb3f
> >     >
> >     > Thanks for the help !
> >     >
> >     > 2009/6/3 Takashi Iwai <tiwai@suse.de>
> >     >
> >     >     At Wed, 3 Jun 2009 11:34:00 +0200,
> >     >     Alan Alan wrote:
> >     >     >
> >     >     > Hello Takashi !
> >     >     >
> >     >     > What should this patch do ?
> >     >
> >     >     The patch removes the restriction patch_nvhdmi.c sets.
>  Instead,
> >     >     the driver tries to detect the supported format, rate, etc from
> the
> >     >     codec widget information.
> >     >
> >     >     > Is it a cure for the 96, 192khz or 24bit sample playback
> problem ?
> >     >
> >     >     Possibly.
> >     >
> >     >     > If so, will it resample or natievly pass the stream to the
> >     amplifier ?
> >     >
> >     >     It just enables the native support, possibly.
> >     >
> >     >     And, don't forget to give back the alsa-info.sh output (run
> with
> >     >     --no-upload option).
> >     >
> >     >     Takashi
> >     >
> >     >     >
> >     >     > Thank you
> >     >     >
> >     >     > Alan
> >     >     >
> >     >     > 2009/6/3 Takashi Iwai <tiwai@suse.de>
> >     >     >
> >     >     >     At Wed, 3 Jun 2009 10:00:24 +0200,
> >     >     >     Alan Alan wrote:
> >     >     >     >
> >     >     >     > Hello Wei !
> >     >     >     >
> >     >     >     > Thanks for replying.
> >     >     >     > I tested it with speaker-test and xbmc babylon. Both
> had
> >     problems
> >     >     with
> >     >     >     > channel mapping.
> >     >     >     > I used this command:
> >     >     >     >
> >     >     >     > speaker-test -Dhdmi -c6
> >     >     >     > or
> >     >     >     > speaker-test -Dhdmi -c8
> >     >     >     >
> >     >     >     > alternatively you could try
> >     >     >     >
> >     >     >     > speaker-test -Dhw:0,3 -c6
> >     >     >     >
> >     >     >     >
> >     >     >     > I had to rund Xorg first and have the command from an
> xterm,
> >     >     becasue
> >     >     >     from a
> >     >     >     > normal terminal it would not work.
> >     >     >     > I think that is normal as a limitation of hdmi.
> >     >     >     >
> >     >     >     > What about the support for 24bits 192khz sound ?
> >     >     >     >
> >     >     >     > speaker-test -Dhdmi -c6  -r192000 does not work.
> >     >     >
> >     >     >     How about the patch below?
> >     >     >
> >     >     >     Also, could you give alsa-info.sh output?
> >     >     >
> >     >     >     Takashi
> >     >     >
> >     >     >     ---
> >     >     >     diff --git a/sound/pci/hda/patch_nvhdmi.c
> b/sound/pci/hda/
> >     >     patch_nvhdmi.c
> >     >     >     index f5792e2..48443de 100644
> >     >     >     --- a/sound/pci/hda/patch_nvhdmi.c
> >     >     >     +++ b/sound/pci/hda/patch_nvhdmi.c
> >     >     >     @@ -258,9 +258,11 @@ static struct hda_pcm_stream
> >     >     >     nvhdmi_pcm_digital_playback_8ch = {
> >     >     >            .channels_min = 2,
> >     >     >            .channels_max = 8,
> >     >     >            .nid = Nv_Master_Convert_nid,
> >     >     >     +#if 0
> >     >     >            .rates = SNDRV_PCM_RATE_48000,
> >     >     >            .maxbps = 16,
> >     >     >            .formats = SNDRV_PCM_FMTBIT_S16_LE,
> >     >     >     +#endif
> >     >     >            .ops = {
> >     >     >                    .open = nvhdmi_dig_playback_pcm_open,
> >     >     >                    .close =
> nvhdmi_dig_playback_pcm_close_8ch,
> >     >     >     @@ -273,9 +275,11 @@ static struct hda_pcm_stream
> >     >     >     nvhdmi_pcm_digital_playback_2ch = {
> >     >     >            .channels_min = 2,
> >     >     >            .channels_max = 2,
> >     >     >            .nid = Nv_Master_Convert_nid,
> >     >     >     +#if 0
> >     >     >            .rates = SNDRV_PCM_RATE_48000,
> >     >     >            .maxbps = 16,
> >     >     >            .formats = SNDRV_PCM_FMTBIT_S16_LE,
> >     >     >     +#endif
> >     >     >            .ops = {
> >     >     >                    .open = nvhdmi_dig_playback_pcm_open,
> >     >     >                    .close =
> nvhdmi_dig_playback_pcm_close_2ch,
> >     >     >
> >     >     >
> >     >
> >     >
> >
> >
>
>
>  ------------------------------
>  This email message is for the sole use of the intended recipient(s) and
> may contain confidential information.  Any unauthorized review, use,
> disclosure or distribution is prohibited.  If you are not the intended
> recipient, please contact the sender by reply email and destroy all copies
> of the original message.
>  ------------------------------
>
>
