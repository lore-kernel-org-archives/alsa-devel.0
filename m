From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Tue, 3 Aug 2010 20:39:20 +0300
Message-ID: <201008032039.20715.anssi.hannula@iki.fi>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008031809520.4068@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF31B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FCE310382B
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 19:39:25 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF31B@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Stephen Warren kirjoitti tiistai, 3. elokuuta 2010 19:20:24:
> Jaroslav Kysela wrote:
> > On Tue, 3 Aug 2010, Stephen Warren wrote:
> > > A user has the following setup:
> > > 
> > > A GPU which supports audio-over-HDMI. The codec supports sample rates
> > > 32000 44100 48000 88200 96000 176400 192000 (from
> > > /proc/asound/card1/codec#1). However, the user's TV supports only
> > > sample rates 44100 48000 88200 (from /proc/asound/card1/eld*).
> > > 
> > > When the user plays sound with sample rate 22050, they hear nothing.
> > > Sound with sample rates supported by the TV works OK.
> > > 
> > > My question: Is the HDA codec driver supposed to dynamically adjust its
> > > list of supported sample rates based on the ELD content, or is the ALSA
> > > library somehow supposed to detect the subset of rates supported in HW
> > > and convert the sample rate in SW before sending the audio to the
> > > driver?
> > 
> > The driver must return the correct list of supported sample rates.
> > Otherwise alsa-lib thinks that the invalid sample rate is supported in
> > the hardware or driver.
> 
> OK, that makes sense. Is this the responsibility of the codec driver (e.g.
> patch_nvhdmi.c) or something in the core HDMI code (e.g. patch_hdmi.c, or
> hda_*.c)
> 
> I don't see anything in patch_intelhdmi.c that relates to sample rate
> support at all. However, I see that patch_nvhdmi.c contains e.g.:
> 
> static struct hda_pcm_stream nvhdmi_pcm_digital_playback_8ch_89 = {
>         .substreams = 1,
>         .channels_min = 2,
>         .rates = SUPPORTED_RATES,
> 
> Should .rates not be initialized here,

When .rates is not initialized, they are automatically read from the codec, 
i.e. exactly the values you referenced above from 
"/proc/asound/card1/codec#1".

The values seem to differ (32000 vs 22050 is reported as supported), though. 
If the codec reported values are wrong, the .rates should be kept. Otherwise 
the rates set in .rates should be fixed or the override just removed.

> so that some automatic ELD-parsing
> logic gets triggered to fill this in later?

Unfortunately not, that has not been implemented yet. AFAICS it would belong 
to patch_hdmi.c.

-- 
Anssi Hannula
