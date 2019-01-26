From: Shunli Wang <shunli.wang@mediatek.com>
Subject: [RESEND PATCH 0/6] ASoC: Mediatek: Add support for
	MT8183 SoC and MT6358 Codec
Date: Sat, 26 Jan 2019 15:44:54 +0800
Message-ID: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D3C26680F
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 08:45:36 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, shunli.wang@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for Mediatek AFE for MT8183 SoC and codec for MT6358.
The patch is based on broonie tree "for-next" branch.
(Because it seems ALSA-DEVEL have not received previous mail,
this is a resend mail for this patchset.)

Shunli Wang (6):
  ASoC: mediatek: mt8183: add platform driver
  ASoC: mediatek: mt8183: add audio afe document
  ASoC: mediatek: mt6358: add codec driver
  ASoC: mediatek: mt6358: add codec document
  ASoC: mediatek: mt8183: add mt8183-mt6358 machine driver
  ASoC: mediatek: add document for mt8183-mt6358

 Documentation/devicetree/bindings/sound/mt6358.txt |   18 +
 .../devicetree/bindings/sound/mt8183-afe-pcm.txt   |   36 +
 .../devicetree/bindings/sound/mt8183-mt6358.txt    |   12 +
 sound/soc/codecs/Kconfig                           |    7 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/mt6358.c                          | 2336 ++++++++++++++++++++
 sound/soc/codecs/mt6358.h                          | 2314 +++++++++++++++++++
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt8183/Makefile                 |   13 +
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |  611 +++++
 sound/soc/mediatek/mt8183/mt8183-afe-clk.h         |   38 +
 sound/soc/mediatek/mt8183/mt8183-afe-common.h      |  108 +
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         | 1237 +++++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |  501 +++++
 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c    |  118 +
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         | 1040 +++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c         |  318 +++
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         |  639 ++++++
 sound/soc/mediatek/mt8183/mt8183-interconnection.h |   33 +
 sound/soc/mediatek/mt8183/mt8183-mt6358.c          |  208 ++
 sound/soc/mediatek/mt8183/mt8183-reg.h             | 1666 ++++++++++++++
 22 files changed, 11276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-mt6358.txt
 create mode 100644 sound/soc/codecs/mt6358.c
 create mode 100644 sound/soc/codecs/mt6358.h
 create mode 100644 sound/soc/mediatek/mt8183/Makefile
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-mt6358.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-reg.h

-- 
1.9.1
