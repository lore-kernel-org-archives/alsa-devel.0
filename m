From: Fernando Rodriguez <cyklonite@gmail.com>
Subject: Choppy audio with non-blocking writes
Date: Mon, 24 Oct 2016 12:02:55 -0400
Message-ID: <5b7fdbff-edb0-da87-62d5-1f90ab2b4b8f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id ACEAC266CE7
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 18:00:36 +0200 (CEST)
Received: by mail-yb0-f172.google.com with SMTP id f196so2728951yba.4
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 09:00:36 -0700 (PDT)
Received: from [10.10.0.10] (67-8-110-87.res.bhn.net. [67.8.110.87])
 by smtp.gmail.com with ESMTPSA id e72sm6037162ywa.54.2016.10.24.09.00.34
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Oct 2016 09:00:34 -0700 (PDT)
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

I'm using non-blocking writes to play an audio stream. When snd_pcm_writei()
return -EGAIN I put the thread to sleep for the time it would take to play 
the packet that I'm trying to write and the packet size it's capped at 1/4 the 
ALSA buffer so that should ensure that the buffer never gets more than half 
empty. And it works as I don't get underruns. But sometimes the audio gets 
choppy and it sounds like it's playing out of time. Like periodically for a 
fraction of a second it plays a bit of audio that should've been played about 
a second ago.

Triggering an underrun or a call to snd_pcm_drain(), either by pausing the stream
or overloading the CPU corrects the problem so I think the internal ALSA ring buffer
pointers are getting out of sync somehow. Also it only happens with non-blocking 
writes. If I use blocking writes it works fine but there are other problems with that.
So I think either  I'm handling -EAGAIN incorrectly, or not configuring it properly?

You can look at the code here:
https://bitbucket.org/frodzdev/mediabox/src/84dced5b84eba4e6e639615dd3d30fccfb0c805b/src/audio.c?at=staging&fileviewer=file-view-default#audio.c-503

Any help will be appreciated.

- -- 

Fernando Rodriguez
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYDjCvAAoJEPbOFX/5UlwcG/MP/2WAuJKy4WhU5h/yauDyuv1S
h5H2Lj2orQcx0R55Qy3xewYz+HEgM+k0p2chJXUsB7dxp6zrnXCven1H0lZqhm0o
dVFZ+E3r/rUBpfIOmlvT27uUTFyQcdz9h+WViAFvCbldEOEa7DALEXqLvNLeC1S7
C6dfuV/L7/Dq0W5sNtErZpzH7YY715zzZCIGncAd7LGteTaMND/p6F02CqwEm343
E4zNL6+Ac3N1eEmlRWI/Vo8QC1Yafo7BbPuR0kYornkqigNgK3yL/+FSwAcHZC4V
Ge8Q0Ba1DCFMWC6BEfPwSyZ4hUeillQQbPMYhgu4QCKiKUrD8QOFSu16e2A1d+hU
usn9WQwyisheDavqxvNN+6pr2Gi9r2BxzWbqLQKJ8L+bSLvuaDGEWmUDgVjjGm89
NKcL6yjucJamjjn8ZMfcx6T4e+ieyU9IOMNteXz54QKG9ltX2IqWgoBG6S+S4cjL
SggGePoQHq2e7WwWjKqDQ5lOx0aZsb5SZqrgllR4/ROL4Dk+52DRjYChdOG4Prim
kFRmcdHrvlBmunCXIaIu5+Ec0GuoBEjPfTKwlo1gylrZEYAfjU8iLpoTDkP3J4SK
FPY5ibUD9IKF/cbdFUzx+oAZoBFlC3oAPLqt80VgsLVEI/1d9Z36+xPRE6PidihP
Orn2dggcwqfbR1v+x+Ot
=RfWT
-----END PGP SIGNATURE-----
