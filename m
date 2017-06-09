From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 0/4] Patches to fix some problem for
	rockchip i2s
Date: Fri,  9 Jun 2017 16:52:45 +0800
Message-ID: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 7026C266CB8
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 10:56:50 +0200 (CEST)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

These patches to fix some problem for rockchip i2s.


Sugar Zhang (3):
  ASoC: rockchip: i2s: add a delay before i2s clear
  ASoC: rockchip: i2s: add support for i2s bclk fs configuration
  ASoC: rockchip: i2s: fixup clk div

zhangjun (1):
  ASoC: rockchip: i2s: add other configurable formats

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  2 +
 sound/soc/rockchip/rockchip_i2s.c                  | 45 +++++++++++++++++++---
 sound/soc/rockchip/rockchip_i2s.h                  |  3 ++
 3 files changed, 45 insertions(+), 5 deletions(-)

-- 
1.9.1
