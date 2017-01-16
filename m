From: jeeja.kp@intel.com
Subject: [PATCH 00/30] ASoC: hdac_hdmi: Add support to enable
	MST audio
Date: Mon, 16 Jan 2017 23:27:27 +0530
Message-ID: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F02E92670FA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:46:53 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Display port 1.2 introduces new capability Multi-stream transport (MST)
which will allow multiple stream to route to single display port where
multiple monitors are connected. Multiple monitors will be connected by
a MST Hub or a monitor capable of daisy-chaining.

With MST support, a pin can support multiple ports and on each port a
monitor can be connected.

This patch series enables DP MST Audio by extending the current design
from pin to port.
o With MST, pin mux for CVT selection will be used to select CVT for
pin-port instead of pin. So create the pin mux accordingly.

o Pin is marked as MST capable when connect event reports pipe as valid.
if pipe is -1, then pin is not MST capable and default to port 0.
if pipe is valid, then pin is MST capable and port = pipe.

o For MST capable pin, select the device entry before configuring the pin
widget verbs controlling the sink device operations.

o Add support to handle multiple Port mapped to same converter by creating
as port list in pcm and report jack event based on the no of ports 
connected/disconnected .

o i915 acomp APIs are now used to read the ELD info and support is extended
for MST port as well.

o Configure port/pin/audio infoframe in widget event handlers for dynamic
routing when monitor is connected/disconnected instead of DAI ops. 

o Use set_tdm slot to set the stream tag instead of dai params and store it
in pcm context and use this in configuring the converter in widget event
handler.

o Use pin widget to represent the output to enable/disable path when a device
is connected/disconnected. Added API to create the pin widget and this will be
called by the machine driver after jack creation.

o Add channel map support for bxt machine.

o Move from snd_jack to ASOC jack framework, create the jack in machine driver.

o Create port pin widget to enable and disable the path dynamically when a jack
is connected/disconnected.

Note: This patch series has dependency on the series
"ASoC: Intel: Skylake: Driver updates"  

Jeeja KP (29):
  ASoC: hdac_hdmi: Register widget event handlers
  ASoC: Intel: Skylake: Use set_tdm_slot to set the dma channel
  ASoC: hdac_hdmi: Move channel info from pin to PCM structure
  ASoC: Intel: bxt: add channel map support in rt298 machine
  ASoC: Intel: bxt: add channel map support in bxt_da7219_max98357a    
    machine
  ASoC: hdac_hdmi: Begin to add support for DP Multi-stream audio
  ASoC: Intel: Skylake: Add route change to rt286 machine
  ASoC: Intel: Skylake: Add route change to nau88l25_max98357a machine
  ASoC: Intel: Skylake: Add route change to nau88l25_ssm4567 machine
  ASoC: Intel: bxt: Add route change to rt298 machine
  ASoC: Intel: bxt: Add route change to da7219_max98357a machine
  ASoC: hdac_hdmi: Add support to handle MST capable pin
  ASoC: hdac_hdmi: Add MST verb support
  ASoC: hdac_hdmi: Handle MST pin jack detection at boot/resume
  ASoc: hdac_hdmi: Configure pin verbs for MST
  ASoC: hdac_hdmi: Add support for multiple ports to a PCM
  ASoC: hdac_hdmi: Use ASoC jack instead of snd_jack
  ASoC: Intel: Skylake: Create ASoC jack for hdmi in rt286 machine
  ASoC: Intel: Skylake: Create ASoC jack for hdmi in    
    skl_nau88l25_max98357a machine
  ASoC: Intel: Skylake: Create ASoC jack for hdmi in
    skl_nau88l25_ssm4567     machine
  ASoC: Intel: bxt: Create ASoC jack for hdmi in bxt_rt298 machine
  ASoC: Intel: bxt: Create ASoC jack for hdmi in bxt_da7219_max98357    
    machine
  ASoC: hdac_hdmi: Add machine pin widget for each port
  ASoC: Intel: Skylake: Add jack port initialize in rt286 machine
  ASoC: Intel: Skylake: Add jack port initialize in
    skl_nau88l25_max98357a machine
  ASoC: Intel: Skylake: Add jack port initialize in skl_nau88l25_ssm4567
    machine
  ASoC: Intel: Skylake: Add jack port initialize in bxt_rt298 machine
  ASoC: Intel: Skylake: Add jack port initialize in bxt_da7219_max98357a
        machine
  ASoC: Intel: Skylake: Fix to delete DSP pipe after stopping pipe

Sandeep Tayal (1):
  ASoC: hdac_hdmi: use audio component framework to read ELD

 sound/soc/codecs/hdac_hdmi.c                    | 1331 ++++++++++++++---------
 sound/soc/codecs/hdac_hdmi.h                    |    5 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |   75 +-
 sound/soc/intel/boards/bxt_rt298.c              |   78 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |   34 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |   33 +-
 sound/soc/intel/boards/skl_rt286.c              |   30 +-
 sound/soc/intel/skylake/skl-messages.c          |    2 +-
 sound/soc/intel/skylake/skl-pcm.c               |   10 +-
 9 files changed, 1045 insertions(+), 553 deletions(-)

-- 
2.5.0
