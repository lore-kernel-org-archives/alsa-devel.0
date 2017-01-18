From: jeeja.kp@intel.com
Subject: [PATCH v2 00/13] ASoC: hdmi: Preparatory work to
	support MST audio
Date: Wed, 18 Jan 2017 21:34:40 +0530
Message-ID: <1484755493-30595-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DB66266636
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 16:53:50 +0100 (CET)
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

This is preparatory patch series to enable DP MST Audio by extending the
current design from pin to port.
o i915 acomp APIs are now used to read the ELD info and support is extended
for MST port as well.

o Configure port/pin/audio infoframe in widget event handlers for dynamic
routing when monitor is connected/disconnected instead of DAI ops. 

o Use set_tdm slot to set the stream tag instead of dai params and store it
in pcm context and use this in configuring the converter in widget event
handler.

o With MST, pin mux for CVT selection will be used to select CVT for
pin-port instead of pin. So create the pin mux accordingly and update the
route in skl/bxt machines.

o add channel map support in bxtn machines.

Note:
o This patch series has dependency on the series
"ASoC: Intel: Skylake: Driver updates".

o This changes require UCM conf modicfication, once this series is accepted,
I will post the UCM change.

Changes v2:
	Split the patchs to smaller series.

Jeeja KP (12):
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

Sandeep Tayal (1):
  ASoC: hdac_hdmi: use audio component framework to read ELD

 sound/soc/codecs/hdac_hdmi.c                    | 961 ++++++++++++------------
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |  55 +-
 sound/soc/intel/boards/bxt_rt298.c              |  58 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |   8 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |   9 +-
 sound/soc/intel/boards/skl_rt286.c              |   6 +-
 sound/soc/intel/skylake/skl-pcm.c               |  10 +-
 7 files changed, 610 insertions(+), 497 deletions(-)

-- 
2.5.0
