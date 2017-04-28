From: Viktor Radnai <viktor.radnai@gmail.com>
Subject: Patch for Digidesign Mbox 2 (set sample rate)
Date: Fri, 28 Apr 2017 21:36:09 +0100
Message-ID: <CANx-tGgQ59u==FL-yAvR6QRZWZp7LNgU4Qaf6EQ45Ae8t-=VWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id B52A22674A8
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 22:36:11 +0200 (CEST)
Received: by mail-io0-f172.google.com with SMTP id p80so77121881iop.3
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 13:36:11 -0700 (PDT)
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

Hi there,

I have recently bought a Digidesign Mbox 2 Mini and found the lack of
support for 44100Hz sample rate in the driver limiting (the sample rate was
hard-set to 48000Hz by the original author even though the device supports
it, because he couldn't get the frame rate switching to work reliably).

I had a go at hacking the driver and came up with the following patch which
appears to work on the MBox 2 Mini:
https://pastebin.com/kzzTDj9T

I have built and tested this with Linux 4.8.15 without any realtime
patches. I am planning to pick up a "full size" Mbox 2 as well, in the
meantime if anyone on the list owns one I would appreciate if you could
test this and let me know the result. There is a possibility that it will
not work without the "magic" init sequence that I have removed because it
does not look like it's needed on the Mini. Although I would be a bit
surprised because the two devices are apparently identical to the point
that the Mini allows the use of it's physically nonexistent features.

Once someone could confirm that this works, I would like to get it merged.
This is my first attempt at submitting a patch for any Linux device driver
so please let me know if I need to do anything else :)

Cheers,
Vik
-- 
My other sig is hilarious
