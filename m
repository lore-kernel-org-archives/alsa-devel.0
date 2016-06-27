From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 00/11] ASoC: hdac: Add hdac generic driver
Date: Mon, 27 Jun 2016 09:17:53 +0530
Message-ID: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BB651261ADC
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:31 +0200 (CEST)
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

HDA devices generically can be modelled with DAPM in ASoC. This
series adds a framework in ASoC to model HDA devices. HDA widgets
are enumerated and one or multiple DAPM widget(s) are created.
Connection list is queried for each widget to identify the
connection between two endpoints and modelled using DAPM graph.

Set of event handlers are defined for each widget type. Based on
DAPM events required verbs are sent to program codec.

Finally a function is exported to query for the device endpoint
configuration to create machine controls.

Hardik T Shah (1):
  ASoC: Add dai_ops to set the stream tag.

Subhransu S. Prusty (10):
  ALSA: hdac: Add codec helper library
  ALSA: hda - Add macro to test pin widget's input capability
  ASoC: hdac: Add a generic hdac driver framework
  ASoC: hdac: Create DAPM model for HDA widgets
  ASoC: dapm: Create API to add a single route element
  ASoC: hdac: Build DAPM graph by querying through widget connection
    list
  ASoC: hdac: Register widget event handlers
  ALSA: hda - macro to get default config device of pin widgets
  ASoC: dapm: Export snd_soc_dapm_new_control
  ASoC: hdac: Export API to create machine controls

 include/sound/hdaudio.h         |    1 +
 include/sound/soc-dai.h         |   12 +
 include/sound/soc-dapm.h        |    5 +
 sound/hda/ext/Makefile          |    3 +-
 sound/hda/ext/hdac_codec.c      |  188 +++++
 sound/hda/ext/hdac_codec.h      |   52 ++
 sound/hda/local.h               |   13 +
 sound/soc/codecs/Kconfig        |    5 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/hdac_generic.c | 1561 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_generic.h |   31 +
 sound/soc/soc-core.c            |   35 +
 sound/soc/soc-dapm.c            |   22 +
 13 files changed, 1929 insertions(+), 1 deletion(-)
 create mode 100644 sound/hda/ext/hdac_codec.c
 create mode 100644 sound/hda/ext/hdac_codec.h
 create mode 100644 sound/soc/codecs/hdac_generic.c
 create mode 100644 sound/soc/codecs/hdac_generic.h

-- 
1.9.1
