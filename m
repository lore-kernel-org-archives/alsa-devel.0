From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH v2 0/3] Add support simple-card parse jack
	detection via external codec
Date: Mon, 18 Apr 2016 19:20:00 +0800
Message-ID: <1460978403-4754-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id E786B2650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 13:20:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, dianders@chromium.org, Xing Zheng <zhengxing@rock-chips.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Takashi Iwai <tiwai@suse.com>, sugar.zhang@rock-chips.com, jay.xu@rock-chips.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Adam.Thomson@diasemi.com, broonie@kernel.org, Kumar Gala <galak@codeaurora.org>, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org


Hi,
    In most cases, many codecs already supports jack detection,
previouslly, we need to create a customized machine driver every time.

    In my opinion, the codec fill the detect_jack explicitly and tell
sound framework it supports the jack detection, the simple-card is
able to parse the dts file and call the export function to initialize
the jace detection via the codec.

    I think that it will bring better flexibility.

    Thanks.

Changes in v1:
- clean up the commit message and notes

Xing Zheng (3):
  ASoC: jack: Add an export of a function that calls the codec jack
    detection
  ASoC: simple-card: Add support call the codec jack detection after
    parse dts
  ASoC: da7219: Add detect_jack callback in the snd_soc_codec_driver

 .../devicetree/bindings/sound/simple-card.txt      |   17 +++
 include/sound/soc.h                                |    7 ++
 sound/soc/codecs/da7219.c                          |    2 +
 sound/soc/generic/simple-card.c                    |  126 +++++++++++++++++++-
 sound/soc/soc-jack.c                               |   17 +++
 5 files changed, 166 insertions(+), 3 deletions(-)

-- 
1.7.9.5
