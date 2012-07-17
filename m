From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-utils] [PATCH 3/3] build: Don't call
	AC_CHECK_FUNC with --disable-alsatest
Date: Tue, 17 Jul 2012 15:45:35 +0530
Message-ID: <1342520135-2606-3-git-send-email-arun.raghavan@collabora.co.uk>
References: <1342520135-2606-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 38CDF264FA3
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:15:34 +0200 (CEST)
In-Reply-To: <1342520135-2606-1-git-send-email-arun.raghavan@collabora.co.uk>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

---
 configure.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/configure.in b/configure.in
index e7bb4ca..6888dae 100644
--- a/configure.in
+++ b/configure.in
@@ -31,8 +31,10 @@ AC_PROG_LN_S
 AC_PROG_SED
 PKG_PROG_PKG_CONFIG
 AM_PATH_ALSA(1.0.24)
+if test "x$enable_alsatest" = "xyes"; then
 AC_CHECK_FUNC([snd_ctl_elem_add_enumerated],
 	      , [AC_ERROR([No user enum control support in alsa-lib])])
+fi
 
 dnl Check components
 AC_CHECK_HEADERS([alsa/pcm.h], [have_pcm="yes"], [have_pcm="no"],
-- 
1.7.8.6
