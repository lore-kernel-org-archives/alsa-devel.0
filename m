From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v05 63/72] include/uapi/sound/Kbuild: remove
	sound/asoc.h from userspace
Date: Mon, 22 Aug 2016 20:33:20 +0200
Message-ID: <1471890809-4383-64-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kapsi.fi (mail.kapsi.fi [217.30.184.167])
 by alsa0.perex.cz (Postfix) with ESMTP id B05F92669C5
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 21:26:32 +0200 (CEST)
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Based on git commit messages and the #error macro messages it should not be
used in userspace. Fixes userspace compile errors:

sound/asoc.h:21:2: error: #error This API is an early revision and not enabled
 in the current
 #error This API is an early revision and not enabled in the current
  ^~~~~
sound/asoc.h:22:2: error: #error kernel release, it will be enabled in a futur
e kernel version
 #error kernel release, it will be enabled in a future kernel version
  ^~~~~
sound/asoc.h:23:2: error: #error with incompatible changes to what is here.
 #error with incompatible changes to what is here.
  ^~~~~

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/sound/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/sound/Kbuild b/include/uapi/sound/Kbuild
index 691984c..6d8b203 100644
--- a/include/uapi/sound/Kbuild
+++ b/include/uapi/sound/Kbuild
@@ -1,6 +1,5 @@
 # UAPI Header export list
 header-y += asequencer.h
-header-y += asoc.h
 header-y += asound.h
 header-y += asound_fm.h
 header-y += compress_offload.h
-- 
2.8.1
