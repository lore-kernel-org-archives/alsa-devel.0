From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 0/7] ALSA: hda: Move chmap helpers to core
Date: Fri,  4 Mar 2016 19:59:45 +0530
Message-ID: <1457101792-19441-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D1435260673
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 15:29:49 +0100 (CET)
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

changes in v3:
	- Namespace managed as per hda frmwrk requirement
	- Address review comments in v2

Subhransu S. Prusty (7):
  ALSA: hda - Create common chmap object
  ALSA: hda - Register chmap obj as priv data instead of codec
  ALSA: hda - Use hdac name space for CEA spk alloc structure
  ALSA: hda - Add hdmi chmap verb programming ops to chmap object
  ALSA: hda - chmap helper args modified to use generic hdac objs.
  ALSA: hda - Move chmap support helpers/ops to core
  ALSA: hda - Use snd_hdac namespace prefix for chmap exported APIs

 include/sound/hda_chmap.h  |  76 +++++
 sound/hda/Makefile         |   2 +-
 sound/hda/hdmi_chmap.c     | 791 +++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_eld.c    |  31 +-
 sound/pci/hda/patch_hdmi.c | 824 +++++----------------------------------------
 5 files changed, 950 insertions(+), 774 deletions(-)
 create mode 100644 include/sound/hda_chmap.h
 create mode 100644 sound/hda/hdmi_chmap.c

-- 
1.9.1
