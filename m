From: Ihar Filipau <thephilips@gmail.com>
Subject: dmix produces garbled sound on ARM
Date: Thu, 9 Jun 2016 13:38:19 +0200
Message-ID: <CAD08gxJmvpJ-DdGpEawmBZ4aZCNj_Gyhqdf7bSbqRrZ4Xa9Lqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C7CD226070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 13:38:20 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id r5so9983728wmr.0
 for <alsa-devel@alsa-project.org>; Thu, 09 Jun 2016 04:38:20 -0700 (PDT)
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

Hi All!

When using the dmix on ARM, the sound comes out garbled, with as if
overlapping, increasing-in-number echoes. That happens even with a
single aplay instance.

In a forum discussion, it was suggested that ARM lacks optimized dmix
implementation. But that implies that the generic dmix code is broken,
since it is what is used on ARM/etc, but not on i386/amd64. (The forum
discussion about my particular issue:
http://unix.stackexchange.com/questions/288451/sound-corruption-echo-when-trying-to-use-alsa-dmix
)

Does anybody has any suggestions how to fix/avoid the dmix issue on ARM?

Thanks.

P.S. Versions: Linux v3.18.24, alsa-lib/-utils v1.0.29. The hardware:
FreeScale i.MX35 (ARM1136) with SGTL5000 sound chip (used in 48KHz
mode).

P.P.S. The generic code has outdated functions for the "concurrent"
implementation with cmpxchg. The code probably could be updated, and
revised to use the C11's stdatomic.h when available.
