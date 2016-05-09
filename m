From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v2 0/5] ASoC: rockchip: Fix audio on Veyron.
Date: Mon,  9 May 2016 12:46:30 +0200
Message-ID: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

This patch series adds support and fixes the audio support for Veyron
devices. With these patches I'm able to playback from speakers and
headphones, and record from the microphone on a Veyron Jerry Chromebook.

Patches from 1/5 to 3/5 should go through the Mark Brown ASoC tree.

Patches 4/5 and 5/5 should go through the Heiko Stuebner rockchip tree.

Changes since v1:
 - Improve log messages trying to explain better the issues (suggested by Mark Brown)
 - Remove patches from John Keeping as are already cherry-picked.
   - https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=a6e806c49e3265494ac6fe6ec88ed5c010652e0d
   - https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=7e885d211f023dfd201fad8246bbf3c3bd126c61

Enric Balletbo i Serra (5):
  ASoC: rockchip-max98090: Fix NULL pointer dereference while accessing
    to jack.
  ASoC: rockchip-max98090: Fix the Headset Mic route.
  ASoC: rockchip-max98090: Fix jack detection and event reporting.
  ARM: dts: rockchip: Add shared file for audio related nodes for veyron
    boards
  ARM: dts: rockchip: veyron: Add analog audio codecs.

 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi | 102 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   |   1 +
 sound/soc/rockchip/rockchip_max98090.c            |  65 ++++++++------
 3 files changed, 140 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi

-- 
2.1.0
