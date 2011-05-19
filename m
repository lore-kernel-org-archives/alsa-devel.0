From: Alexander Stein <a.stein@systec-electronic.com>
Subject: [PATCH] ctlparse: Respect softfloat configure option
Date: Thu, 19 May 2011 15:16:36 +0200
Message-ID: <1305810996-10621-1-git-send-email-a.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox687.server-home.net (webbox687.server-home.net
	[195.149.74.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 768D010384B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 15:16:41 +0200 (CEST)
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
Cc: Alexander Stein <a.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

If we want softlfoat we can't use ceil which uses libm.

Signed-off-by: Alexander Stein <a.stein@systec-electronic.com>
---
This patch relates to
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-May/039693.html
and following.

 src/control/ctlparse.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/control/ctlparse.c b/src/control/ctlparse.c
index a929816..a16f96a 100644
--- a/src/control/ctlparse.c
+++ b/src/control/ctlparse.c
@@ -33,8 +33,17 @@
 
 /* Function to convert from percentage to volume. val = percentage */
 
+#ifdef HAVE_SOFT_FLOAT
+static inline long int convert_prange1(long val, long min, long max)
+{
+	long temp = val * (max - min);
+	return temp / 100 + min + ((temp % 100) == 0 ? 0 : 1);
+}
+#else
+
 #define convert_prange1(val, min, max) \
 	ceil((val) * ((max) - (min)) * 0.01 + (min))
+#endif
 
 #define check_range(val, min, max) \
 	((val < min) ? (min) : ((val > max) ? (max) : (val)))
-- 
1.7.3.4
