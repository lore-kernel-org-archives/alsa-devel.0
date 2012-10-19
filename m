From: Prasant J <pj0585@gmail.com>
Subject: Non-interleaved with plughw
Date: Fri, 19 Oct 2012 15:52:59 +0530
Message-ID: <CAA2DH4uZAFL32NKzirGoVXATTxBuT4xM-wVA3pw_v6HV8X=oHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BFA02625E9
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 12:23:00 +0200 (CEST)
Received: by mail-qa0-f51.google.com with SMTP id j40so28480qab.17
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 03:22:59 -0700 (PDT)
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


My hardware supports only interleaved access and I'm recording and
playing using hw:0,0. Currently I provide interleaved buffers to the
device.

What I read is that plughw device can convert non-interleaved buffers
to interleave buffers before sending to hardware. I want to reduce
complexity of my application and want to use plughw.

But I'm not able to get good documentation or examples of the same.
Can anyone point out to me?


Regards,
-Prasant
