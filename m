From: Alexandru Costache <alexandru.costache.100@gmail.com>
Subject: Segmentation Fault in snd_pcm_rate_hw_free()
Date: Tue, 18 Aug 2015 12:51:18 +0300
Message-ID: <CAK2wT5bWnmTXLn-iV_y1odAVZ4PqjkxDbJBQgS8jS=HKqhL4oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 162662604DA
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 11:51:20 +0200 (CEST)
Received: by iodb91 with SMTP id b91so182038830iod.1
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 02:51:19 -0700 (PDT)
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

Hi,

I was reproducing the crash that Valentin Corfu reported earlier with his
test.

Valgrind and gdb show that
expand_linear_s16() is somehow corrupting the area used for memory
management by libc for rate->pareas[0].addr

More exactly, the line that seems to corrupt the heap in

static void expand_linear_s16() is:

*dst = (old_sample * old_weight + new_sample * new_weight) >> 16;


As Valgrind says:

==11161== Invalid write of size 2
==11161==    at 0x40A8A82: linear_expand_s16 (pcm_rate_linear.c:179)
==11161==    by 0x40A85A9: linear_convert (pcm_rate_linear.c:320)
==11161==    by 0x40A6915: do_convert (pcm_rate.c:537)
==11161==    by 0x40A6C7D: snd_pcm_rate_write_areas1 (pcm_rate.c:550)
==11161==    by 0x40A6C7D: snd_pcm_rate_commit_area (pcm_rate.c:749)
==11161==    by 0x40A7014: snd_pcm_rate_drain (pcm_rate.c:1105)
==11161==    by 0x4084511: snd_pcm_drain (pcm.c:1122)
==11161==    by 0x8049288: main (in /root/pcm_min_daisuke)
==11161==  Address 0x43d6258 is 0 bytes after a block of size 86,016 alloc'd
==11161==    at 0x40261B1: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==11161==    by 0x4099801: snd_pcm_mmap (pcm_mmap.c:425)
==11161==    by 0x4093CA7: sndrv_pcm_hw_params (pcm_params.c:2366)
==11161==    by 0x409A59C: snd1_pcm_generic_hw_params (pcm_generic.c:104)
==11161==    by 0x4091E7F: snd1_pcm_hw_params_slave (pcm_params.c:2250)
==11161==    by 0x40A54AC: snd_pcm_rate_hw_params (pcm_rate.c:246)
==11161==    by 0x4093AE3: sndrv_pcm_hw_params (pcm_params.c:2326)
==11161==    by 0x40ABC37: snd_pcm_plug_hw_params (pcm_plug.c:1045)
==11161==    by 0x4093AE3: sndrv_pcm_hw_params (pcm_params.c:2326)
==11161==    by 0x4084281: snd_pcm_hw_params (pcm.c:830)
==11161==    by 0x8048F84: main (in /root/pcm_min_daisuke)
==11161==
==11161== Invalid free() / delete / delete[] / realloc()
==11161==    at 0x402726D: free (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==11161==    by 0x40A53C0: snd_pcm_rate_hw_free (pcm_rate.c:344)
==11161==    by 0x4083CDA: snd_pcm_hw_free (pcm.c:853)
==11161==    by 0x40A9E8D: snd_pcm_plug_hw_free (pcm_plug.c:1061)
==11161==    by 0x4083CDA: snd_pcm_hw_free (pcm.c:853)
==11161==    by 0x80492AC: main (in /root/pcm_min_daisuke)
==11161==  Address 0xe705004b is not stack'd, malloc'd or (recently) free'd

I'm not very familiar with alsa in general and was wondering if someone who
knows more on it can drop a look on this one?

Thank you,
Alexandru
