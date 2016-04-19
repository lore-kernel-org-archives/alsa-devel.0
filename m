From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 0/3] ASoC: tlv320aic32x4: Add SPI Support
Date: Mon, 18 Apr 2016 17:24:03 -0700
Message-ID: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4518F265307
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 02:24:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The TLV320AIC32x4 support the control channel over either SPI or I2C.
Added the proper interfacing with regmap to make the driver able to
handle either possibility.

Jeremy McDermond (3):
  ASoC: tlv320aic32x4: Change name of probe function
  ASoC: tlv320aic32x4:  Break out I2C support into separate module
  ASoC: tlv320aic32x4:  Add SPI support.

 sound/soc/codecs/Kconfig             | 13 +++++-
 sound/soc/codecs/Makefile            |  4 ++
 sound/soc/codecs/tlv320aic32x4-i2c.c | 74 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4-spi.c | 76 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 80 ++++++++++++------------------------
 sound/soc/codecs/tlv320aic32x4.h     |  7 ++++
 6 files changed, 199 insertions(+), 55 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic32x4-i2c.c
 create mode 100644 sound/soc/codecs/tlv320aic32x4-spi.c

-- 
2.5.0
