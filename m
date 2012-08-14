From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] hda-emu: configure.ac: Allow relative
	paths in hdadir
Date: Tue, 14 Aug 2012 11:55:43 +0200
Message-ID: <1344938144-22240-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DC54F265E1E
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 11:26:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Previously, adding a path that was relative could fail because
the symlinks created were broken.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 configure.ac |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index 315e759..18118f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,6 +51,8 @@ AC_ARG_WITH(hdadir,
     [path where HD-audio kernel files are stored]),
   hdadir="$withval", hdadir="")
 
+hdadir="$( cd "$hdadir" && pwd )"
+
 if test -n "$hdadir"; then
 
 test -d "$hdadir" || \
-- 
1.7.9.5
