From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] alsa-info: Make sure all full script is
	run even with "output" option
Date: Fri, 22 Aug 2014 10:31:40 +0200
Message-ID: <1408696301-5622-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AB78265757
 for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2014 10:31:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

For some reason, when the --output option is used, less information
is included compared to when no options are used. This is unexpected.

Fix this by running "withall" also when the output option is used.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsa-info/alsa-info.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 859d7bc..47157f0 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -661,6 +661,7 @@ if [ -n "$1" ]; then
 			shift
 			NFILE="$1"
 			KEEP_OUTPUT="yes"
+			withall
 			;;
 		--debug)
 			echo "Debugging enabled. $FILE and $TEMPDIR will not be deleted"
-- 
1.9.1
