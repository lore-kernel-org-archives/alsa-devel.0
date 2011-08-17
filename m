From: linux@audioscience.com
Subject: [PATCH] Prefer kernel-versioned firmware directory.
Date: Wed, 17 Aug 2011 15:19:23 +1200
Message-ID: <1313551163-819-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Different kernel versions may have different driver versions installed,
which in turn require different firmware versions.

If /lib/firmware/$(uname -r) exists, use it in preference to the
generic /lib/firmware.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 configure.in |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/configure.in b/configure.in
index c278987..ac9ee52 100644
--- a/configure.in
+++ b/configure.in
@@ -33,7 +33,9 @@ AM_CONDITIONAL(BUILD_FW, test "$buildfw" = "yes")
 AC_MSG_CHECKING(firmware installation directory)
 # where to put the firmware. If none of these is right, can specify where
 # --with-hotplug-dir
-if test -d /lib/firmware ; then
+if test -d /lib/firmware/$(uname -r) ; then
+	detected_fwdir="/lib/firmware/$(uname -r)"
+elif test -d /lib/firmware ; then
 	detected_fwdir="/lib/firmware"
 elif test -d /lib/hotplug/firmware ; then
 	detected_fwdir="/lib/hotplug/firmware"
-- 
1.7.0.4
