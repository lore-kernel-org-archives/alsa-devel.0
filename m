From: Jordi Mallach <jordi@debian.org>
Subject: [PATCH 3/3] Add AM_MAINTAINER_MODE([enable]) to
	configure.in.
Date: Wed, 15 May 2013 19:11:48 +0200
Message-ID: <1368637908-29042-4-git-send-email-jordi@debian.org>
References: <1368637908-29042-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id C06C52616E9
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:12:07 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 1D2D762988
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:12:07 +0200 (CEST)
In-Reply-To: <1368637908-29042-1-git-send-email-jordi@debian.org>
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
index bf8676b..abc7013 100644
--- a/configure.in
+++ b/configure.in
@@ -3,6 +3,8 @@ AC_INIT(oss/pcm_oss.c)
 AM_INIT_AUTOMAKE(alsa-plugins, 1.0.27)
 AC_PREFIX_DEFAULT(/usr)
 
+AM_MAINTAINER_MODE([enable])
+
 AC_CONFIG_HEADERS(config.h)
 AC_CONFIG_MACRO_DIR([m4])
 
-- 
1.7.10.4
