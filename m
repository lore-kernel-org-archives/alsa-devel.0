From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ASoC] Missing shutdown() vectors in ASoC
Date: Mon, 18 Jun 2007 13:12:09 +0530
Message-ID: <8d6898730706180042v5f980486j73d783a04f9ddf5f@mail.gmail.com>
References: <8d6898730706120004u31ddc1edj9e38e575b6aa5e53@mail.gmail.com>
	<8d6898730706120514na050b79j813ba93db23dc768@mail.gmail.com>
	<1181655900.29999.28.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 8035E2417B
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 09:42:11 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1209702nzf
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2007 00:42:10 -0700 (PDT)
In-Reply-To: <1181655900.29999.28.camel@a10072.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam,

 Can you please look at this mail Thread.

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-June/001436.html



On 6/12/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> On Tue, 2007-06-12 at 17:44 +0530, Nobin Mathew wrote:
> > Liam
> >
> > I am trying to implement shutdown in ASoC
> >
> > /* dapm stream operations */
> > #define SND_SOC_DAPM_STREAM_NOP                       0x0
> > #define SND_SOC_DAPM_STREAM_START             0x1
> > #define SND_SOC_DAPM_STREAM_STOP              0x2
> > #define SND_SOC_DAPM_STREAM_SUSPEND           0x4
> > #define SND_SOC_DAPM_STREAM_RESUME            0x8
> > #define SND_SOC_DAPM_STREAM_PAUSE_PUSH        0x10
> > #define SND_SOC_DAPM_STREAM_PAUSE_RELEASE     0x20
> >
> >
> > Is there any need to add stream operation called
> > SND_SOC_DAPM_STREAM_SHUTDOWN even though this has no effect no the
> > system behaviour.
> >
> > Instead we can use SND_SOC_DAPM_STREAM_SUSPEND.
> > Is this OK.
> >
> > is there any better way to implement suspend?, i think suspend will be
> > a copy of remove() function.
> >
>
> I assume your looking to shutdown the codec to a low power state without
> removing the driver ?
>
> If so, SND_SOC_DAPM_STREAM_* operations all act upon stream and path
> based widgets (stream and path domain from soc-dapm.h). That is, they
> will always power up/down widgets that are actively used in the playback
> or capture of audio. This happens automatically at the end of
> playback/capture. The wont power down the codec domain.
>
> Atm, the codec power domain (VRef, Vmid) is only affected by signalling
> a dapm device event. This happens at probe/remove and suspend/resume atm
> for most codecs, although some codecs can alter their Vmid/Vref settings
> as part of stream/path domain power changes (as above, e.g. WM8753
> changes Vmid from 50k @ SNDRV_CTL_POWER_D0 to 500k SNDRV_CTL_POWER_D3)
>
> Fwiw, I've already added the shutdown function in the new ppc-dev
> branch. All component drivers will contain a struct device_driver and
> inherit it's features. More on this later today, for the moment the
> latest soc.h is here :-
>
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob_plain;f=include/sound/soc.h;hb=ppc-dev
>
> and pxa-i2s driver is here fyi :-
>
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob_plain;f=sound/soc/pxa/pxa2xx-i2s.c;hb=ppc-dev
>
>
> Liam
>
>
>
