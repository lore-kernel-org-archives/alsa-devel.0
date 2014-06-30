From: Josh Lehan <alsa@krellan.com>
Subject: [PATCH - alsa-utils 1/5] Adding amidicat subdirectory
	to SUBDIRS
Date: Mon, 30 Jun 2014 01:54:59 -0700
Message-ID: <1404118503-22921-2-git-send-email-alsa@krellan.com>
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

diff --git a/Makefile.am b/Makefile.am
index f25eee2..43fb503 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,6 +1,6 @@
 AM_CPPFLAGS=-I$(top_srcdir)/include
 
-SUBDIRS = include alsactl alsaucm utils m4 po
+SUBDIRS = include alsactl alsaucm utils m4 po amidicat
 if ALSAMIXER
 SUBDIRS += alsamixer
 endif
-- 
1.8.3.2
