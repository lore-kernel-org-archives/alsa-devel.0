From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/3] ALSA: hda: Move chmap helpers to core
Date: Mon, 22 Feb 2016 13:30:37 +0530
Message-ID: <1456128040-12141-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C6BEA260789
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 09:00:04 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The HDMI channel map helper APIs and control registration can be
reused by ASoC skylake HDMI drivers.

A common chmap object is created, channel map control callback
handlers, helper APIs and data structures are moved to the core.
Driver object store an instance of this chmap object to register
chmap controls and program channel allocation for HDMI infoframe.
Driver registers ops for specific operations.

Subhransu S. Prusty (3):
  ALSA: hda - Create common chmap object
  ALSA: hda - Move chmap support helpers/structures to core
  ALSA: hda - Use the helpers from HDA core

 include/sound/hdaudio.h    |   1 +
 include/sound/hdmi_chmap.h |  84 +++++
 sound/hda/Makefile         |   2 +-
 sound/hda/hdmi_chmap.c     | 763 +++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_eld.c    |  31 +-
 sound/pci/hda/patch_hdmi.c | 794 ++++-----------------------------------------
 6 files changed, 923 insertions(+), 752 deletions(-)
 create mode 100644 include/sound/hdmi_chmap.h
 create mode 100644 sound/hda/hdmi_chmap.c

-- 
1.9.1
