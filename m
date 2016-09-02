From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 00/11] ASoC: hdac: Add hdac generic driver
Date: Fri,  2 Sep 2016 16:34:49 +0530
Message-ID: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4009F267790
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:10:40 +0200 (CEST)
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

HDA devices generically can be modelled with DAPM in ASoC.

We would like to create a framework for the HDA devices in ASoC.
This will follow HDA standard. This will be registered as generic
"virtual" class device (Not implemented in this series).  If
there is no match found for vendor id and device id, then the
class driver will be loaded.  For vendor specific devices, vendor
quirks will be loaded based on the match.  Additional widgets,
controls and route will be created in a vendor specific way
through vendor ops.

This series adds a framework in ASoC to model HDA codecs. HDA
widgets are enumerated and one or multiple DAPM widget(s) are
created. Connection list is queried for each widget to identify
the connection between two endpoints and modelled using DAPM
graph.

Set of event handlers are defined for each widget type. Based on
DAPM events required verbs are sent to program codec.

Finally a function is exported to query for the device endpoint
configuration to create machine controls.

Features yet to be added:
	- Optional features of widgets will be added using
	  additional dapm widgets or controls
	- Pin retasking will be done by adding all possible dapm
	  route map
	- Class driver to load the generic driver if no match found
	- Jack detection

changes in v2:
	- Addressed review comment from Takashi
	- Moved the widget_list to hdac_ext_device
	- helper to fill the widget list is now called from
	  hdac_ext_bus_device_init instead of driver probe
	- Fixed a NULL pointer dereferencing issue
	- Reorder patch to fix 'auto build test error'
	- Playback with hs/spk and amic capture now working for rt286
	- And some more cleanup and code refactoring to avoid long function
	  definition

Subhransu S. Prusty (11):
  ALSA: hdac: Add codec helper library
  ALSA: hda - Add macro to test pin widget's input capability
  ASoC: hdac: Add a generic hdac driver framework
  ALSA: hdac: Move 'to_hda_ext_device' helper to core
  ASoC: hdac: Create DAPM model for HDA widgets
  ASoC: hdac: Build DAPM graph by querying through widget connection
    list
  ASoC: hdac: Register widget event handlers
  ALSA: hda - macro to get default config device of pin widgets
  ASoC: hdac: Export API to create machine controls
  ALSA: hdac: Implement a match function
  ASoC: hdac: Add coefficient init callback for RT286

 include/sound/hdaudio_ext.h     |   40 +
 sound/hda/ext/Makefile          |    3 +-
 sound/hda/ext/hdac_ext_bus.c    |   24 +
 sound/hda/ext/hdac_ext_codec.c  |  156 ++++
 sound/hda/ext/hdac_ext_codec.h  |   26 +
 sound/hda/local.h               |   13 +
 sound/soc/codecs/Kconfig        |    5 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/hdac_generic.c | 1743 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_generic.h |   36 +
 sound/soc/codecs/hdac_hdmi.c    |    8 +-
 11 files changed, 2048 insertions(+), 8 deletions(-)
 create mode 100644 sound/hda/ext/hdac_ext_codec.c
 create mode 100644 sound/hda/ext/hdac_ext_codec.h
 create mode 100644 sound/soc/codecs/hdac_generic.c
 create mode 100644 sound/soc/codecs/hdac_generic.h

-- 
1.9.1
