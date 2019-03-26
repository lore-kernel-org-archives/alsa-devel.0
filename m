From: Alex Ivanov <gnidorah@ya.ru>
Subject: [RESEND] [-, JACK, plugin,
	1/1] configure: use /etc instead of /etc
Date: Tue, 26 Mar 2019 20:10:38 +0300
Message-ID: <20190326171038.20679-1-gnidorah@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward106o.mail.yandex.net (forward106o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::609])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 419E4F801D9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 18:10:43 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Could you please test this change again? I need it for my maintainer work.
Thank you!



Use $sysconfdir as prefix for ALSA_LCONF_DIR by default. Otherwise install
fails on non-FHS distros.

Signed-off-by: Alex Ivanov <gnidorah@ya.ru>
---
 configure.ac | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5b80585..1be4a70 100644
--- a/configure.ac
+++ b/configure.ac
@@ -237,7 +237,12 @@ AC_ARG_WITH(alsalconfdir,
 	[path where ALSA local add-on config files are stored]),
     alsalconfdir="$withval", alsalconfdir="")
 if test -z "$alsalconfdir"; then
-    alsalconfdir="/etc/alsa/conf.d"
+    eval dir="$sysconfdir"
+    case "$dir" in
+    /*) ;;
+    *) dir="$dir"
+    esac
+    alsalconfdir="$dir/alsa/conf.d"
 fi
 AC_DEFINE_UNQUOTED(ALSA_LCONF_DIR, "$alsalconfdir", [directory containing local ALSA add-on config files])
 ALSA_LCONF_DIR="$alsalconfdir"
-- 
2.19.2
