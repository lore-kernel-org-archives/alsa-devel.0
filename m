From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] Missing shutdown() vectors in ASoC
Date: Tue, 12 Jun 2007 14:45:00 +0100
Message-ID: <1181655900.29999.28.camel@a10072.wolfsonmicro.main>
References: <8d6898730706120004u31ddc1edj9e38e575b6aa5e53@mail.gmail.com>
	<8d6898730706120514na050b79j813ba93db23dc768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 00A7F103847
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 15:45:03 +0200 (CEST)
In-Reply-To: <8d6898730706120514na050b79j813ba93db23dc768@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-06-12 at 17:44 +0530, Nobin Mathew wrote:
> Liam
> 
> I am trying to implement shutdown in ASoC
> 
> /* dapm stream operations */
> #define SND_SOC_DAPM_STREAM_NOP			0x0
> #define SND_SOC_DAPM_STREAM_START		0x1
> #define SND_SOC_DAPM_STREAM_STOP		0x2
> #define SND_SOC_DAPM_STREAM_SUSPEND		0x4
> #define SND_SOC_DAPM_STREAM_RESUME		0x8
> #define SND_SOC_DAPM_STREAM_PAUSE_PUSH	0x10
> #define SND_SOC_DAPM_STREAM_PAUSE_RELEASE	0x20
> 
> 
> Is there any need to add stream operation called
> SND_SOC_DAPM_STREAM_SHUTDOWN even though this has no effect no the
> system behaviour.
> 
> Instead we can use SND_SOC_DAPM_STREAM_SUSPEND.
> Is this OK.
> 
> is there any better way to implement suspend?, i think suspend will be
> a copy of remove() function.
> 

I assume your looking to shutdown the codec to a low power state without
removing the driver ?

If so, SND_SOC_DAPM_STREAM_* operations all act upon stream and path
based widgets (stream and path domain from soc-dapm.h). That is, they
will always power up/down widgets that are actively used in the playback
or capture of audio. This happens automatically at the end of
playback/capture. The wont power down the codec domain.

Atm, the codec power domain (VRef, Vmid) is only affected by signalling
a dapm device event. This happens at probe/remove and suspend/resume atm
for most codecs, although some codecs can alter their Vmid/Vref settings
as part of stream/path domain power changes (as above, e.g. WM8753
changes Vmid from 50k @ SNDRV_CTL_POWER_D0 to 500k SNDRV_CTL_POWER_D3)

Fwiw, I've already added the shutdown function in the new ppc-dev
branch. All component drivers will contain a struct device_driver and
inherit it's features. More on this later today, for the moment the
latest soc.h is here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob_plain;f=include/sound/soc.h;hb=ppc-dev

and pxa-i2s driver is here fyi :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob_plain;f=sound/soc/pxa/pxa2xx-i2s.c;hb=ppc-dev


Liam
