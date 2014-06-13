From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?=5BPATCH_1/2=5D_pcm=3A_break_out_of_snd=5F?=
 =?utf-8?q?pcm=5Fwrite=5Fareas=28=29_if_write_function_returned_0?=
Date: Fri, 13 Jun 2014 10:58:47 +0400
Message-ID: <1402642727.109608901@f39.i.mail.ru>
References: <1402642371.496174944@f39.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f39.i.mail.ru (f39.i.mail.ru [94.100.178.227])
 by alsa0.perex.cz (Postfix) with ESMTP id AB68326171D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 08:58:47 +0200 (CEST)
Received: from mail by f39.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WvLRn-0005zH-4v
 for alsa-devel@alsa-project.org; Fri, 13 Jun 2014 10:58:47 +0400
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

When pcm is stuck and write func returns 0, snd_pcm_write_areas() loops
infinitely freezing the application and not allowing it to handle the case.
Can be reproduced with:
  # aplay -vvv /dev/zero
  pcm.!default {
    type plug
    slave.pcm { type null }
    slave.format S32_LE
  }
This patch fixes it by breaking the loop if func returns 0.
Note: pcm_null stuckness must be fixed on its own.
---
 src/pcm/pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 7e46014..5bb7582 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -6816,7 +6816,7 @@ snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area
 		if (! frames)
 			break;
 		err = func(pcm, areas, offset, frames);
-		if (err < 0)
+		if (err <= 0)
 			break;
 		frames = err;
 		if (state == SND_PCM_STATE_PREPARED) {
-- 
1.7.10.4
