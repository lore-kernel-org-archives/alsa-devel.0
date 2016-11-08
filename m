From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] ASoC driver for the TSE-850
Date: Tue, 8 Nov 2016 17:20:55 +0100
Message-ID: <1478622057-12426-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10128.outbound.protection.outlook.com [40.107.1.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A3826648D
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 17:21:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Hi!

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

[1] http://www.spinics.net/lists/devicetree/thrd3.html#147258

Peter Rosin (2):
  dt-bindings: sound: document axentia,tse850-pcm5142 bindings
  ASoC: axentia: tse850: add ASoC driver for the Axentia TSE-850

 .../bindings/sound/axentia,tse850-pcm5142.txt      |  88 ++++
 MAINTAINERS                                        |   7 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/axentia/Kconfig                          |  10 +
 sound/soc/axentia/Makefile                         |   3 +
 sound/soc/axentia/tse850-pcm5142.c                 | 504 +++++++++++++++++++++
 7 files changed, 614 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
 create mode 100644 sound/soc/axentia/Kconfig
 create mode 100644 sound/soc/axentia/Makefile
 create mode 100644 sound/soc/axentia/tse850-pcm5142.c

-- 
2.1.4
