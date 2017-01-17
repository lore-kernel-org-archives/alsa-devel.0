From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 0/2] Add support for es8323 on the
	firefly-rk3288
Date: Tue, 17 Jan 2017 10:12:08 +0100
Message-ID: <20170117091210.6837-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 89F5D266718
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 10:12:21 +0100 (CET)
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
to the es8388 analog output.

Romain Perier (2):
  SoC: es8328-i2c: Add compatible for ES8323
  arm: dts: Add support for ES8323 to the Firefly-RK3288

 Documentation/devicetree/bindings/sound/es8328.txt |  5 ++++-
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 25 ++++++++++++++++++++++
 sound/soc/codecs/es8328-i2c.c                      |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.9.3
