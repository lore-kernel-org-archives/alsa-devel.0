From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 1/3] Add AM_MAINTAINER_MODE.
Date: Wed, 15 May 2013 19:05:58 +0200
Message-ID: <1368637560-28962-2-git-send-email-jordi@debian.org>
References: <1368637560-28962-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id B46FF2616C7
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:06:24 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 0C06E628EE
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:06:23 +0200 (CEST)
In-Reply-To: <1368637560-28962-1-git-send-email-jordi@debian.org>
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

Add AM_MAINTAINER_MODE([enable]) to configure.in.
---
 configure.in |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.in b/configure.in
index ed3fe04..303478d 100644
--- a/configure.in
+++ b/configure.in
@@ -17,6 +17,8 @@ eval LIBTOOL_VERSION_INFO="2:0:0"
 dnl *************************************************
 AM_CONDITIONAL([INSTALL_M4], [test -n "${ACLOCAL}"])
 
+AM_MAINTAINER_MODE([enable])
+
 # Test for new silent rules and enable only if they are available
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
-- 
1.7.10.4
