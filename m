From: "Nicolo'" <nicolopiazzalunga@gmail.com>
Subject: Microphones not working on Apple macbook Air 1,
 1 (Early 2008) under 3.2.0-55-generic-pae Linux
Date: Tue, 5 Nov 2013 12:34:25 +0100
Message-ID: <CABru_zU54A2dbr0eLLVCsqXvNBparaMaeM4bWfmro56QHHBOPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 402FB265186
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 12:34:47 +0100 (CET)
Received: by mail-we0-f176.google.com with SMTP id w62so3288574wes.35
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2013 03:34:45 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello List,

from time to time I spend time on this problem. (Of course, it is not
related to muting or capturing in alsamixer, or pulseaudio stuff, since
that was already tried.)

I can't get the mics to work, neither the internal one nor the external;
note that the same jack works both for HP and ext MIC, I think it's called
TRRS, and it's the same as the one used e.g. on iphones.

I tried also with more recent kernels, and playing with hda-jack-retask,
but with no success up to now.

alsa script result at https://www.dropbox.com/l/HHLkdCW4Shcak8gq2rBSY8

A curious fact, I found this alsa script result
http://www.alsa-project.org/db/?f=3ca8243c0626844f0264a3faad0aa72018bc14f4from
a guy running Arch on the same machine, where actually some Mic
appears in codec#0: do you think it is relevant?


Thanks and best,
Nicolo'
