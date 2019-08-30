From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] MAINTAINERS: update entry of firewire audio drivers
Date: Fri, 30 Aug 2019 22:24:46 +0900
Message-ID: <20190830132446.5154-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This commit adds myself as one of maintainers for firewire audio
drivers and IEC 61883-1/6 packet streaming engine. I call them ALSA
firewire stack as a whole.

6 years ago I joined in development for this category of drivers with
heavy reverse-engineering tasks and over 100 models are now available
from ALSA applications. IEEE 1394 bus itself and units on the bus are
enough legacy but the development still continues.

I have a plan to add drastic enhancement in kernel v5.5 and v5.6 period.
This commit adds myself into MAINTAINERS so that developers and users
can easily find active developer to post their issues, especially for
regression.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24e29b2e53c9..8929a2ec75f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6264,8 +6264,9 @@ S:	Maintained
 F:	drivers/hwmon/f75375s.c
 F:	include/linux/f75375s.h
 
-FIREWIRE AUDIO DRIVERS
+FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET STREAMING ENGINE
 M:	Clemens Ladisch <clemens@ladisch.de>
++M:	Takashi Sakamoto <o-takashi@sakamocchi.jp>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
-- 
2.20.1
