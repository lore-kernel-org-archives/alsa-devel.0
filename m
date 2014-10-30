From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/8] ALSA: doc: Fix missing "I" for kerneldoc
	inclusion
Date: Thu, 30 Oct 2014 16:06:21 +0100
Message-ID: <1414681581-4619-9-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA6F2652E9
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:24 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34290ACF4
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:24 +0000 (UTC)
In-Reply-To: <1414681581-4619-1-git-send-email-tiwai@suse.de>
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

Fixes: 90446d0746c3 ('ALSA: doc: Add missing headers and compress stuff to alsa-driver-api.tmpl')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/alsa-driver-api.tmpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index b2d2c3b74fb0..71f9246127ec 100644
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ b/Documentation/DocBook/alsa-driver-api.tmpl
@@ -57,7 +57,7 @@
 !Esound/core/pcm.c
 !Esound/core/pcm_lib.c
 !Esound/core/pcm_native.c
-!include/sound/pcm.h
+!Iinclude/sound/pcm.h
      </sect1>
      <sect1><title>PCM Format Helpers</title>
 !Esound/core/pcm_misc.c
-- 
2.1.2
