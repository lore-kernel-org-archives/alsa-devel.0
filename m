From: jeeja.kp@intel.com
Subject: [RFC 00/16] ASoC: hdac_hdmi: Add Support to Enable MST
	Audio
Date: Tue, 20 Sep 2016 19:16:04 +0530
Message-ID: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id CB9992666F1
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:37:42 +0200 (CEST)
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
1. With MST, Pin mux for CVT selection will be used to select CVT for
   Pin-port instead of Pin. So create the pin muxes accordingly.
2. Pin is marked as MST capable when connect event reports pipe as valid.
   if pipe is -1, then pin is not MST capable and default to port 0.
   if pipe is valid, then pin is MST capable and port = pipe.
3. For MST capable pin, select the device entry before configuring the pin
   widget verbs controlling the sink device operations.
4. Add support to handle multiple Port mapped to same converter by enabling
   all the ports and configuring the port when stream is prepared.
5. i915 acomp APIs are now used to read the ELD info and support is
   extended for MST port as well

Notes:
1. When Mutiple ports are mapped to same PCM, currenlty stream constrains
   will applied based on first port mapped. 

Jeeja KP (15):
  ASoC: hdac_hdmi: Begin to add support for DP Multi-stream Audio
  ASoC: Intel: Skylake: Add route change to rt286 machine
  ASoC: Intel: Skylake: Add route change to nau88l25_max98357a machine
  ASoC: Intel: Skylake: Add route change to nau88l25_ssm4567 machine
  ASoC: Intel: Skylake: Add route change to rt298 machine
  ASoC: Intel: Skylake: Add route change to da7219_max98357a machine
  ASoC: hdac_hdmi: Add support to handle MST capable pin
  ASoC: hdac_hdmi: Add MST verb support
  ASoc: hdac_hdmi: Configure pin verbs for MST
  ASoC: hdac_hdmi: Add support to handle Multiple Port to same PCM
  ASoC: Intel: Skylake: To support MST, add HDMI routes rt286 machine
  ASoC: Intel: Skylake: To support MST, add HDMI routes nau_max machine
  ASoC: Intel: Skylake: To support MST, add HDMI routes nau_ssm machine
  ASoC: Intel: Skylake: To support MST, add HDMI routes rt298 machine
  ASoC: Intel: Skylake: To support MST, add HDMI routes da7219_max
    machine

Sandeep Tayal (1):
  ASoC: hdac_hdmi: use audio component framework to read ELD

 sound/soc/codecs/hdac_hdmi.c                    | 919 ++++++++++++++----------
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |  10 +-
 sound/soc/intel/boards/bxt_rt298.c              |  11 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |  12 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |  13 +-
 sound/soc/intel/boards/skl_rt286.c              |  10 +-
 6 files changed, 597 insertions(+), 378 deletions(-)

-- 
2.5.0
