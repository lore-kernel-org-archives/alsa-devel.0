From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH 0/2] ASoC: add mt6351 codec driver
Date: Thu, 26 Apr 2018 11:07:30 +0800
Message-ID: <20180426030732.5887-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id C8EED2677A5
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 05:07:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

This patch adds the MediaTek MT6351 codec driver.

KaiChieh Chuang (2):
  ASoC: add documents for mt6351
  ASoC: add mt6351 codec driver

 Documentation/devicetree/bindings/sound/mt6351.txt |   16 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/mt6351.c                          | 1506 ++++++++++++++++++++
 sound/soc/codecs/mt6351.h                          |  105 ++
 5 files changed, 1633 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6351.txt
 create mode 100644 sound/soc/codecs/mt6351.c
 create mode 100644 sound/soc/codecs/mt6351.h

-- 
2.12.5
