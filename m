From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/2] ucm: Enable all warnings for automake C
	preprocessor
Date: Tue, 27 Dec 2016 18:08:51 +0800
Message-ID: <1482833331-2261-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7D3266649
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 11:06:02 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

To display warnings for us to fix them, add '-Wall' to AM_CPPFLAGS.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/Makefile.am b/src/ucm/Makefile.am
index 9d66b24..79e57d2 100644
--- a/src/ucm/Makefile.am
+++ b/src/ucm/Makefile.am
@@ -7,4 +7,4 @@ noinst_HEADERS = ucm_local.h
 all: libucm.la
 
 
-AM_CPPFLAGS=-I$(top_srcdir)/include
+AM_CPPFLAGS=-I$(top_srcdir)/include -Wall
-- 
2.7.4
