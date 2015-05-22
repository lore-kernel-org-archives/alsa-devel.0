From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 0/5] Add a gpio jack device
Date: Fri, 22 May 2015 15:09:18 -0700
Message-ID: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f202.google.com (mail-ob0-f202.google.com
 [209.85.214.202])
 by alsa0.perex.cz (Postfix) with ESMTP id E42C2260436
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 00:10:55 +0200 (CEST)
Received: by obcuy5 with SMTP id uy5so1844623obc.1
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:10:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, zhengxing@rock-chips.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The first three changes add a gpio audio jack device.  This device can
be used on systems that report headphone or mic plug through GPIOS.
There can be 0-N of these devices created per board each can report one
of several events.  For example, this allows for a single jack for
HP/Mic and a separate jack for line out.

The last two patches are an example of the jack being used on Acer's
Tegra Chromebook, those can be considered separately and might not be
worth the churn.

Dylan Reid (5):
  ALSA: Add jack types to dt-bindings
  ASoC: jack - make add_gpiods accept pre-filled descriptors
  ASoC: Add GPIO based jack device
  ASoC: tegra_max98090: Change nyan to use gpio-jack
  ARM: tegra: nyan: specify gpio-audio-jack device

 .../devicetree/bindings/sound/gpio-audio-jack.txt  |  39 +++++
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  22 ++-
 include/dt-bindings/sound/audio-jack-events.h      |   9 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/gpio-audio-jack.c                 | 191 +++++++++++++++++++++
 sound/soc/soc-jack.c                               |   9 +-
 sound/soc/tegra/tegra_max98090.c                   | 107 +++---------
 8 files changed, 291 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/gpio-audio-jack.txt
 create mode 100644 include/dt-bindings/sound/audio-jack-events.h
 create mode 100644 sound/soc/codecs/gpio-audio-jack.c

-- 
2.2.1.62.g3f15098
