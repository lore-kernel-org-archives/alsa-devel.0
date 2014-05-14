From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ak4642 codec updates
Date: Wed, 14 May 2014 09:37:32 +0200
Message-ID: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 491C32619E5
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:37:42 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series has some updates to the ak4642 codec driver like ALC controls,
improved sysclk support for the ak4648.

Sascha

----------------------------------------------------------------
Sascha Hauer (6):
      ASoC: ak4642: Fix typo zoro -> zero
      ASoC: ak4642: Add ALC controls
      ASoC: ak4642: Add driver data and driver private struct
      ASoC: ak4642: Add support for extended sysclk frequencies of the ak4648
      ASoC: ak4642: Implement Microphone in pathes
      ASoC: ak4642: Add enable gpio support

 Documentation/devicetree/bindings/sound/ak4642.txt |   3 +
 sound/soc/codecs/ak4642.c                          | 230 +++++++++++++++++++--
 2 files changed, 221 insertions(+), 12 deletions(-)
