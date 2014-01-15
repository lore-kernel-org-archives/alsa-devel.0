From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/3] ASoC: tlv320aic32x4 bugfixes
Date: Wed, 15 Jan 2014 18:12:39 +0100
Message-ID: <1389805962-18670-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 527472610B7
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2014 18:13:24 +0100 (CET)
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

Another round of tlv320aic32x4 bugfixes.

I will send some more non-bugfix patches for this codec next week including the
DT compatibles we talked about.

Regards,

Markus


Markus Pargmann (3):
  ASoC: tlv320aic32x4: Fix regmap range_min
  ASoC: tlv320aic32x4: Fix mono playback
  ASoC: tlv320aic32x4: Fix MICPGA input configuration

 sound/soc/codecs/tlv320aic32x4.c | 30 ++++++++++++++++++------------
 sound/soc/codecs/tlv320aic32x4.h |  3 +++
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
1.8.5.2
