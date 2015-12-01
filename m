From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 00/15] ASoC: hdac_hdmi: Add DP & notification
	support
Date: Tue,  1 Dec 2015 23:12:29 +0530
Message-ID: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 00A03261ADA
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:11:48 +0100 (CET)
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
Cc: tiwai@suse.de, David Airlie <airlied@linux.ie>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch series adds DP audio and hotplug notification
support.

On Skylake two DP ports are available and to enable DP on both
ports all pins need to be enabled.

There is a special vendor widget which need to be programmed to
enable all pins and converters. This series adds hotplug
notification, read/set constraint based on ELD, enable all
pin/cvts, DP1.2, programs the audio infoframe for DP. There is
a one to one mapping between converter and stream, so the dais
are created based on the no of streams supported on hdmi codec.
Even though cvts can be mapped dynamically to the streams,
currently it is statically mapped as simultaneous playback on
both DP and HDMI is not supported as of now.

Pin muxes and controls are created dynamically to map converter
to pin widget. So at run time specific pin is mapped to the dai
based on the control selected (based on the display type DP/HDMI
connected).

Finally the DP audio infoframe programming is added to support
the DP feature. 

Also with hotplug notification support, ELD is read and
capabilities are set for rate, formats and channels. drm_eld
sound/core framework is updated to limit the formats based on
ELD.

There are few fixes one fixing the static checker warning and
other one not to fail if no connection list is found for a pin
widget.


Pls note, the 12th patch is adding a small macro for getting
connection type in drm header, we have CCed drm folks on that and
this one. Pls ack so that we can have this series merged thru
sound trees

Jeeja KP (1):
  ASoC: hdac_hdmi: Add codec suspend/resume handler

Ramesh Babu (1):
  ASoC: hdac_hdmi: Keep display active while enumerating codec

Subhransu S. Prusty (13):
  ASoC: hdac_hdmi: Fix to check num nodes correctly
  ASoC: hdac_hdmi: Fix to warn instead of err for no connected nids
  ASoC: hdac_hdmi - Use list to add pins and converters
  ALSA: hda - Add helper to read eld data
  ASoC: hdac_hdmi: Add hotplug notification and read eld
  ALSA: pcm: Add DRM helper to set constraint for format
  ASoC: hdac_hdmi: Apply constraints based on ELD
  ASoC: hdac_hdmi: Enable DP1.2 and all converters/pins
  ASoC: hdac_hdmi - create dais based on number of streams
  ASoC: hdac_hdmi: Create widget/route based on nodes enumerated
  ASoC: hdac_hdmi: Assign pin for stream based on dapm connection
  drm/edid: Add API to help find connection type
  ASoC: hdac_hdmi: Add infoframe support for dp audio

 include/drm/drm_edid.h       |  10 +
 include/sound/hdaudio.h      |   3 +
 sound/core/pcm_drm_eld.c     |  42 +-
 sound/hda/Makefile           |   2 +-
 sound/hda/hdac_eld.c         |  95 +++++
 sound/soc/codecs/Kconfig     |   1 +
 sound/soc/codecs/hdac_hdmi.c | 908 ++++++++++++++++++++++++++++++++++++-------
 7 files changed, 908 insertions(+), 153 deletions(-)
 create mode 100644 sound/hda/hdac_eld.c

-- 
1.9.1
