From: Josh Lehan <alsa@krellan.com>
Subject: [PATCH - alsa-utils 2/5] Add amidicat Makefile to
	AC_OUTPUT list
Date: Mon, 30 Jun 2014 01:55:00 -0700
Message-ID: <1404118503-22921-3-git-send-email-alsa@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1404118503-22921-1-git-send-email-alsa@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Josh Lehan <alsa@krellan.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Josh Lehan <alsa@krellan.com>

diff --git a/configure.ac b/configure.ac
index a4d2db3..3f43ff9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -360,4 +360,4 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
 	  speaker-test/Makefile speaker-test/samples/Makefile \
-	  alsaloop/Makefile)
+	  alsaloop/Makefile amidicat/Makefile)
-- 
1.8.3.2
