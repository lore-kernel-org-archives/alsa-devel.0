From: Laurentiu Nicola <grayshade@gmail.com>
Subject: snd_pcm_set_params typo patch
Date: Wed, 7 Aug 2013 22:23:30 +0300
Message-ID: <CA+uadsMViXKngUbmTeVx+za6v+OvOmO_E4_eYWMGydY+SiH87g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f46.google.com (mail-qe0-f46.google.com
 [209.85.128.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E09382619D3
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 21:23:46 +0200 (CEST)
Received: by mail-qe0-f46.google.com with SMTP id i11so1231759qej.33
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2013 12:23:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please, somebody apply this one. I lost quite a bit of time because of it
:).

Also, is there anything wrong with the bug tracker? It doesn't load for me.

diff -urpN alsa-lib-1.0.27.2/src/pcm/pcm.c
alsa-lib-1.0.27.2-mine/src/pcm/pcm.c
--- alsa-lib-1.0.27.2/src/pcm/pcm.c    2013-07-08 15:31:36.000000000 +0300
+++ alsa-lib-1.0.27.2-mine/src/pcm/pcm.c    2013-08-07 22:17:14.908673700
+0300
@@ -7932,7 +7932,7 @@ int snd_pcm_set_params(snd_pcm_t *pcm,
         return err;
     }
     if (rrate != rate) {
-        SNDERR("Rate doesn't match (requested %iHz, get %iHz)", rate, err);
+        SNDERR("Rate doesn't match (requested %iHz, got %iHz)", rate,
rrate);
         return -EINVAL;
     }
     /* set the buffer time */


-- 
Because there are many ways to skin a cat, but you only get to choose one.
