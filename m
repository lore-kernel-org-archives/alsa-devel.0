From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: doc: Include uapi/sound/compress_*.h,
	too
Date: Wed, 29 Oct 2014 08:26:09 +0100
Message-ID: <1414567569-11722-4-git-send-email-tiwai@suse.de>
References: <1414567569-11722-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A233E2604BA
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 08:26:14 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1BC37ADAC
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:26:14 +0000 (UTC)
In-Reply-To: <1414567569-11722-1-git-send-email-tiwai@suse.de>
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
 Documentation/DocBook/alsa-driver-api.tmpl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index 13f8b241f042..7bec270e2494 100644
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ b/Documentation/DocBook/alsa-driver-api.tmpl
@@ -99,6 +99,8 @@
   <chapter><title>Compress Offload</title>
      <sect1><title>Compress Offload API</title>
 !Esound/core/compress_offload.c
+!Iinclude/uapi/sound/compress_offload.h
+!Iinclude/uapi/sound/compress_params.h
 !Iinclude/sound/compress_driver.h
      </sect1>
   </chapter>
-- 
2.1.2
