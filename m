From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: DocBook: Add soc-ops.c and soc-compress.c
Date: Wed, 28 Oct 2015 12:38:35 +0100
Message-ID: <1446032315-9737-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 862F8261525
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 12:38:36 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B0FEACAB
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 11:38:53 +0000 (UTC)
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

These have been missing in the template file although they provide
good kernel doc comments.  Let's add them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/alsa-driver-api.tmpl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index e94a10bb4a9e..53f439dcc94b 100644
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ b/Documentation/DocBook/alsa-driver-api.tmpl
@@ -112,6 +112,8 @@
 !Esound/soc/soc-devres.c
 !Esound/soc/soc-io.c
 !Esound/soc/soc-pcm.c
+!Esound/soc/soc-ops.c
+!Esound/soc/soc-compress.c
      </sect1>
      <sect1><title>ASoC DAPM API</title>
 !Esound/soc/soc-dapm.c
-- 
2.6.2
