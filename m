From: jeeja.kp@intel.com
Subject: [PATCH 00/16] ASoC: hdac_hdmi: Enable MST audio
Date: Tue,  7 Feb 2017 19:09:44 +0530
Message-ID: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6801326686E
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:28:38 +0100 (CET)
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

With the patch series "ASoC: hdmi: Preparatory work to support MST audio",
the design is extended from pin to port mapping to handle MST usecases.

A pin is MST capable if pipe is valid value (i.e. not -1) in the notify
callback. If pipe = -1, default port is 0 else port = pipe. A MST capable
pin widget is programmed by first sending a verb to select the device/port
and then the actual verb is sent to program the widget.

This patch series enables MST Audio by configuring MST capable pins and
extended the jack handling to report event for ports. Now the jack events
are based on port connect/disconnect. The design is also extended to support
mapping of multiple port to a single converter.

Now with the introduction of multiple ports with a single pin, a pin widget
is created to enable/disable path based on device connection. Required
machine driver changes are done to handle this change.

Also use the ASoC jack instead of snd_jack framework to creates jacks in
the machine driver.

Note: This patch series has dependency on the series
"ASoC: hdmi: Preparatory work to support MST audio"  

Jeeja KP (16):
  ASoC: hdac_hdmi: Add MST verb support
  ASoC: hdac_hdmi: Handle MST pin jack detection at boot/resume
  ASoc: hdac_hdmi: Configure pin verbs for MST
  ASoC: hdac_hdmi: Add support for multiple ports to a PCM
  ASoC: hdac_hdmi: Use ASoC jack instead of snd_jack
  ASoC: Intel: Skylake: Create ASoC jack for hdmi in rt286 machine
  ASoC: Intel: Skylake: Create ASoC jack for hdmi in    
    skl_nau88l25_max98357a machine
  ASoC: Intel: Skylake: Create ASoC jack for hdmi in nau88l25_ssm4567
    machine
  ASoC: Intel: bxt: Create ASoC jack for hdmi in bxt_rt298 machine
  ASoC: Intel: bxt: Create ASoC jack for hdmi in bxt_da7219_max98357    
    machine
  ASoC: hdac_hdmi: Add machine pin widget for each port
  ASoC: Intel: Skylake: Add jack port initialize in rt286 machine
  ASoC: Intel: Skylake: Add jack port initialize in nau88l25_max98357a
    machine
  ASoC: Intel: Skylake: Add jack port initialize in nau88l25_ssm4567
    machine
  ASoC: Intel: bxt: Add jack port initialize in bxt_rt298 machine
  ASoC: Intel: bxt: Add jack port initialize in da7219_max98357a machine

 sound/soc/codecs/hdac_hdmi.c                    | 438 +++++++++++++++++++-----
 sound/soc/codecs/hdac_hdmi.h                    |   5 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |  26 +-
 sound/soc/intel/boards/bxt_rt298.c              |  26 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |  30 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |  30 +-
 sound/soc/intel/boards/skl_rt286.c              |  30 +-
 7 files changed, 482 insertions(+), 103 deletions(-)

-- 
2.5.0
