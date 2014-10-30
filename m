From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ALSA: doc: Add ASoC codes into API
	documentation
Date: Thu, 30 Oct 2014 16:06:15 +0100
Message-ID: <1414681581-4619-3-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C0609260613
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:23 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A3BCDADE0
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:23 +0000 (UTC)
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/alsa-driver-api.tmpl | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index 7bec270e2494..b2d2c3b74fb0 100644
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ b/Documentation/DocBook/alsa-driver-api.tmpl
@@ -104,13 +104,30 @@
 !Iinclude/sound/compress_driver.h
      </sect1>
   </chapter>
+  <chapter><title>ASoC</title>
+     <sect1><title>ASoC Core API</title>
+!Iinclude/sound/soc.h
+!Esound/soc/soc-core.c
+!Esound/soc/soc-cache.c
+!Esound/soc/soc-devres.c
+!Esound/soc/soc-io.c
+!Esound/soc/soc-pcm.c
+     </sect1>
+     <sect1><title>ASoC DAPM API</title>
+!Esound/soc/soc-dapm.c
+     </sect1>
+     <sect1><title>ASoC DMA Engine API</title>
+!Esound/soc/soc-generic-dmaengine-pcm.c
+     </sect1>
+  </chapter>
   <chapter><title>Miscellaneous Functions</title>
      <sect1><title>Hardware-Dependent Devices API</title>
 !Esound/core/hwdep.c
      </sect1>
      <sect1><title>Jack Abstraction Layer API</title>
-!Esound/core/jack.c
 !Iinclude/sound/jack.h
+!Esound/core/jack.c
+!Esound/soc/soc-jack.c
      </sect1>
      <sect1><title>ISA DMA Helpers</title>
 !Esound/core/isadma.c
-- 
2.1.2
