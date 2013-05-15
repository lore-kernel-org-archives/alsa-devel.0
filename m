From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 3/3] Add AM_MAINTAINER_MODE([enable]) to
	configure.in.
Date: Wed, 15 May 2013 18:58:07 +0200
Message-ID: <1368637087-28860-4-git-send-email-jordi@debian.org>
References: <1368637087-28860-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id A74362616C7
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:30 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 4009662A0B
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:27 +0200 (CEST)
In-Reply-To: <1368637087-28860-1-git-send-email-jordi@debian.org>
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

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 configure.in |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.in b/configure.in
index d0318e7..0afeb8a 100644
--- a/configure.in
+++ b/configure.in
@@ -2,6 +2,8 @@ AC_PREREQ(2.59)
 AC_INIT(alsa/alsa-oss.c)
 AM_INIT_AUTOMAKE(alsa-oss, 1.0.25)
 
+AM_MAINTAINER_MODE([enable])
+
 LIBTOOL_VERSION_INFO="0:0:0"
 AC_SUBST(LIBTOOL_VERSION_INFO)
 
-- 
1.7.10.4
