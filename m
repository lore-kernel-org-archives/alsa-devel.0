From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 4/4] Add AM_MAINTAINER_MODE([enable]) to
	configure.in.
Date: Wed, 15 May 2013 19:12:57 +0200
Message-ID: <1368637977-29096-5-git-send-email-jordi@debian.org>
References: <1368637977-29096-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DDEE26537B
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:13:13 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 6362562838
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:13:12 +0200 (CEST)
In-Reply-To: <1368637977-29096-1-git-send-email-jordi@debian.org>
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
index 6ca09f8..aae3e66 100644
--- a/configure.in
+++ b/configure.in
@@ -4,6 +4,8 @@ AC_INIT(aplay/aplay.c)
 AC_PREFIX_DEFAULT(/usr)
 AM_INIT_AUTOMAKE(alsa-utils, 1.0.27)
 
+AM_MAINTAINER_MODE([enable])
+
 AM_GNU_GETTEXT([external])
 AM_GNU_GETTEXT_VERSION([0.15])
 
-- 
1.7.10.4
