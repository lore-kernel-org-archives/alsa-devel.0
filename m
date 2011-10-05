From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/10] Combining snd_soc_*_volsw/volsw_2r
Date: Wed,  5 Oct 2011 10:29:18 +0300
Message-ID: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 765751038BB
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:42 +0200 (CEST)
Received: by bkbzt19 with SMTP id zt19so1633957bkb.9
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:39 -0700 (PDT)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Changes since v1 (RFC series):
- rebased on git://opensource.wolfsonmicro.com/linux-2.6-asoc, for-3.2 branch
- twl6040: warning added for the custom volsw calls in case of unexpected
  parameter
- snd_soc_volsw_is_stereo returns type changed to bool
- patch 06: optimized the if() cases in order to reduce the number of comparison
  in certain cases
- patch 06: Use the (reg == reg2) comparison instead of (shift != rshitf) to
  differentiate between single or 2r type of stereo controls
- patch 07: Use the (reg == reg2) comparison instead of (shift != rshitf) to
  differentiate between single or 2r type of stereo controls

Intro mail from v1:
This series will combine the snd_soc_*_volsw, and snd_soc_*_volsw_2r callbacks.

We are going to drop the volsw_r2 callbacks, and merge the support to the
_volsw functions.
In order to achieve this, the macros need to be adjusted, and also the drivers,
which were not using the macros to construct the soc_mixer_control needed to
be changed, so I'm not going to introduce any breakage, inconsistency.

This has been suggested in this thread:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/044287.html

By Mark in this mail (I hope I did not misunderstood it):
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/044343.html

The use of the existing macros will not change, but underneath we are not going
to have two sets of functions for single, or double mixer controls.

I think the last 3 patch can be squashed, I did not wanted to touch the core,
and a codec driver in a same patch.

Regards,
Peter
---
Peter Ujfalusi (10):
  ASoC: Consolidate use of controls with custom get/put function
  ASoC: twl6040: Simplify custom get_volsw callback
  ASoC: twl6040: Prepare for core put_volsw/volsw_2r merger
  ASoC: core: Change SOC_SINGLE/DOUBLE_VALUE representation
  ASoC: core: Combine snd_soc_info_volsw/info_volsw_2r functions
  ASoC: core: Combine snd_soc_get_volsw/get_volsw_2r functions
  ASoC: core: Combine snd_soc_put_volsw/put_volsw_2r functions
  ASoC: twl6040: Simply call snd_soc_put_volsw form the custom code
  ASoC: core: Remove snd_soc_put_volsw_2r definition
  ASoC: twl6040: Warn user in twl6040_put_volsw for error case

 include/sound/soc.h            |   33 +++++---
 sound/soc/codecs/tlv320aic23.c |   14 +---
 sound/soc/codecs/twl4030.c     |   48 +++---------
 sound/soc/codecs/twl6040.c     |   64 ++++------------
 sound/soc/codecs/wm8350.c      |   39 ++++------
 sound/soc/codecs/wm8580.c      |   36 +++------
 sound/soc/codecs/wm_hubs.c     |   18 +---
 sound/soc/soc-core.c           |  162 +++++++++-------------------------------
 8 files changed, 117 insertions(+), 297 deletions(-)

-- 
1.7.7
