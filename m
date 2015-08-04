From: Valentin Corfu <corfuvalentin@gmail.com>
Subject: Segmentation Fault in snd_pcm_rate_hw_free()
Date: Tue, 04 Aug 2015 17:08:30 +0300
Message-ID: <55C0C75E.8090501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F3AC265823
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 16:10:02 +0200 (CEST)
Received: by wicgj17 with SMTP id gj17so152286540wic.1
 for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2015 07:10:02 -0700 (PDT)
Received: from [128.224.168.121] ([89.121.200.106])
 by smtp.googlemail.com with ESMTPSA id kb1sm2059799wjc.24.2015.08.04.07.10.00
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Aug 2015 07:10:01 -0700 (PDT)
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

Hello ALSA developers,

I observed one segmentation fault in snd_pcm_rate_hw_free() function, 
with the following BT:

(gdb) up
#1  0xb7554cc1 in raise (sig=6) at 
../nptl/sysdeps/unix/sysv/linux/raise.c:64
64        return INLINE_SYSCALL (tgkill, 3, pid, selftid, sig);
(gdb)
#2  0xb75580ee in abort () at abort.c:92
92            raise (SIGABRT);
(gdb)
#3  0xb758a7dd in __libc_message (do_abort=2,
     fmt=0xb766053c "*** glibc detected *** %s: %s: 0x%s ***\n")
     at ../sysdeps/unix/sysv/linux/libc_fatal.c:189
189           abort ();
(gdb)
#4  0xb7594a71 in malloc_printerr (action=<value optimized out>,
     str=<value optimized out>, ptr=0x969ae98) at malloc.c:6283
6283          __libc_message (action & 2,
(gdb)
#5  0xb759636b in _int_free (av=<value optimized out>, p=0x969ae90)
     at malloc.c:4795
4795          malloc_printerr (check_action, errstr, chunk2mem(p));
(gdb)
#6  0xb75994bd in __libc_free (mem=0x969ae98) at malloc.c:3738
3738      _int_free(ar_ptr, p);
(gdb)
#7  0xb76f3a81 in snd_pcm_rate_hw_free (pcm=0x9685d78) at pcm_rate.c:341
341                     free(rate->pareas[0].addr);
(gdb)
#8  0xb76d045b in snd_pcm_hw_free (pcm=0x9685d78) at pcm.c:858
858             err = pcm->ops->hw_free(pcm->op_arg);
(gdb)
#9  0xb76f826e in snd_pcm_plug_hw_free (pcm=0x96856b0) at pcm_plug.c:1046
1046            int err = snd_pcm_hw_free(slave);
(gdb)
#10 0xb76d045b in snd_pcm_hw_free (pcm=0x96856b0) at pcm.c:858
858             err = pcm->ops->hw_free(pcm->op_arg);
(gdb)
#11 0x080492ad in main ()


Could you please give me some hints how to solve this issue?

I can provide you more info or the test application, if needed.
I can see the issue every time, and I also checked with latest version 
of alsa-lib but I got the same results.

Thank you,
Valentin Corfu
