From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 0/7] ALSA: hda: Move chmap helpers to core
Date: Wed,  2 Mar 2016 17:33:21 +0530
Message-ID: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 36B38261566
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 13:03:19 +0100 (CET)
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

changes in v2:
	- Splitted patches for easier review
	- Access most of chmap helpers through ops, thus reducing
	  number of exported APIs for chmap support

Subhransu S. Prusty (7):
  ALSA: hda - Create common chmap object
  ALSA: hda - Register chmap obj as priv data instead of codec
  ALSA: hda - Use hdmi name space for CEA spk alloc structure
  ALSA: hda - Add hdmi chmap verb programming ops to chmap object
  ALSA: hda - Use ops instead of directly accessing chmap helpers
  ALSA: hda - Move chmap support helpers/ops to core
  ALSA: hda - Use snd_hdmi namespace prefix for printing ch alloc api

 include/sound/hdmi_chmap.h |  75 ++++
 sound/hda/Makefile         |   2 +-
 sound/hda/hdmi_chmap.c     | 791 ++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_eld.c    |  31 +-
 sound/pci/hda/patch_hdmi.c | 830 +++++----------------------------------------
 5 files changed, 957 insertions(+), 772 deletions(-)
 create mode 100644 include/sound/hdmi_chmap.h
 create mode 100644 sound/hda/hdmi_chmap.c

-- 
1.9.1
