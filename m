From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/6] hdspmixer: Bump version number to 1.10
Date: Thu, 24 Feb 2011 21:33:29 +0100
Message-ID: <1298579611-16573-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber's last hdspmixer64 version was 1.9, so let's make this the
successor (contains everything that was in 1.9 and also Fredrik's work
on AES(32) support)

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/configure.in b/hdspmixer/configure.in
index 8f2c498..1b43bc9 100644
--- a/hdspmixer/configure.in
+++ b/hdspmixer/configure.in
@@ -1,5 +1,5 @@
 AC_INIT(src/hdspmixer.cxx)
-AM_INIT_AUTOMAKE(hdspmixer, 1.6)
+AM_INIT_AUTOMAKE(hdspmixer, 1.10)
 
 AC_PROG_CXX
 AC_PROG_MAKE_SET
-- 
1.7.2.3
