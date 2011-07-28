From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/3] hdsploader: Temporary define for RPM
Date: Thu, 28 Jul 2011 23:45:48 +0200
Message-ID: <1311889548-28617-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Right now (1.0.24.1), alsa-lib's hdsp.h doesn't know about the RPM. To
avoid a strong dependency on unreleased code, temporary provide the
define here.

It can be dropped as soon as a new version of alsa-lib will be released,
thus effectively making it the required minimum version for alsa-tools.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdsploader/hdsploader.c b/hdsploader/hdsploader.c
index fa488a2..bfbe3bc 100644
--- a/hdsploader/hdsploader.c
+++ b/hdsploader/hdsploader.c
@@ -27,6 +27,10 @@
 
 static u_int32_t code[24413];
 
+#ifndef RPM
+# define RPM	5
+#endif
+
 int read_bin_file(u_int32_t *array, const char *filename)
 {
 	FILE *out;
-- 
1.7.5.4
