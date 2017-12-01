From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 15/15] MAINTAINERS: Add SoundWire entry
Date: Fri,  1 Dec 2017 15:26:17 +0530
Message-ID: <1512122177-2889-16-git-send-email-vinod.koul@intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Add the SoundWire subsystem maintainer entry with details and
Sanyog and me as maintainers.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..351fd3d87153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12695,6 +12695,16 @@ F:	Documentation/sound/alsa/soc/
 F:	sound/soc/
 F:	include/sound/soc*
 
+SOUNDWIRE SUBSYSTEM
+M:	Vinod Koul <vinod.koul@intel.com>
+M:	Sanyog Kale <sanyog.r.kale@intel.com>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
+L:	linux-kernel@vger.kernel.org
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
