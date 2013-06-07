From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/4] ASoC: codecs: some more improvements for
	adau1701
Date: Fri,  7 Jun 2013 13:53:03 +0200
Message-ID: <1370605987-19290-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A892656E2
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 13:52:47 +0200 (CEST)
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

Here are some more patches that I worked on while bootstrapping a new
audio device featuring an ADAU1701 DSP.

Daniel Mack (4):
  ASoC: codecs: adau1701: factor out firmware reset
  ASoC: codecs: adau1701: allow configuration of PLL mode pins
  ASoC: codecs: adau1701: switch to direct regmap API usage
  ASoC: codecs: adau1701: add support for pin muxing

 .../devicetree/bindings/sound/adi,adau1701.txt     |  17 ++
 sound/soc/codecs/adau1701.c                        | 255 ++++++++++++++++++---
 sound/soc/codecs/adau1701.h                        |   4 +
 3 files changed, 238 insertions(+), 38 deletions(-)

-- 
1.8.1.4
