From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] alsa-info.sh: use distros package manager to
	retrieve alsa library version
Date: Mon, 30 Mar 2009 11:03:45 +1100
Message-ID: <1238371425-6762-2-git-send-email-themuso@ubuntu.com>
References: <1238371425-6762-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl2.internode.on.net (ipmail05.adl2.internode.on.net
	[203.16.214.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B81C1037F6
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Mar 2009 02:04:00 +0200 (CEST)
In-Reply-To: <1238371425-6762-1-git-send-email-themuso@ubuntu.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Luke Yelavich <themuso@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

Move the alsa library version retrieval code into a new function,
get_alsa_library_version. This new function uses the original checking of the
alsa library header file for the version. If nothing is found, then move
onto using various distro package managers to get the alsa library version.
This commit takes care of checks for Ubuntu and Debian only, so other distro
developers/users will have to provide code for their distro.

Using the distro package manager to determine the alsa version is useful in
cases where information has been requested from a user who doesn't have
development files for the alsa library installed, as many distros don't install
such files by default.

Signed-off-by: Luke Yelavich <themuso@ubuntu.com>
---
 utils/alsa-info.sh |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index 8340019..736281d 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -214,6 +214,40 @@ then
 fi
 }
 
+get_alsa_library_version() {
+	ALSA_LIB_VERSION=`grep VERSION_STR /usr/include/alsa/version.h 2>/dev/null|awk {'print $3'}|sed 's/"//g'`
+
+	if [ -z "$ALSA_LIB_VERSION" ]; then
+		if [ -f /etc/lsb-release ]; then
+			. /etc/lsb-release
+			case "$DISTRIB_ID" in
+				Ubuntu)
+					if which dpkg > /dev/null ; then
+						ALSA_LIB_VERSION=`dpkg -l libasound2 | tail -1 | awk '{print $3}' | cut -f 1 -d -`
+					fi
+
+					if [ "$ALSA_LIB_VERSION" = "<none>" ]; then
+						ALSA_LIB_VERSION=""
+					fi
+					return
+					;;
+				*)
+					return
+					;;
+			esac
+		elif [ -f /etc/debian_version ]; then
+			if which dpkg > /dev/null ; then
+				ALSA_LIB_VERSION=`dpkg -l libasound2 | tail -1 | awk '{print $3}' | cut -f 1 -d -`
+			fi
+
+			if [ "$ALSA_LIB_VERSION" = "<none>" ]; then
+				ALSA_LIB_VERSION=""
+			fi
+			return
+		fi
+	fi
+}
+
 
 #Run checks to make sure the programs we need are installed.
 LSPCI=$(which lspci 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null);
@@ -329,7 +363,7 @@ KERNEL_MACHINE=`uname -m`
 KERNEL_OS=`uname -o`
 [[ `uname -v |grep SMP`  ]] && KERNEL_SMP="Yes" || KERNEL_SMP="No" 
 ALSA_DRIVER_VERSION=`cat /proc/asound/version |head -n1|awk {'print $7'} |sed 's/\.$//'`
-ALSA_LIB_VERSION=`grep VERSION_STR /usr/include/alsa/version.h 2>/dev/null|awk {'print $3'}|sed 's/"//g'`
+get_alsa_library_version
 ALSA_UTILS_VERSION=`amixer -v |awk {'print $3'}`
 VENDOR_ID=`lspci -vn |grep 040[1-3] | awk -F':' '{print $3}'|awk {'print substr($0, 2);}' >$TEMPDIR/vendor_id.tmp`
 DEVICE_ID=`lspci -vn |grep 040[1-3] | awk -F':' '{print $4}'|awk {'print $1'} >$TEMPDIR/device_id.tmp`
-- 
1.6.0.4
