From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Aplay: Fix spelling error
Date: Thu,  6 Oct 2011 11:05:48 +0200
Message-ID: <1317891948-19509-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 62EC0103A74
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 11:06:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz
Cc: David Henningsson <david.henningsson@canonical.com>, cldunlap1@gmail.com, daniel.holbach@canonical.com
List-Id: alsa-devel@alsa-project.org

BugLink: https://bugs.launchpad.net/bugs/816388
Reported-by: Chad Dunlap <cldunlap1@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 aplay/aplay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 07e6bc0..5ab63a9 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -209,7 +209,7 @@ _("Usage: %s [OPTION]... [FILE]...\n"
 "    --disable-format    disable automatic format conversions\n"
 "    --disable-softvol   disable software volume control (softvol)\n"
 "    --test-position     test ring buffer position\n"
-"    --test-coef=#	 test coeficient for ring buffer position (default 8)\n"
+"    --test-coef=#       test coefficient for ring buffer position (default 8)\n"
 "                        expression for validation is: coef * (buffer_size / 2)\n"
 "    --test-nowait       do not wait for ring buffer - eats whole CPU\n"
 "    --max-file-time=#   start another output file when the old file has recorded\n"
-- 
1.7.5.4
