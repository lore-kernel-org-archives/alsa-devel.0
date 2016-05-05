From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/7] ASoC: rockchip: Fix audio on Veyron.
Date: Thu,  5 May 2016 10:03:34 +0200
Message-ID: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C137261AFF
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 10:03:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Hi all,

This patch series adds support and fixes the audio support for Veyron
devices. With these patches I'm able to playback from speakers and
headphones, and record from the microphone on a Veyron Jerry Chromebook.

Patches 1/7 and 2/7 were already sent by John Keeping,[1] [2], but I
think it's interesting have them included here.

Patches from 1/7 to 5/7 should go through the Mark Brown ASoC tree.

Patches 6/7 and 7/7 should go through the Heiko Stuebner rockchip tree.

[1] https://patchwork.kernel.org/patch/9017491/
[2] https://patchwork.kernel.org/patch/9017501/

Enric Balletbo i Serra (5):
  ASoC: rockchip-max98090: Fix NULL pointer de reference while accessing
    to jack
  ASoC: rockchip-max98090: Fix the Headset Mic route.
  ASoC: rockchip-max98090: Fix DAPM unknown pin for Headset Jack
  ARM: dts: rockchip: Add shared file for audio related nodes for veyron
    boards
  ARM: dts: rockchip: veyron: Add analog audio codecs.

John Keeping (2):
  ASoC: rockchip: Revert "ASoC: rockchip: i2s: remove unused variables"
  ASoC: rockchip: Revert "ASoC: rockchip: i2s: separate capture and
    playback"

 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi | 102 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   |   1 +
 sound/soc/rockchip/rockchip_i2s.c                 |  87 +++++++++++-------
 sound/soc/rockchip/rockchip_max98090.c            |  54 ++++++------
 4 files changed, 187 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi

-- 
2.1.0
