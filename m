From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/2] ASoC: codec tlv320aic32x4 fixes
Date: Sat, 11 Jan 2014 14:48:29 +0100
Message-ID: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 00AAB2619E9
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 14:49:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

Here are two fixes for the tlv320aic32x4 codec. The first patch fixes a regmap
bug introduced in 3.13. The second is not as important, it adds the codec to
the compatible list in the binding documentation.

Regards,

Markus

Markus Pargmann (2):
  ASoC: codec: tlv320aic32x4: Fix regmap range config
  ASoC: codec doc, tlv320aic3x: Add tlv320aic32x4 as compatible

 Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 1 +
 sound/soc/codecs/tlv320aic32x4.c                        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.5.2
