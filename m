From: Alexandre Bique <bique.alexandre@gmail.com>
Subject: Choosing the best PCM access
Date: Wed, 8 Jul 2015 17:57:05 +0200
Message-ID: <CAP737oKQP_1dUVH7-6=M7d2iUHVbeRbNyzM1qPwDO+J0dk4=CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF63264F09
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 17:57:25 +0200 (CEST)
Received: by lagc2 with SMTP id c2so225554460lag.3
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 08:57:25 -0700 (PDT)
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

I just ran test/pcm.c and found that MMAP_NONINTERLEAVED was faster
than MMAP_INTERLEAVED in my case.

My test was to run it like:
./a.out -c 2 -b 3000 -p 1500 -m direct_nointerleaved
And I got a lot more crackling in interleaved than in noninterleaved.

Is it something very hardware/driver dependent and if so, how to know
which is the best access?

Thank you,
-- 
Alexandre Bique
