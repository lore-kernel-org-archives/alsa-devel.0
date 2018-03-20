From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 0/3] Fix audio regression on rk3288
Date: Tue, 20 Mar 2018 13:03:29 -0300
Message-ID: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A6D2671F9
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:04:24 +0100 (CET)
Received: by mail-qt0-f195.google.com with SMTP id n12so2142193qtl.5
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 09:04:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Currently on rk3288 boards the ASoC machine driver fails to load,
breaking audio support.

Apparently, the regression was introduced by commit 24069b589b02
("ASoC: hdmi-codec: remove multi detection support") which changed
the codec name.

If there is a lesson here, it would be about binding drivers using
strings and how fragile this is. Or maybe it's about regression
testing. Or maybe there isn't a lesson.

Anyway, the first patch fixes the regression; the second patch
makes the machine driver selects all the codecs it; finally
the third patch is just a binding documentation fix.

Tested on a Radxa Rock2 Square board.

Ezequiel Garcia (3):
  ASoC: rockchip: Fix dai_name for HDMI codec
  ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs
  dt-bindings: sound: rockchip Fix compatible string in example

 .../devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt          | 2 +-
 sound/soc/rockchip/Kconfig                                             | 3 +++
 sound/soc/rockchip/rk3288_hdmi_analog.c                                | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.16.2
