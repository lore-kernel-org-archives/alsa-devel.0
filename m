From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Skylake: Add HDA link
	management
Date: Thu, 28 Apr 2016 19:30:57 +0530
Message-ID: <1461852059-20518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 944AD266D59
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:55:13 +0200 (CEST)
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

HDA links are always kept On, this patch adds link management routines in hdac
extended core and it's use in Skylake driver.
One more patch to add support in codec will follow this

The aim of serial is to shut down the links when not in use and keep them
active when a user is active. The user can activate link by taking reference
to the link when required.

When all links are shutdown, the command DMAs are turned off as well. On
first link power up, the command DMAs are turned on first.


First patch touches HDA core, and second one is dependent on it so Takashi
if you are okay, pls ACK it and we cna merge thru ASoC tree

Vinod Koul (2):
  ALSA: hdac: add link pm and ref counting
  ASoC: Intel: Skylake: add link mangement

 include/sound/hdaudio_ext.h         | 13 ++++++++
 sound/hda/ext/hdac_ext_bus.c        |  3 ++
 sound/hda/ext/hdac_ext_controller.c | 62 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c   |  1 -
 sound/soc/intel/skylake/skl.c       | 34 ++++++++++++++++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

-- 
1.9.1
