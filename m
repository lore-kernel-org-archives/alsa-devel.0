From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 0/3] ASoC: codecs: some more improvements
	for adau1701
Date: Fri, 21 Jun 2013 09:54:41 +0200
Message-ID: <1371801284-31603-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 2966E26552A
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 09:54:16 +0200 (CEST)
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

v3:
	- fixed documentation for adi,pll-clkdiv
	- droped implicit I2C_M_STOP
	- moved regcache_sync() to adau1761_reset()
	- added regcache_mark_dirty()
	- made gpio_pll_mode and array
	- dropped ADAU1701_CLKDIV_MCLK_LRCLK

Thanks for the review, Lars!


Daniel Mack (3):
  ASoC: codecs: adau1701: allow configuration of PLL mode pins
  ASoC: codecs: adau1701: switch to direct regmap API usage
  ASoC: codecs: adau1701: add support for pin muxing

 .../devicetree/bindings/sound/adi,adau1701.txt     |  21 ++
 sound/soc/codecs/adau1701.c                        | 248 ++++++++++++++++-----
 2 files changed, 214 insertions(+), 55 deletions(-)

-- 
1.8.1.4
