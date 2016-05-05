From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/3] ASoC: Intel: Skylake: Add HDA link
	management
Date: Thu,  5 May 2016 11:31:08 +0530
Message-ID: <1462428071-30248-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CBEC265A3E
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 07:55:19 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

HDA links are always kept On, this patch adds link management
routines in hdac extended core and it's use in Skylake driver and
hdmi codec (runs on HDA link)

The aim of serial is to shut down the links when not in use and
keep them active when a user is active. The user can activate
link by taking reference to the link when required.

When all links are closed, the command DMAs are turned off as
well. On first link power up, the command DMAs are turned on
first.

First patch touches HDA core, and rest two are dependent on it
so Takashi if you are okay, pls ACK it and we can merge thru ASoC
tree

Changes in v2:
 - use mutex instead of spinlock


Vinod Koul (3):
  ALSA: hdac: add link pm and ref counting
  ASoC: Intel: Skylake: add link management
  ASoC: hdac_hdmi: add link management

 include/sound/hdaudio_ext.h         | 13 ++++++++
 sound/hda/ext/hdac_ext_bus.c        |  3 ++
 sound/hda/ext/hdac_ext_controller.c | 62 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hdmi.c        | 32 +++++++++++++++++--
 sound/soc/intel/skylake/skl-pcm.c   |  1 -
 sound/soc/intel/skylake/skl.c       | 34 ++++++++++++++++++++
 6 files changed, 142 insertions(+), 3 deletions(-)

-- 
1.9.1
