From: Stephen J <stephenjust@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: Intel: Add support for surface3
	tablet
Date: Wed, 20 Jul 2016 09:05:46 -0600
Message-ID: <CAOvWGzj1sk2L5VYy7GVR-KNmimRmfexmejC1+E2zsAO196TB7w@mail.gmail.com>
References: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
 <1469026074.6761.63.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A8B261490
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 17:05:48 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id d65so3678684ith.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 08:05:48 -0700 (PDT)
In-Reply-To: <1469026074.6761.63.camel@hadess.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>
Cc: alsa-devel@alsa-project.org, apterix@gmail.com, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

On Jul 20, 2016 8:48 AM, "Bastien Nocera" <hadess@hadess.net> wrote:
>
> On Fri, 2016-07-08 at 15:39 +0530, Vinod Koul wrote:
> > Surface3 tablet is CHT based device which used RT5645 codec. But the
> > ACPI ID
> > is 10EC5640 which belong to RT5640 codec :(
> > So we add quirk support to load cht-machine driver for surface tablet
> > combination, add the ACPI id and DMI fix for jack detect in codec and
> > finally machine update.
> >
> > This fixes Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=9800
> > 1
> > Please verify and send your tested-by.
>
>
> Did anyone test this?
At least I did

> I get this output:
> Jul 20 16:20:32 surface kernel: rt5640 i2c-10EC5640:00: Device with ID
register 0x6308 is not rt5640/39
> Jul 20 16:20:34 surface kernel: cht-bsw-rt5645 cht-bsw-rt5645:
snd-soc-dummy-dai <-> media-cpu-dai mapping ok
> Jul 20 16:20:34 surface kernel: cht-bsw-rt5645 cht-bsw-rt5645:
snd-soc-dummy-dai <-> deepbuffer-cpu-dai mapping ok
> Jul 20 16:20:34 surface kernel: compress asoc: snd-soc-dummy-dai <->
compress-cpu-dai mapping ok
> Jul 20 16:20:34 surface kernel: cht-bsw-rt5645 cht-bsw-rt5645:
rt5645-aif1 <-> ssp2-port mapping ok
> Jul 20 16:20:34 surface kernel: input: chtrt5645 Headset as
/devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0/input25
>
> With the early warning telling me it's probably not going through the
> quirks, though the rest of the output makes me think otherwise.

Both rt5640 and rt5645 drivers pick up the sound chip, but only the correct
one succeeds.

>
> After PulseAudio starts I get:
> Jul 20 16:20:40 surface pulseaudio[1315]: [pulseaudio]
module-alsa-card.c: Failed to find a working profile.
> Jul 20 16:41:32 surface pulseaudio[1315]: [pulseaudio] module.c: Failed
to load module "module-alsa-card" (argument: "device_id="0"
name="platform-cht-bsw-rt5645"
card_name="alsa_card.platform-cht-bsw-rt5645" namereg_fail=false tsched=yes
fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes
card_properties="module-udev-detect.discovered=1""): initialization failed.
> Jul 20 16:20:40 surface kernel:  Audio Port: ASoC: no backend DAIs
enabled for Audio Port
> [and plenty more of that last line]
>
> $ journalctl -b | grep "Audio Port: ASoC: no backend DAIs enabled for
Audio Port" | wc -l
> 1802
>
> Ideas?

Are you using the alsa-lib patch to add UCM configuration too [1]?
Pulseaudio needs it to initialize properly (without other manual
intervention described in the bugzilla ticket for these patches).

[1]
http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=b6c69d7067a1818e53da774bdbdc3023f299d579
