From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v6 14/14] MAINTAINERS: Add SoundWire entry
Date: Thu, 14 Dec 2017 11:19:45 +0530
Message-ID: <1513230585-13882-15-git-send-email-vinod.koul@intel.com>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Add the SoundWire subsystem maintainer entry with details and
Sanyog and me as maintainers.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
Acked-By: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..a8621408618f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12695,6 +12695,15 @@ F:	Documentation/sound/alsa/soc/
 F:	sound/soc/
 F:	include/sound/soc*
 
+SOUNDWIRE SUBSYSTEM
+M:	Vinod Koul <vinod.koul@intel.com>
+M:	Sanyog Kale <sanyog.r.kale@intel.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/driver-api/soundwire/
+F:	drivers/soundwire/
+F:	include/linux/soundwire/
+
 SP2 MEDIA DRIVER
 M:	Olli Salonen <olli.salonen@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.7.4
