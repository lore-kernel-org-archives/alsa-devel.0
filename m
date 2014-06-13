From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?=5BPATCH_2/2=5D_aplay=3A_Escape_from_pcm?=
 =?utf-8?q?=5Fwrite=28=29_when_in=5Faborting_state?=
Date: Fri, 13 Jun 2014 10:59:57 +0400
Message-ID: <1402642797.26748747@f39.i.mail.ru>
References: <1402642371.496174944@f39.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f39.i.mail.ru (f39.i.mail.ru [94.100.178.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 2697F2616C9
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 08:59:58 +0200 (CEST)
Received: from mail by f39.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WvLSv-0006J5-IF
 for alsa-devel@alsa-project.org; Fri, 13 Jun 2014 10:59:57 +0400
In-Reply-To: <1402642371.496174944@f39.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes aplay freezing and not responding to Ctrl+C
when playback pcm is stuck and returns 0 to write attempts:
Example:
  # aplay -vvv /dev/zero
  pcm.!default {
    type plug
    slave.pcm { type null }
    slave.format S32_LE
  }
---
 aplay/aplay.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 77e40a3..a5b9c2a 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1921,7 +1921,7 @@ static ssize_t pcm_write(u_char *data, size_t count)
 		count = chunk_size;
 	}
 	data = remap_data(data, count);
-	while (count > 0) {
+	while (count > 0 && !in_aborting) {
 		if (test_position)
 			do_test_position();
 		check_stdin();
-- 
1.7.10.4
