From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 0/3] ASoC driver for the TSE-850
Date: Fri, 11 Nov 2016 12:29:09 +0100
Message-ID: <1478863752-10569-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

v2 -> v3 changes:
- update the preparatory atmel_ssc_dai patch with error checking and
  fallback handling of the CMR_DIV divider in addition to the new
  fallback handling of TCMR_PERIOD/RCMR_PERIOD from v2.

v1 -> v2 changes:
- new subject for the bindings patch to make it easier to find
- move the driver to the sound/soc/atmel directory
- add cached values for add/loop1/loop2 to avoid gets from output gpios
- use _cansleep when updating gpios
- add comment on how the regulator voltage is mapped to the ana enum
- drop the .hw_params hook that did set the cpu dai divider and...
- ...add a preparatory patch that does this in the cpu dai driver instead
- drop .init and set the dapm routes directly in the card struct instead


The TSE-850 is an FM Transmitter Station Equipment, designed to generate
baseband signals for FM, mainly the DARC subcarrier, but other signals
are also possible.

This adds a driver for the "sound" bits of the device (quoted since it
is normally not used for normal sound output, but that works too of
course). 

I have not provided a patch to add axentia as a devicetree vendor prefix,
since such a patch is already pending in an IIO series [1] that seems
close to being accepted.

However, there are a couple of points that I'm not 100% satisfied with
for this driver.

First, I do not know how to describe the relays that control if the
IN1/IN2 signals are directly routed towards OUT1/OUT2 or if they are
routed to the "add" switch. The dapm routing treats this as if the
IN1/IN2 signals are always routed to both the "add" switch and to
the muxes feeding OUT1/OUT2. This is fine with me since nothing is
powered in those sections anyway, so what dapm thinks does not really
matter. But it is a wart all the same.

Second, there's my comment in tse850_put_mix() when the "add" switch
is updated. I believe this update should really happen as a side
effect of the call to snd_soc_dapm_mixer_update_power(), so that it
happens at the right point compared to other stuff that is powered.
But I do not know how to hook that up and instead I flip the switch
before the call since it doesn't really matter. I.e., any noise
resulting from this badness is negligeble in practice.

Cheers,
Peter

[1] http://lwn.net/Articles/705931

Peter Rosin (3):
  ASoC: atmel_ssc_dai: if not provided, default to sensible dividers
  ASoC: tse850: document axentia,tse850-pcm5142 bindings
  ASoC: atmel: tse850: add ASoC driver for the Axentia TSE-850

 .../bindings/sound/axentia,tse850-pcm5142.txt      |  88 ++++
 MAINTAINERS                                        |   7 +
 sound/soc/atmel/Kconfig                            |  10 +
 sound/soc/atmel/Makefile                           |   2 +
 sound/soc/atmel/atmel_ssc_dai.c                    |  83 +++-
 sound/soc/atmel/atmel_ssc_dai.h                    |   1 +
 sound/soc/atmel/tse850-pcm5142.c                   | 472 +++++++++++++++++++++
 7 files changed, 656 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
 create mode 100644 sound/soc/atmel/tse850-pcm5142.c

-- 
2.1.4
