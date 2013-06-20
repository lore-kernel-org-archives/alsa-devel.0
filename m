From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 0/3] ASoC: codecs: some more improvements
	for adau1701
Date: Thu, 20 Jun 2013 19:29:54 +0200
Message-ID: <1371749397-32238-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id EE3182652E6
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 19:29:29 +0200 (CEST)
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

Sorry Lars, it's been a while since the last round.

I hope I addressed all the details you mentioned.

Thanks for having another look,
Daniel

Daniel Mack (3):
  ASoC: codecs: adau1701: allow configuration of PLL mode pins
  ASoC: codecs: adau1701: switch to direct regmap API usage
  ASoC: codecs: adau1701: add support for pin muxing

 .../devicetree/bindings/sound/adi,adau1701.txt     |  18 ++
 sound/soc/codecs/adau1701.c                        | 250 ++++++++++++++++-----
 sound/soc/codecs/adau1701.h                        |   4 +
 3 files changed, 216 insertions(+), 56 deletions(-)

-- 
1.8.1.4
