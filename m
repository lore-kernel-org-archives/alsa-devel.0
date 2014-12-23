From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 0/2] ASoC: rockchip: i2s: fix TDL and RDL to 16
	bits
Date: Tue, 23 Dec 2014 17:08:27 +0800
Message-ID: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 1600B2614A9
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 10:10:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, heiko@sntech.de, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, sonnyrao@chromium.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jianqun Xu <jay.xu@rock-chips.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

To make Bus DMA works more efficiency, DMA may work in burst mode,
   we set the watermark of transmit and receive reach to 16 bits.

Jianqun Xu (2):
  ASoC: rockchip: i2s: fix error defination of transmit data level
  ASoC: rockchip: i2s: set TDL and RDL to 16 bits

 sound/soc/rockchip/rockchip_i2s.c | 4 ++++
 sound/soc/rockchip/rockchip_i2s.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
1.9.1
