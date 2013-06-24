From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 0/4] ASoC: codecs: some more improvements
	for adau1701
Date: Mon, 24 Jun 2013 16:31:28 +0200
Message-ID: <1372084292-4859-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 19467265090
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:31:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lars@metafoo.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

v4:
	- added one more patch to move the firmware download,
	  for more clarity.
	- postpone the firmware download to the first call of
	  hw_params(), so we don't need to pass a default pll div in DT.
	- drop adi,pll-clkdiv entirely

v3:
	- fixed documentation for adi,pll-clkdiv
	- droped implicit I2C_M_STOP
	- moved regcache_sync() to adau1761_reset()
	- added regcache_mark_dirty()
	- made gpio_pll_mode and array
	- dropped ADAU1701_CLKDIV_MCLK_LRCLK


Daniel Mack (4):
  ASoC: codecs: adau1701: move firmware download to adau1701_reset()
  ASoC: codecs: adau1701: allow configuration of PLL mode pins
  ASoC: codecs: adau1701: switch to direct regmap API usage
  ASoC: codecs: adau1701: add support for pin muxing

 .../devicetree/bindings/sound/adi,adau1701.txt     |  12 +
 sound/soc/codecs/adau1701.c                        | 277 ++++++++++++++++-----
 2 files changed, 232 insertions(+), 57 deletions(-)

-- 
1.8.1.4
