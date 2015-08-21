From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ALSA: hdac: add codec driver support
Date: Fri, 21 Aug 2015 15:47:39 +0530
Message-ID: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2423B2604E4
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 12:15:35 +0200 (CEST)
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

This patch adds the core framework support for adding hdac extended devices
and drivers. We introduce a minimal hdac extended device and driver and APIs
for registration
This series also ads extended device cleanup API and refresh sysfs tree API

Vinod Koul (4):
  ALSA: hdac: Add API for removing hdac extended device
  ALSA: hdac: add hdac extended device
  ALSA: hdac: add extended device driver registration
  ALSA: hdac: add snd_hdac_refresh_widget_sysfs()

 include/sound/hdaudio.h      |  1 +
 include/sound/hdaudio_ext.h  | 60 +++++++++++++++++++++++++++
 sound/hda/ext/hdac_ext_bus.c | 98 ++++++++++++++++++++++++++++++++++++++++++--
 sound/hda/hdac_device.c      | 28 +++++++++++++
 4 files changed, 183 insertions(+), 4 deletions(-)

-- 
1.9.1
