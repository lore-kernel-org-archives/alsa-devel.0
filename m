From: Valentin Corfu <corfuvalentin@gmail.com>
Subject: Playback in infinitely loop - bug in alsa-jack-plugins?
Date: Fri, 16 Jan 2015 11:42:46 +0200
Message-ID: <54B8DD16.7020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 15EB2264F45
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 10:42:51 +0100 (CET)
Received: by mail-wi0-f170.google.com with SMTP id z2so3224210wiv.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 01:42:50 -0800 (PST)
Received: from [128.224.168.114] ([89.121.200.106])
 by mx.google.com with ESMTPSA id lg7sm2285194wic.0.2015.01.16.01.42.49
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Jan 2015 01:42:50 -0800 (PST)
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

Hello guys,

Few days ago I have started to look over a new challenging issue with alsa..
The problem is that the sound entry in a loop infinitely and it seems 
that the last samples in the buffer are just repeated over and over again.
This behaviour it happens when I have too less and only sporadically 
data ready to be playbacked on my embedded system configured with alsa 
jack pcm plugin.

To solve this issue, (I don't want to use snd_pcm_drain()), I see 2 ways:
     1) to clear(or overwrite with silence) the "just played" frames 
from the ring buffer
     2) when I am in this situation, to gracefully stop/close the alsa 
opened port

In both situations I have tried without success, 
_set_silence_threshold(), set_stop_threshold and other googled solutions..

More over, I also tested with "default" device and the result is as 
expected... the sound can be hear just once, then it's going into 
underrun state.

I also created a small test(based on pcm_min.c example), where I 
intentionally put a ~1s(can be more) delay after _writei() function, to 
see the issue reproduced. (http://pastebin.com/4KyUG0BA)

log with pcm jack plugin: http://pastebin.com/MtKQ4ASz
log with "default": http://pastebin.com/G0zq6fmJ

Now I'm suspecting one issue with the underrun, over alsa jack plugin...

(In case I'm not wrong with the test case or my assumption..)
  - Isn't it implemented underrun detection over jack plugin or it is a 
new bug here?


Best Regards,
Valentin Corfu
