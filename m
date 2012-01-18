From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/7] ASoC: Add support in core to set msbits
	constraint
Date: Wed, 18 Jan 2012 10:51:01 +0100
Message-ID: <1326880268-3509-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 187CF245CF
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 10:51:38 +0100 (CET)
Received: by ggnp4 with SMTP id p4so4676319ggn.14
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 01:51:24 -0800 (PST)
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

Changes from v2:
- initialize ret to zero in soc_pcm_apply_msb

I would prefer to have the msbits constraints to be applied to only sample sizes
bigger than the requested msbits from dais.
I'm resending your patch plus the modification which will make the possible.
I have also converted the drivers I know have this constraint.

If you prefer, you can squash the first two patch.

Regards,
Peter
---
Mark Brown (2):
  ASoC: Allow drivers to specify how many bits are significant on a DAI
  ASoC: 24 bits are significant on the WM8996 audio interfaces

Peter Ujfalusi (5):
  ASoC: Apply msbits constraint for sample size bigger than the msbits
  ASoC: omap-dmic: Use core to set the msbits constraint
  ASoC: omap-mcpdm: Set 24msbits constraint
  ASoC: tlv320dac33: Use core to set the msbits constraint
  ASoC: twl4030: Use core to set the msbits constraint

 include/sound/soc.h            |    1 +
 sound/soc/codecs/tlv320dac33.c |    3 +--
 sound/soc/codecs/twl4030.c     |    7 ++++---
 sound/soc/codecs/wm8996.c      |    4 ++++
 sound/soc/omap/omap-dmic.c     |    7 +++----
 sound/soc/omap/omap-mcpdm.c    |    2 ++
 sound/soc/soc-pcm.c            |   39 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 54 insertions(+), 9 deletions(-)

-- 
1.7.8.3
