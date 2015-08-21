From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/5] ALSA: hdac: More hdac core fixes and
	updates
Date: Fri, 21 Aug 2015 21:36:16 +0530
Message-ID: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 174982605B8
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 18:04:34 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

We had few more hdac core fixes & enhancements so senidng those.

First one is fix for register pointers for spcap and link registers. This is
required for SKL driver when we use link registers.

rest add new APIs for powering down all links, getting stream from stream
tag and direction, enabling SPIB.

Last one remove keys as we dont need them for host streams

Jeeja KP (5):
  ALSA: hdac: Fix to read the correct offset of spcap/link register
  ALSA: hdac: Add snd_hdac_ext_bus_link_power_down_all()
  ALSA: hdac: Add snd_hdac_get_hdac_stream()
  ALSA: hdac: Add support to enable SPIB for hdac ext stream
  ALSA: hdac: Remove the usage of key for host stream

 include/sound/hda_register.h        |  4 +++
 include/sound/hdaudio.h             |  2 ++
 include/sound/hdaudio_ext.h         | 11 +++++++
 sound/hda/ext/hdac_ext_controller.c | 30 +++++++++++++++---
 sound/hda/ext/hdac_ext_stream.c     | 62 ++++++++++++++++++++++++++++++++-----
 sound/hda/hdac_stream.c             | 19 ++++++++++++
 6 files changed, 116 insertions(+), 12 deletions(-)

Thanks
-- 
~Vinod
