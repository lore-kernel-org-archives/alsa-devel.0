From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: [alsa-devel] [PATCH 0/2] ASoC: mediatek: add power-domain ctrl for 2701
Date: Thu, 16 Feb 2017 13:27:14 +0800
Message-ID: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.de
Cc: garlic.tseng@mediatek.com, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org

add power-domain get/put ctrl for 2701 and add relative node description
in binding doc.

Garlic Tseng (2):
  ASoC: mediatek: add power-domain get/put ctrl for mt2701
  ASoC: mediatek: add power-domains for mt2701-afe-pcm.txt

 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 ++
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c                 | 2 ++
 2 files changed, 4 insertions(+)

-- 
1.9.1
