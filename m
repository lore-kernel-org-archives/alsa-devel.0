From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-plugins] configure: Fix unexpanded
	ALSA_DATA_DIR
Date: Wed, 27 Mar 2019 12:42:04 +0100
Message-ID: <20190327114204.26304-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9A6FF8071D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 12:42:07 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 91EA1AEF5
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 11:42:06 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When no --with-alsadatadir is given, configure scripts takes
$datadir/alsa as the default location, while it's expanded to
$prefix/data/alsa.  Although ALSA_DATA_DIR is set via
AC_DEFINE_UNQUOTED(), this expands only $alsadatadir itself and not
about the $prefix in the content.  For resolving this, we need to do
eval twice.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 1be4a70c803c..5b131e704c2f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -211,7 +211,7 @@ if test -z "$alsadatadir"; then
     eval dir="$datadir"
     case "$dir" in
     /*) ;;
-    *) dir="$dir"
+    *) eval dir="$dir"
     esac
     alsadatadir="$dir/alsa"
 fi
-- 
2.16.4
