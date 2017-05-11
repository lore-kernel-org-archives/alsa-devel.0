From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] sound: Disable the build of OSS drivers
Date: Thu, 11 May 2017 22:58:27 +0200
Message-ID: <20170511205827.16446-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 48744266F35
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 22:58:42 +0200 (CEST)
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
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

OSS drivers are left as badly unmaintained, and now we're facing a
problem to clean up the hackish set_fs() usage in their codes.  Since
most of drivers have been covered by ALSA, and the others are dead old
and inactive, let's leave them RIP.

This patch is the first step: disable the build of OSS drivers.
We'll eventually drop the whole codes and clean up later.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

v1->v2: Smaller changes, as Linus and Randy suggested.
	The first dmasound Kconfig inclusion is still commented out since
	it's shorter/simpler in the end.

 sound/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index ee2e69a9ecd1..de23fc39cec8 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -54,7 +54,7 @@ config SOUND_OSS_CORE_PRECLAIM
 
 	  If unsure, say Y.
 
-source "sound/oss/dmasound/Kconfig"
+# source "sound/oss/dmasound/Kconfig"
 
 if !M68K && !UML
 
@@ -115,6 +115,7 @@ endif # SND
 menuconfig SOUND_PRIME
 	tristate "Open Sound System (DEPRECATED)"
 	select SOUND_OSS_CORE
+	depends on BROKEN
 	help
 	  Say 'Y' or 'M' to enable Open Sound System drivers.
 
-- 
2.12.2
