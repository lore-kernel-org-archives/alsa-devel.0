From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 00/12] Combining snd_soc_*_volsw/volsw_2r
Date: Tue,  4 Oct 2011 14:39:37 +0300
Message-ID: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 3479924609
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:39:59 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so831475bka.30
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:39:58 -0700 (PDT)
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

Generated on top of:
git://opensource.wolfsonmicro.com/linux-2.6-asoc, for-3.2 branch

Regards,
Peter
---
Peter Ujfalusi (12):
  ASoC: core: Introduce SOC_DOUBLE_VALUE macro
  ASoC: core: Introduce SOC_DOUBLE_R_VALUE macro
  ASoC: Consolidate use of controls with custom get/put function
  ASoC: twl6040: Simplify custom get_volsw callback
  ASoC: twl6040: Simplify custom put_volsw callback
  ASoC: twl6040: Prepare for core put_volsw/volsw_2r merger
  ASoC: core: Change SOC_SINGLE/DOUBLE_VALUE representation
  ASoC: core: Combine snd_soc_info_volsw/info_volsw_2r functions
  ASoC: core: Combine snd_soc_get_volsw/get_volsw_2r functions
  ASoC: core: Combine snd_soc_out_volsw/put_volsw_2r functions
  ASoC: twl6040: Simply call snd_soc_put_volsw form the custom code
  ASoC: core: Remove snd_soc_put_volsw_2r definition

 include/sound/soc.h            |   82 +++++++++++----------
 sound/soc/codecs/tlv320aic23.c |   14 +---
 sound/soc/codecs/twl4030.c     |   48 +++---------
 sound/soc/codecs/twl6040.c     |   71 ++++--------------
 sound/soc/codecs/wm8350.c      |   39 ++++------
 sound/soc/codecs/wm8580.c      |   36 +++------
 sound/soc/codecs/wm_hubs.c     |   18 +---
 sound/soc/soc-core.c           |  161 +++++++++-------------------------------
 8 files changed, 142 insertions(+), 327 deletions(-)

-- 
1.7.7
