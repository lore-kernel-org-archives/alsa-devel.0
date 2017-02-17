From: jeeja.kp@intel.com
Subject: [PATCH v2] ASoC: hdac_hdmi: Enable MST audio
Date: Fri, 17 Feb 2017 14:50:29 +0530
Message-ID: <1487323230-17170-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 42FA52668B2
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 10:08:50 +0100 (CET)
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

Change v2:
	- Fixed the SOB missing in the patch.
	- Removed already applied patches.

Jeeja KP (1):
  ASoC: Intel: bxt: Add jack port initialize in bxt_rt298 machine

 sound/soc/intel/boards/bxt_rt298.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.5.0
