From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/3] Allow frequencies down to 30 Hz
Date: Sat,  9 May 2009 19:27:06 -0500
Message-ID: <1241915227-12629-3-git-send-email-dpmcgee@gmail.com>
References: <1241915227-12629-1-git-send-email-dpmcgee@gmail.com>
	<1241915227-12629-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 83C0B1037ED
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 02:27:16 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so1657639yxn.2
	for <alsa-devel@alsa-project.org>; Sat, 09 May 2009 17:27:15 -0700 (PDT)
In-Reply-To: <1241915227-12629-2-git-send-email-dpmcgee@gmail.com>
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
Cc: Dan McGee <dpmcgee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

This patch is partially an RFC- it seems odd that we limit the frequency
at all. I proposed lowering it to 30 here only because that is what my
subwoofer can handle, but it may be better to just accept anything above
zero, or choose something like 20.

-Dan


 speaker-test/speaker-test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 5e00ea4..38e5462 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -861,7 +861,7 @@ int main(int argc, char *argv[]) {
       break;
     case 'f':
       freq = atof(optarg);
-      freq = freq < 50.0 ? 50.0 : freq;
+      freq = freq < 30.0 ? 30.0 : freq;
       freq = freq > 5000.0 ? 5000.0 : freq;
       break;
     case 'b':
-- 
1.6.2.4
