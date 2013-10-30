From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] asoc-tools: Require bash shell when
	interpreting vizdapm.sh
Date: Wed, 30 Oct 2013 16:26:41 +0200
Message-ID: <1383143201-18337-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BECE265442
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 15:26:50 +0100 (CET)
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

pushd and popd are built-in functions of bash shell so require it explicitly
instead of relying /bin/sh.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For git://opensource.wolfsonmicro.com/asoc-tools.git
---
 bin/vizdapm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/vizdapm.sh b/bin/vizdapm.sh
index 29d6b3c..11d1361 100755
--- a/bin/vizdapm.sh
+++ b/bin/vizdapm.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright 2011 Wolfson Microelectronics plc
 # Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
-- 
1.8.4.rc3
