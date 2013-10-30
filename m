From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] asoc-tools: Render png image instead of jpeg
	in vizdapm.sh
Date: Wed, 30 Oct 2013 16:54:30 +0200
Message-ID: <1383144870-20294-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 61FEF265351
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 15:55:47 +0100 (CET)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Lossless png image suits better to technical drawings than jpeg which may
even have artifacts around sharp objects.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For git://opensource.wolfsonmicro.com/asoc-tools.git
---
 bin/vizdapm.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/vizdapm.sh b/bin/vizdapm.sh
index 11d1361..8d61dd2 100755
--- a/bin/vizdapm.sh
+++ b/bin/vizdapm.sh
@@ -16,7 +16,7 @@
 usage()
 {
 cat << EOF
-usage: $0 <dapm-debugfs-directory> <graph-dot-file> <graph-jpg-file>
+usage: $0 <dapm-debugfs-directory> <graph-dot-file> <graph-png-file>
 EOF
 exit 1
 }
@@ -29,7 +29,7 @@ active=
 curpath=`pwd`
 dapm_debugfs="$1"
 graph_file=${curpath}"/$2"
-graph_file_jpg=${curpath}"/$3"
+graph_file_png=${curpath}"/$3"
 
 trap "{ [ -f "$graph_file" ] && rm -f "$graph_file"; exit; }" SIGINT SIGTERM
 
@@ -62,4 +62,4 @@ done
 popd >/dev/null
 
 echo "}" >> "$graph_file"
-dot -Kfdp -Tjpg "$graph_file" -o "$graph_file_jpg"
+dot -Kfdp -Tpng "$graph_file" -o "$graph_file_png"
-- 
1.8.4.rc3
