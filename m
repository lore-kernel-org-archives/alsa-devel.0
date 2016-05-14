From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4 0/4] ASoC: MAX9860: new driver
Date: Sat, 14 May 2016 23:09:37 +0200
Message-ID: <1463260181-21344-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0090.outbound.protection.outlook.com [104.47.0.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B8D92614BB
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 23:14:17 +0200 (CEST)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Misbah Ullah Khan <Misbahk@danlawinc.com>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Hi!

I kept the sidetone changes in separate patches since I don't know
if I solved the DAPM-off issue cleanly enough. Also, a new driver may
still have a chance to make 4.7, but maybe it's too late for the DAPM
changes?

Finally, I wonder if the device tree crowd prefers seeing the whole of
a series such as this, or only the bindings patch?

Cheers,
Peter

New in v4:
- Split out the device tree bindings in its own patch.
- Move format check from ->startup to ->set_fmt.
- Don't spam the log on probe defer.
- Follow-up patches for the backwards sidetone control.

New in v3:
- The updated bindings file went missing in v2. Sorry for the confusion.

New in v2:
- Add comment about fall through when Integer Clock Mode is not possible.
- Drop export of max9860_probe.
- Ignore clk docs and read the mclk rate w/o enabling the clock.
- Manage the DVDDIO supply.

Peter Rosin (4):
  dt-bindings: sound: add bindings for the max9860 codec
  ASoC: MAX9860: new driver
  ASoC: dapm: support mixer controls with mute at non-zero value
  ASoC: MAX9860: add sidetone mixer control

 .../devicetree/bindings/sound/max9860.txt          |  28 +
 MAINTAINERS                                        |   7 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max9860.c                         | 765 +++++++++++++++++++++
 sound/soc/codecs/max9860.h                         | 162 +++++
 sound/soc/soc-dapm.c                               |  38 +-
 7 files changed, 1005 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/max9860.txt
 create mode 100644 sound/soc/codecs/max9860.c
 create mode 100644 sound/soc/codecs/max9860.h

-- 
2.1.4
