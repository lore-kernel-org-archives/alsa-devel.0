From: Adam Goode <agoode@google.com>
Subject: [PATCH - aconnect 1/1] Fix aconnect printing card and
	pid on older kernels
Date: Fri,  1 Apr 2016 13:35:01 -0400
Message-ID: <1459532101-6582-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
 [209.85.161.175])
 by alsa0.perex.cz (Postfix) with ESMTP id D58E726512A
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 19:35:05 +0200 (CEST)
Received: by mail-yw0-f175.google.com with SMTP id g3so176237268ywa.3
 for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2016 10:35:05 -0700 (PDT)
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
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org, martin.koegler@chello.at
List-Id: alsa-devel@alsa-project.org

alsa-lib is changed to return a distinct negative value if running on
an older kernel. -1 is only returned now if the kernel knows for sure
that there is no card or pid. On older kernels, alsa-lib will return
-ENOSYS.

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 85a7770..bbc5bb3 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -177,13 +177,13 @@ static void print_port(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
 #ifdef HAVE_SEQ_CLIENT_INFO_GET_CARD
 		card = snd_seq_client_info_get_card(cinfo);
 #endif
-		if (card != -1)
+		if (card >= 0)
 			printf(",card=%d", card);
 
 #ifdef HAVE_SEQ_CLIENT_INFO_GET_PID
 		pid = snd_seq_client_info_get_pid(cinfo);
 #endif
-		if (pid != -1)
+		if (pid >= 0)
 			printf(",pid=%d", pid);
 		printf("]\n");
 	}
-- 
2.8.0.rc3.226.g39d4020
