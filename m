From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] hda-emu: Add "dist" and "compile" to
	.gitignore
Date: Mon,  7 Sep 2015 10:58:50 +0200
Message-ID: <1441616330-6635-2-git-send-email-david.henningsson@canonical.com>
References: <1441616330-6635-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5591D260632
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 10:58:57 +0200 (CEST)
In-Reply-To: <1441616330-6635-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index a487bd5..763df25 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,3 +26,5 @@ ltmain.sh
 missing
 kernel/misc_wrapper.c
 kernel/init_hooks.h
+dist
+compile
-- 
1.9.1
