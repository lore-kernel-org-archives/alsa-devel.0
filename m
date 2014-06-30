From: Josh Lehan <alsa@krellan.com>
Subject: [PATCH - alsa-utils 3/5] Makefile for amidicat,
	includes manual page
Date: Mon, 30 Jun 2014 01:55:01 -0700
Message-ID: <1404118503-22921-4-git-send-email-alsa@krellan.com>
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

diff --git a/amidicat/Makefile.am b/amidicat/Makefile.am
new file mode 100644
index 0000000..02a896d
--- /dev/null
+++ b/amidicat/Makefile.am
@@ -0,0 +1,5 @@
+AM_CPPFLAGS  = -I$(top_srcdir)/include
+EXTRA_DIST   = amidicat.1
+
+bin_PROGRAMS = amidicat
+man_MANS     = amidicat.1
-- 
1.8.3.2
