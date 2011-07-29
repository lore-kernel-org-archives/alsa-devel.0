From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/2] hdsploader: Fix temporary RPM constant
Date: Fri, 29 Jul 2011 17:57:29 +0200
Message-ID: <1311955050-28144-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1311955050-28144-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311955050-28144-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

RPM in HDSP_IO_Type (enum from hdsp.h) is 4, not 5.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdsploader/hdsploader.c b/hdsploader/hdsploader.c
index bfbe3bc..9199c3a 100644
--- a/hdsploader/hdsploader.c
+++ b/hdsploader/hdsploader.c
@@ -28,7 +28,7 @@
 static u_int32_t code[24413];
 
 #ifndef RPM
-# define RPM	5
+# define RPM	4
 #endif
 
 int read_bin_file(u_int32_t *array, const char *filename)
-- 
1.7.5.4
