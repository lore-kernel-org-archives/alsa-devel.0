From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 0/9] ASoC: hdac_hdmi: Add multichannel
	support
Date: Tue, 12 Apr 2016 15:26:08 +0530
Message-ID: <1460454977-30057-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 169A426512B
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 11:57:10 +0200 (CEST)
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

This series parses ELD to identify multichannel capability of the
sync, and uses HDA framework to programs codec's channel map
registers.

Channel map controls are registered in patch 8, with which user
can specify a specific channel order. chmap controls are
registered inside jack_init callback. As PCMs need to be
registered before registering chmap controls, jack_init call in
the machine driver is moved to late_probe instead of init
callback.

Skylake driver is modified and buffer size calculation is fixed
for multichannel support.

Please note, patch 2 adds a small macro to read channel counts
from cap bits in HDA headers. This needs Takashi's ack, so that
it can be merged through ASoC.

Patch 7 has dependency on commit#44fde3b ("ALSA: hda - Update
chmap tlv to report sink's capability) which is merged in
Takashi's tree.

As Takashi suggested Mark may pull Takashi's for-next branch
before applying this or may send a pull request, so that Takashi
pull's Mark's tree before applying these with Mark's ack.

Mark, please check how you want this to be merged.

Changes in v2:
	* Dropped drm change and accommodate the change in driver
	* Fix one auto build test error

Subhransu S. Prusty (9):
  ASoC: hdac_hdmi: parse eld for channel map capability
  ALSA: hda - add helper to get channels from cap bits
  ASoC: hdac_hdmi: Add multichannel support
  ASoC: skl_rt286: Fix to support hdmi channel map support
  ASoC: Intel: boards: Update skl_nau88l25_max98357a driver to support
    chmap
  ASoC: Intel: boards: Update skl_nau88l25_ssm4567 driver to support
    chmap
  ASoC: hdac_hdmi: Register chmap controls and ops
  ASoC: Intel: Skylake: Add multichannel support for HDMI
  ASoC: Intel: Skylake: Update channel map based on runtime params

 sound/hda/local.h                               |  10 ++
 sound/soc/codecs/hdac_hdmi.c                    | 165 ++++++++++++++++++++++--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |  74 ++++++++++-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |  73 ++++++++++-
 sound/soc/intel/boards/skl_rt286.c              |  48 ++++++-
 sound/soc/intel/skylake/skl-pcm.c               |  14 +-
 sound/soc/intel/skylake/skl-topology.c          |  21 ++-
 7 files changed, 381 insertions(+), 24 deletions(-)

-- 
1.9.1
