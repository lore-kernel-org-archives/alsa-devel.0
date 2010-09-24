From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] include/adriver.h: Define pr_warn to allow
	compilation against older kernels
Date: Fri, 24 Sep 2010 15:06:43 +1000
Message-ID: <1285304803-10345-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas01p.mx.bigpond.com (nschwmtas01p.mx.bigpond.com
	[61.9.189.137]) by alsa0.perex.cz (Postfix) with ESMTP id E3550103973
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 07:06:49 +0200 (CEST)
Received: from nschwotgx01p.mx.bigpond.com ([124.189.85.102])
	by nschwmtas01p.mx.bigpond.com with ESMTP id
	<20100924050645.TLFD24965.nschwmtas01p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 05:06:45 +0000
Received: from strigy.yelavich.home ([124.189.85.102])
	by nschwotgx01p.mx.bigpond.com with ESMTP id
	<20100924050644.UHL8424.nschwotgx01p.mx.bigpond.com@strigy.yelavich.home>
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 05:06:44 +0000
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
List-Id: alsa-devel@alsa-project.org

From: Luke Yelavich <luke.yelavich@canonical.com>

In my testing of the daily tarball, I am unable to build against 2.6.32. I
assume that older kernels would be affected in a similar way.

Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 include/adriver.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/adriver.h b/include/adriver.h
index 1c7e87b..495e640 100644
--- a/include/adriver.h
+++ b/include/adriver.h
@@ -1566,6 +1566,10 @@ XXX_DEFINE_STRTO(ull, unsigned long long);
 #define pr_warning(fmt, arg...) \
 	printk(KERN_WARNING fmt, ##arg)
 #endif
+#ifndef pr_warn
+#define pr_warn(fmt, arg...) \
+	printk(KERN_WARNING fmt, ##arg)
+#endif
 #ifndef pr_notice
 #define pr_notice(fmt, arg...) \
 	printk(KERN_NOTICE fmt, ##arg)
-- 
1.7.1
