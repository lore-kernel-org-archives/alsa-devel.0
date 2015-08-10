From: Valentin Corfu <corfuvalentin@gmail.com>
Subject: jack: Fixing a small memory leak
Date: Mon, 10 Aug 2015 17:58:25 +0300
Message-ID: <1439218706-30721-1-git-send-email-corfuvalentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 842CA26598D
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 17:00:08 +0200 (CEST)
Received: by wicja10 with SMTP id ja10so29546884wic.1
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 08:00:08 -0700 (PDT)
Received: from otp-vcorfu-l1.corp.ad.wrs.com ([89.121.200.106])
 by smtp.googlemail.com with ESMTPSA id jr5sm29888894wjc.14.2015.08.10.08.00.06
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Aug 2015 08:00:07 -0700 (PDT)
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


Hello Alsa developers,

I observed a small memory leak in alsa-plugins (jack):

...
==1034== 
==1034== 8 bytes in 1 blocks are definitely lost in loss record 7 of 108
==1034==    at 0x4027E5A: calloc (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==1034==    by 0x4035102: snd_pcm_jack_prepare (in /usr/lib/alsa-lib/libasound_module_pcm_jack.so)
==1034==    by 0x40D07AB: snd_pcm_ioplug_prepare (pcm_ioplug.c:145)
==1034==    by 0x4084961: snd_pcm_prepare (pcm.c:1052)
==1034==    by 0x409DDB4: snd_pcm_plugin_prepare (pcm_plugin.c:162)
==1034==    by 0x4084961: snd_pcm_prepare (pcm.c:1052)
==1034==    by 0x409DDB4: snd_pcm_plugin_prepare (pcm_plugin.c:162)
==1034==    by 0x4084961: snd_pcm_prepare (pcm.c:1052)
==1034==    by 0x4084A1D: snd_pcm_hw_params (pcm.c:838)
==1034==    by 0x4090013: snd_pcm_set_params (pcm.c:8053)
==1034==    by 0x80486EB: main (in /root/pcm_min_ok)
...
==1034== LEAK SUMMARY:
==1034==    definitely lost: 8 bytes in 1 blocks
==1034==    indirectly lost: 0 bytes in 0 blocks
==1034==      possibly lost: 31,311 bytes in 1,630 blocks
==1034==    still reachable: 5,619 bytes in 24 blocks
==1034==         suppressed: 0 bytes in 0 blocks
==1034== Reachable blocks (those to which a pointer was found) are not shown.
==1034== To see them, rerun with: --leak-check=full --show-leak-kinds=all
...


Best Regards,
Valentin Corfu
