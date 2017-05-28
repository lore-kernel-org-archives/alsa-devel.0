From: Hedde Bosman <sgorpi@gmail.com>
Subject: Steinberg MIDEX8 driver attempt
Date: Sun, 28 May 2017 18:23:47 +0200
Message-ID: <CALgXJ_Dkb8A6Xks_9q7FpmFVEm=XxK6y-oSL4VAM46mOrx+ZmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E6850266A11
 for <alsa-devel@alsa-project.org>; Sun, 28 May 2017 18:23:49 +0200 (CEST)
Received: by mail-qt0-f181.google.com with SMTP id c13so36801355qtc.1
 for <alsa-devel@alsa-project.org>; Sun, 28 May 2017 09:23:49 -0700 (PDT)
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

Dear Alsa developers,

I've owned a MIDEX8 for some years now and am now attempting a driver
for it. The current results can be found at
https://github.com/sgorpi/midex8
I've started with a libusb implementation, and when that worked moved
to a kernel driver.

it looks a bit like the standard usb midi class, but it requires some
periodic (i guess timer) messages on endpoint 0x02, and control (or
just LED) messages on EP 0x06 and responses on EP 0x86. Therefore,
I've took quite some inspiration from the sound/usb/midi.c driver.

In general, it seems to work now for simple cases, but I'm having a
few issues, that might be due to my lack of knowledge on the USB
subsystem, or something else. In the (simplified) libusb test in the
above repository, I do not seem to have these issues.

Issue 1:
Not all (interrupt) urbs that are submitted will complete (within 25
ms at least). Wireshark doesn't show the packets being sent out, and
the completeion handler never gets called for those urbs, but also no
errors are given by usb_submit_urb. This happens mainly with the timer
messages, and my current solution is to unlink the urbs that haven't
completed within 25ms.
However, I feel there is something going wrong there. If I do not send
urbs on the midi-in endpoint, I do not see any missing urbs... Do I
have to mutex anything for a shared urb queue or so?

Issue 2:
Sometimes after sending a few messages, an empty urb shows up in
wireshark. However, in code, there's an if-statement that should allow
only messages of length > 0 to be submitted (line 568, if (num_read >
0)). Might this have to do with issue 1?

Next to those are some other minor issues, but I'd like to get these
two sorted out first, before improving on the driver some more.

If you could give me any advice on the above issues that would be
highly appreciated! (And in case you have another list that focuses on
USB related questions, that is welcome too).

With kind regards,
Hedde
