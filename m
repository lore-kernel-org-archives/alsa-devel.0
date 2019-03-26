From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC alsa-lib] Drop -I$includedir/alsa from
	alsa.pc
Date: Tue, 26 Mar 2019 15:15:10 +0100
Message-ID: <20190326141510.10120-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F835F896FF
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:15:12 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0179DAD9D
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 14:15:12 +0000 (UTC)
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

We used to put the additional include path $includedir/alsa in
pkgconfig just because some applications have included asoundlib.h
like
  #include <asoundlib.h>
although the canonical form should be
  #include <alsa/asoundlib.h>

However, adding this include path is significantly dangerous due to
possible conflicts of file names like version.h.  It's already the
reason to discourage people using alsa.pc for the packages.

In this patch, the additional include path from alsa.pc is dropped
finally.  At the same time, as a rescue plan for the programs
including via <asoundlib.h>, a stub header file is provided in
include/sound/asoundlib.h.  It just includes alsa/asoundlib.h with a
warning to suggest for replacing with alsa/asoundlib.h.
Actually this is the same file as we install into sys/asoundlib.h, so
the whole changes are very minimal here.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/Makefile.am | 1 +
 utils/alsa.pc.in    | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index 67f32e36c911..fffc8a62e88b 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -96,3 +96,4 @@ AM_CPPFLAGS=-I$(top_srcdir)/include
 install-data-hook:
 	test -d $(DESTDIR)$(sysincludedir) || mkdir -p $(DESTDIR)$(sysincludedir)
 	$(INSTALL_DATA) $(srcdir)/sys.h $(DESTDIR)$(sysincludedir)/asoundlib.h
+	$(INSTALL_DATA) $(srcdir)/sys.h $(DESTDIR)/asoundlib.h
diff --git a/utils/alsa.pc.in b/utils/alsa.pc.in
index 8de9859f42db..444f66d85a34 100644
--- a/utils/alsa.pc.in
+++ b/utils/alsa.pc.in
@@ -9,6 +9,4 @@ Version: @VERSION@
 Requires: 
 Libs: -L${libdir} -lasound
 Libs.private: @ALSA_DEPLIBS@
-# -I${includedir}/alsa below is just for backward compatibility
-# (it was set so mistakely in the older version)
-Cflags: -I${includedir} -I${includedir}/alsa
+Cflags: -I${includedir}
-- 
2.16.4
