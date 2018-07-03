From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] configure: Require alsa-lib 1.1.6 and newer
Date: Tue,  3 Jul 2018 17:37:46 +0200
Message-ID: <20180703153746.31250-2-tiwai@suse.de>
References: <20180703153746.31250-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 13BB026779F
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:37:49 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BEA6DB06A
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 15:37:49 +0000 (UTC)
In-Reply-To: <20180703153746.31250-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

JACK plugin requires the recently added API function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f49bb6bcd9af..3e2d233aa5a2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -16,7 +16,7 @@ AC_HEADER_STDC
 
 CC_NOUNDEFINED
 
-PKG_CHECK_MODULES(ALSA, alsa >= 1.0.11)
+PKG_CHECK_MODULES(ALSA, alsa >= 1.1.6)
 AC_CHECK_LIB(asound, snd_pcm_ioplug_create,,
 	     AC_ERROR([*** libasound has no external plugin SDK]), -ldl)
 
-- 
2.18.0
