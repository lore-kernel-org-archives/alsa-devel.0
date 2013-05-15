From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 2/8] Add a distclean target to example Makefile.
Date: Wed, 15 May 2013 19:19:05 +0200
Message-ID: <1368638351-29200-3-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A8A52617B4
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:21 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
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

From: Elimar Riesebieter <riesebie@lxtec.de>

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 as10k1/examples/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/as10k1/examples/Makefile b/as10k1/examples/Makefile
index 1a36345..6ab8200 100644
--- a/as10k1/examples/Makefile
+++ b/as10k1/examples/Makefile
@@ -12,6 +12,8 @@ dsp: $(TARGETS)
 clean:
 	rm -f *~ *.emu10k1
 
+distclean: clean
+
 install:
 
 distdir:
-- 
1.7.10.4
