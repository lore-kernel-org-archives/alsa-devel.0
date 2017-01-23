From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 0/3] Add support for es8323 and hdmi audio
	to the firefly-rk3288
Date: Mon, 23 Jan 2017 14:47:44 +0100
Message-ID: <20170123134747.1385-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id BFFCC26686A
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2017 14:47:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This set of patches enables support for the es8323 codecs on the
firefly-rk3288. It adds the required DT definitions to link rockchip-i2s
to the es8388 analog output. As the support for HDMI audio is also
built-in in the corresponding ASoC machine driver, HDMI audio output is
also enabled.

Changes in v2:
 - Adapted DT for the firefly-rk3288 to the ASoC machine driver
   rk3288-hdmi-analog
 - Added patch 02/03 to this series
 - Re-wrote this cover letter

Romain Perier (3):
  SoC: es8328-i2c: Add compatible for ES8323
  arm: dts: rockchip: Don't set otp-gpio pinctrl by default in
    rk3288.dtsi
  arm: dts: Add support for ES8323 to the Firefly-RK3288

 Documentation/devicetree/bindings/sound/es8328.txt |  5 +++-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  4 +++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 34 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  4 +++
 arch/arm/boot/dts/rk3288.dtsi                      |  4 ---
 sound/soc/codecs/es8328-i2c.c                      |  2 ++
 6 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.9.3
