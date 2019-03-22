From: Alex Ivanov <gnidorah@ya.ru>
Subject: [PATCH] [-, JACK, plugin,
	1/1] configure: use /etc instead of /etc
Date: Fri, 22 Mar 2019 18:44:10 +0300
Message-ID: <20190322154410.10712-1-gnidorah@ya.ru>
References: <s5h1s2zb23j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward104o.mail.yandex.net (forward104o.mail.yandex.net
 [37.140.190.179])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 953BFF8078F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 16:44:16 +0100 (CET)
In-Reply-To: <s5h1s2zb23j.wl-tiwai@suse.de>
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

Hi, Takashi.

Sure. Here we go.

Signed-off-by: Alex Ivanov <gnidorah@ya.ru>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5b80585..b52923c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -237,7 +237,7 @@ AC_ARG_WITH(alsalconfdir,
 	[path where ALSA local add-on config files are stored]),
     alsalconfdir="$withval", alsalconfdir="")
 if test -z "$alsalconfdir"; then
-    alsalconfdir="/etc/alsa/conf.d"
+    alsalconfdir="$sysconfdir/alsa/conf.d"
 fi
 AC_DEFINE_UNQUOTED(ALSA_LCONF_DIR, "$alsalconfdir", [directory containing local ALSA add-on config files])
 ALSA_LCONF_DIR="$alsalconfdir"
-- 
2.19.2
