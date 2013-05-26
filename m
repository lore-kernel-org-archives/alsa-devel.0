From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: [PATCH] alsactl init: ca0106 file was omitted
Date: Sun, 26 May 2013 15:54:44 -0700
Message-ID: <1369608885-3654-1-git-send-email-gabrbedd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E98EB2619E7
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 00:54:59 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id u11so5979438pdi.36
 for <alsa-devel@alsa-project.org>; Sun, 26 May 2013 15:54:58 -0700 (PDT)
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
Cc: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

The file alsactl/init/00main includes the line:

CARDINFO{driver}=="CA0106", INCLUDE="ca0106", GOTO="init_end"

However, the file alsactl/init/ca0106 is not making it into the
release tarballs (nor to user installations).

This patch adds the ca0106 file to the build.

Signed-off-by: Gabriel M. Beddingfield <gabrbedd@gmail.com>
---
CAVEAT EMPTOR: I found this issue while helping someone in
the #alsa channel.  I have no way to test this patch.

 alsactl/init/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alsactl/init/Makefile.am b/alsactl/init/Makefile.am
index 9e2b83d..64dac41 100644
--- a/alsactl/init/Makefile.am
+++ b/alsactl/init/Makefile.am
@@ -1,7 +1,7 @@
 
 init_files = \
 	00main default help info test \
-	hda
+	hda ca0106
 EXTRA_DIST = $(init_files)
 alsainitdir = $(datadir)/alsa/init
 alsainit_DATA = $(init_files)
-- 
1.7.9.5
