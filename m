From: jeeja.kp@intel.com
Subject: [PATCH v4 0/5] ASoC: hdmi: Preparatory work to support
	MST audio
Date: Mon,  6 Feb 2017 12:09:13 +0530
Message-ID: <1486363158-16496-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A9BF9266884
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 07:27:48 +0100 (CET)
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
o This changes require UCM conf modification, once this series is accepted,
I will post the UCM change.

o This series depends on DRM changes to enable MST and changes are already
merged in 4.10-rc1 branch.

Changes v2:
	Split the patchs to smaller series.

Changes v3:
	o rebased on latest branch 
	o Removed already merged patch.

Changes v4:
	o rebased on latest branch 
	o Removed already merged patch.

Jeeja KP (5):
  ASoC: hdac_hdmi: Begin to add support for DP Multi-stream audio
  ASoC: Intel: Skylake: Add route change to nau88l25_max98357a machine
  ASoC: Intel: Skylake: Add route change to nau88l25_ssm4567 machine
  ASoC: Intel: bxt: Add route change to rt298 machine
  ASoC: hdac_hdmi: Add support to handle MST capable pin

 sound/soc/codecs/hdac_hdmi.c                    | 416 +++++++++++++++---------
 sound/soc/intel/boards/bxt_rt298.c              |   6 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |   8 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |   9 +-
 4 files changed, 274 insertions(+), 165 deletions(-)

-- 
2.5.0
