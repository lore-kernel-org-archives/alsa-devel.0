From: "Wischer, Timo (ADITG/SW1)" <twischer@de.adit-jv.com>
Subject: FW: Further goals of thread-safe PCM API
Date: Thu, 20 Apr 2017 14:01:47 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684182A2@HI2EXCH01.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C6AF2267025
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 16:01:52 +0200 (CEST)
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id 86E4A3C023A
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 16:01:51 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbLu20POxXu0 for <alsa-devel@alsa-project.org>;
 Thu, 20 Apr 2017 16:01:48 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 130523C004D
 for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2017 16:01:48 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I am wondering about the implementation of the new thread-safety feature [1].
There are so many issues with deadlocks (e.g. [3]) which were already solved but also which are not yet solved.

Why do you not using a recursive mutex to avoid most of this deadlocks?
Using PTHREAD_MUTEX_RECURSIVE as the pthread attribute [2].

What is the preferred solution for external ALSA plugins which are using the external IO plugin SDK to prevent such deadlocks?
For example I have one plugin which calls snd_pcm_avail() in the ext IO plug start callback.
This ends up in a deadlock.

#0  0x0000003f44e0feec in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x0000003f44e09b15 in pthread_mutex_lock () from /lib64/libpthread.so.0
#2  0x00007ffff7d3c8b4 in snd_pcm_lock (pcm=0x623150) at ../../../alsa-lib-1.1.2/src/pcm/pcm_local.h:1101
#3  snd_pcm_avail (pcm=0x623150) at ../../../alsa-lib-1.1.2/src/pcm/pcm.c:2762
#4  0x00007ffff7ae1e03 in ?? () from /usr/lib64/alsa-lib/libasound_module_pcm_loop.so
#5  0x00007ffff7d7df85 in snd_pcm_ioplug_start (pcm=0x623150) at ../../../alsa-lib-1.1.2/src/pcm/pcm_ioplug.c:458
#6  0x00007ffff7d41065 in __snd_pcm_start (pcm=0x623150, pcm=0x623150) at ../../../alsa-lib-1.1.2/src/pcm/pcm_local.h:427
#7  snd1_pcm_write_areas (pcm=pcm@entry=0x623150, areas=areas@entry=0x7fffffffe750, offset=offset@entry=0, size=size@entry=64, func=func@entry=0x7ffff7d7de00 <ioplug_priv_transfer_areas>)
    at ../../../alsa-lib-1.1.2/src/pcm/pcm.c:7248
#8  0x00007ffff7d7eb65 in snd_pcm_ioplug_writei (pcm=0x623150, buffer=<optimized out>, size=64) at ../../../alsa-lib-1.1.2/src/pcm/pcm_ioplug.c:579
#9  0x000000000040601a in pcm_write (
    data=0x623350 "\006\003\271\375N\004\063\376j\002n\374)\005\331\376I\005Z\376w\001\n\374\025\003\373\376{\003i\377T\001~\375}\375\244\372\267\002c\376%\004\352\377\312\b[\005\261\001\216\376\b\001,\377\352",
    count=count@entry=64) at ../../alsa-utils-1.1.2/aplay/aplay.c:2001
#10 0x00000000004062cb in playback_go (fd=6, loaded=<optimized out>, loaded@entry=0, count=147256, rtype=rtype@entry=2, name=name@entry=0x7fffffffed9a "/opt/platform/unit_tests/audio8k16S.wav")
    at ../../alsa-utils-1.1.2/aplay/aplay.c:2750
#11 0x0000000000407417 in playback (name=0x7fffffffed9a "/opt/platform/unit_tests/audio8k16S.wav") at ../../alsa-utils-1.1.2/aplay/aplay.c:2811
#12 0x0000000000409778 in main (argc=8, argv=0x7fffffffeb18) at ../../alsa-utils-1.1.2/aplay/aplay.c:859


Therefore do I have to replace all snd_pcm_* function calls in the external plugin with the non-thread-safe variants __snd_pcm_*?
Or is there a better solution available?

>From my point of view the usage of a recursive mutex would be the best and most stable solution.


[1] http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=54931e5a5455ac681a32a673d4b360d43f34b6b5
[2] https://linux.die.net/man/3/pthread_mutexattr_settype
[3] http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=24e63b75275e9c923c336b8dba3919b980e8f234
[4] http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___i_o_plug.html#ga7fb5213a5e776246e2b4dc53ec8d7604


Best regards

Timo Wischer

Advanced Driver Information Technology GmbH Software Group I (ADITG/SW1) Robert-Bosch-Str. 200
31139 Hildesheim
Germany

twischer@de.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multimedia GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Geschaeftsfuehrung: Wilhelm Grabow, Ken Yaguchi
