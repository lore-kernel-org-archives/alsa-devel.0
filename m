From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 0/5] ASoC: updates for core support for
	msbits constraints
Date: Wed, 18 Jan 2012 12:18:21 +0100
Message-ID: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 6031E103B48
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:18:53 +0100 (CET)
Received: by mail-gx0-f180.google.com with SMTP id k5so5363365ggd.39
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 03:18:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Changes from v3:
- no need to initialize ret to zero in soc_pcm_apply_msb. The function is void.
- created against for-3.4 branch (leaving out already applied patches)

Intro mail for v1:
I would prefer to have the msbits constraints to be applied to only sample sizes
bigger than the requested msbits from dais.
I'm resending your patch plus the modification which will make the possible.
I have also converted the drivers I know have this constraint.

If you prefer, you can squash the first two patch.

Regards,
Peter
---
Peter Ujfalusi (5):
  ASoC: Apply msbits constraint for sample size bigger than the msbits
  ASoC: omap-dmic: Use core to set the msbits constraint
  ASoC: omap-mcpdm: Set 24msbits constraint
  ASoC: tlv320dac33: Use core to set the msbits constraint
  ASoC: twl4030: Use core to set the msbits constraint

 sound/soc/codecs/tlv320dac33.c |    3 +--
 sound/soc/codecs/twl4030.c     |    7 ++++---
 sound/soc/omap/omap-dmic.c     |    7 +++----
 sound/soc/omap/omap-mcpdm.c    |    2 ++
 sound/soc/soc-pcm.c            |    4 +++-
 5 files changed, 13 insertions(+), 10 deletions(-)

-- 
1.7.8.3
