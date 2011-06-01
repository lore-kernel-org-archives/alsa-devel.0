From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 0/6] HDMI: Implement pcm-per-pin
Date: Wed,  1 Jun 2011 11:14:15 -0600
Message-ID: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 855FC103885
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:14:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, wfg@linux.intel.com
Cc: wni@nvidia.com, Stephen Warren <swarren@nvidia.com>, ndaga@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patchset implements a PCM-per-pin-widget model for all HDMI codecs that
use the generic codec support. For most existing codecs, there is 1 pin and
1 converter per codec, so this change should have no functional impact. For
some codecs (e.g. GeForce 520, Intel Ibex Peak) there are fewer converters
than pins, and the default routing is for all pins to be mux'd from a single
codec, so this patch allows:

a) Multiple PCMs to be used at once (1 per converter). Previously, only 1
   PCM was created due to the default muxing.

b) A direct mapping from PCM device to pin, and hence to ELD data and
   connected monitor. This should enable simpler/better decisions re: which
   audio formats are supported for that PCM, since only 1 ELD has to be
   considered (previously, I think the ELDs other than from the first pin
   were simply ignored)

The very first change in the series is actually somewhat unrelated, but I
noticed it while working on this, and I believe it's a correct change.

Stephen Warren (6):
  ALSA: hda: Gate ELD usage only by whether ELD is valid
  ALSA: hda: Allow multple SPDIF controls per codec
  ALSA: hda: Virtualize SPDIF out controls
  ALSA: hda: Separate generic and non-generic implementations
  ALSA: hda: hdmi_eld_update_pcm_info: update a stream in place
  ALSA: hda: HDMI: Support codecs with fewer cvts than pins

 sound/pci/hda/hda_codec.c      |  139 ++++++---
 sound/pci/hda/hda_codec.h      |   16 +-
 sound/pci/hda/hda_eld.c        |   46 ++--
 sound/pci/hda/hda_intel.c      |    5 +-
 sound/pci/hda/hda_local.h      |    8 +-
 sound/pci/hda/patch_analog.c   |    4 +-
 sound/pci/hda/patch_ca0110.c   |    3 +-
 sound/pci/hda/patch_cirrus.c   |    3 +-
 sound/pci/hda/patch_cmedia.c   |    4 +-
 sound/pci/hda/patch_conexant.c |    1 +
 sound/pci/hda/patch_hdmi.c     |  704 ++++++++++++++++++++++++----------------
 sound/pci/hda/patch_realtek.c  |    1 +
 sound/pci/hda/patch_sigmatel.c |    4 +-
 sound/pci/hda/patch_via.c      |   13 +-
 14 files changed, 594 insertions(+), 357 deletions(-)
