From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/5] ALSA - hda: Add support for link audio
	time reporting
Date: Wed,  3 Aug 2016 21:36:09 +0530
Message-ID: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 587012666B9
 for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2016 17:59:23 +0200 (CEST)
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

Skylake onwards we support GTS capability and thus can report audio link
time. This series adds support for parsing the capability and then reports
link time.

The parsing of caps is made common and moved up from extended hda to hdac.
The SKL driver and hdac extended core has been updated for this.

Mark,
	The update of the driver needs to update Skl driver, so if you can
ACK the 2nd patch, it can go along with extended audio change thru ALSA
tree.

Changes in v3:
	moved extended hda to hdac
	update SKL drv to use new hdac caps
	update patchset for HDA drv to use new caps parsing

Guneshwor Singh (2):
  ALSA - hda: Add support for parsing new HDA capabilities
  ALSA - hda: Add support for link audio time reporting

Vinod Koul (3):
  ALSA: hda - move bus_parse_capabilities to core
  ALSA: convert users to core bus_parse_capabilities
  ALSA - Ext hda: remove bus_parse_capabilities

 include/sound/hda_register.h           |  36 ++++++
 include/sound/hdaudio.h                |  13 +++
 include/sound/hdaudio_ext.h            |  12 --
 sound/hda/ext/hdac_ext_controller.c    |  91 ++-------------
 sound/hda/ext/hdac_ext_stream.c        |  46 ++++----
 sound/hda/hdac_controller.c            |  76 +++++++++++++
 sound/pci/hda/hda_controller.c         | 200 ++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_controller.h         |   3 +
 sound/pci/hda/hda_intel.c              |  16 +++
 sound/soc/intel/skylake/skl-messages.c |   4 +-
 sound/soc/intel/skylake/skl-pcm.c      |   8 +-
 sound/soc/intel/skylake/skl.c          |   6 +-
 12 files changed, 383 insertions(+), 128 deletions(-)

-- 
1.9.1
