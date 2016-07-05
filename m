From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC alsa-lib 3/5] Add pcm-multi-thread to
	.gitignore
Date: Tue,  5 Jul 2016 17:20:22 +0200
Message-ID: <20160705152024.20152-4-tiwai@suse.de>
References: <20160705152024.20152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 575B0260851
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 17:20:28 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 95742AD23
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 15:20:27 +0000 (UTC)
In-Reply-To: <20160705152024.20152-1-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index f46157290d70..098de14dc332 100644
--- a/.gitignore
+++ b/.gitignore
@@ -58,6 +58,7 @@ test/oldapi
 test/chmap
 test/pcm
 test/pcm_min
+test/pcm-multi-thread
 test/playmidi1
 test/queue_timer
 test/rawmidi
-- 
2.9.0
