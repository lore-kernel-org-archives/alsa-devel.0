From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v2 0/3] ASoC: rockchip: i2s: add 8 channels
	capture support and share lrck
Date: Thu,  8 Oct 2015 20:40:06 +0800
Message-ID: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A99E261A3D
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 14:40:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

support 8 channels capture support.
share lrck tx/rx when symmetric_rates enabled.

Sugar Zhang (3):
  ASoC: rockchip: i2s: add 8 channels capture support
  Documentation: DT bindings: rockchip-i2s: add capture property
  ASoC: rockchip: i2s: share tx/rx lrck when symmetric_rates enabled

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  2 +
 sound/soc/rockchip/rockchip_i2s.c                  | 48 +++++++++++++++++++++-
 sound/soc/rockchip/rockchip_i2s.h                  | 16 ++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.3.6
