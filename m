From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 0/2] Patches to add support spdif for rk322x
Date: Fri,  9 Jun 2017 15:59:31 +0800
Message-ID: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E7A4266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 10:03:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, broonie@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

These patches to add support spdif for rk322x socs.


Sugar Zhang (2):
  ASoC: rockchip: add bindings for spdif controller
  ARM: dts: rk322x: add spdif node

 .../devicetree/bindings/sound/rockchip-spdif.txt     |  2 ++
 arch/arm/boot/dts/rk322x.dtsi                        | 20 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_spdif.c                  |  4 ++++
 3 files changed, 26 insertions(+)

-- 
1.9.1
