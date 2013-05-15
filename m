From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 1/3] Link arcam-av module against libpthread.
Date: Wed, 15 May 2013 19:11:46 +0200
Message-ID: <1368637908-29042-2-git-send-email-jordi@debian.org>
References: <1368637908-29042-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC5B2616DB
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:12:06 +0200 (CEST)
In-Reply-To: <1368637908-29042-1-git-send-email-jordi@debian.org>
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
Cc: Steve Langasek <steve.langasek@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Steve Langasek <steve.langasek@canonical.com>

The arcam-av module uses libpthread, so it should pass -pthread explicitly
when building in order to avoid leaving any undefined symbols or missing
symbol versioning info.

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 arcam-av/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arcam-av/Makefile.am b/arcam-av/Makefile.am
index 5c7855f..eeb2e90 100644
--- a/arcam-av/Makefile.am
+++ b/arcam-av/Makefile.am
@@ -3,7 +3,7 @@ asound_module_ctl_arcam_av_LTLIBRARIES = libasound_module_ctl_arcam_av.la
 asound_module_ctl_arcam_avdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined
+AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined -pthread
 
 libasound_module_ctl_arcam_av_la_SOURCES = ctl_arcam_av.c arcam_av.c arcam_av.h
 libasound_module_ctl_arcam_av_la_LIBADD = @ALSA_LIBS@
-- 
1.7.10.4
