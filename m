From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/4] alsa-info.sh: fix whitespace leaked to
	stdout
Date: Wed, 08 Jul 2009 21:07:24 +0800
Message-ID: <20090708131504.054756489@intel.com>
References: <20090708130722.723912338@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D73DE1038B1
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 15:16:39 +0200 (CEST)
Content-Disposition: inline; filename=alsa-no-whitespace.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Redirect the "echo \t" outputs to the desired file,
and avoid messing up stdio.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 utils/alsa-info.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- alsa-driver.orig/utils/alsa-info.sh
+++ alsa-driver/utils/alsa-info.sh
@@ -519,7 +519,10 @@ echo "!!--------------------------" >> $
 echo "" >> $FILE
 for mod in `cat /proc/asound/modules|awk {'print $2'}`;do
 echo "!!Module: $mod" >> $FILE
-for params in `ls $SYSFS/module/$mod/parameters/*`; do /bin/echo -ne "\t";/bin/echo "$params : `cat $params`"|sed 's:.*/::' >> $FILE;done
+for params in `echo $SYSFS/module/$mod/parameters/*`; do
+	echo -ne "\t";
+	echo "$params : `cat $params`" | sed 's:.*/::';
+done >> $FILE
 echo "" >> $FILE
 done
 echo "" >> $FILE

-- 
