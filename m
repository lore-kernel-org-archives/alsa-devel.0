From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: doc: Add missing headers and
	compress stuff to alsa-driver-api.tmpl
Date: Tue, 28 Oct 2014 15:45:44 +0100
Message-ID: <1414507545-13362-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D514B260309
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 15:45:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9B317AB43
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 14:45:46 +0000 (UTC)
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

Some header files have kereldoc comments but are not referred
properly.  Let's add them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/alsa-driver-api.tmpl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index 0230a96f0564..13f8b241f042 100644
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ b/Documentation/DocBook/alsa-driver-api.tmpl
@@ -57,6 +57,7 @@
 !Esound/core/pcm.c
 !Esound/core/pcm_lib.c
 !Esound/core/pcm_native.c
+!include/sound/pcm.h
      </sect1>
      <sect1><title>PCM Format Helpers</title>
 !Esound/core/pcm_misc.c
@@ -64,6 +65,10 @@
      <sect1><title>PCM Memory Management</title>
 !Esound/core/pcm_memory.c
      </sect1>
+     <sect1><title>PCM DMA Engine API</title>
+!Esound/core/pcm_dmaengine.c
+!Iinclude/sound/dmaengine_pcm.h
+     </sect1>
   </chapter>
   <chapter><title>Control/Mixer API</title>
      <sect1><title>General Control Interface</title>
@@ -91,12 +96,19 @@
 !Esound/core/info.c
      </sect1>
   </chapter>
+  <chapter><title>Compress Offload</title>
+     <sect1><title>Compress Offload API</title>
+!Esound/core/compress_offload.c
+!Iinclude/sound/compress_driver.h
+     </sect1>
+  </chapter>
   <chapter><title>Miscellaneous Functions</title>
      <sect1><title>Hardware-Dependent Devices API</title>
 !Esound/core/hwdep.c
      </sect1>
      <sect1><title>Jack Abstraction Layer API</title>
 !Esound/core/jack.c
+!Iinclude/sound/jack.h
      </sect1>
      <sect1><title>ISA DMA Helpers</title>
 !Esound/core/isadma.c
-- 
2.1.2
