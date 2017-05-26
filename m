From: Hedde Bosman <sgorpi@gmail.com>
Subject: Steinberg MIDEX8 driver attempt
Date: Fri, 26 May 2017 16:28:21 +0200
Message-ID: <CALgXJ_CWY2_TqZWhRF+_HOCZqatY=vsCKOSKgWvnWftpNPj52A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com
 [209.85.220.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D9715266838
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 16:28:23 +0200 (CEST)
Received: by mail-qk0-f169.google.com with SMTP id k74so8572963qke.1
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 07:28:23 -0700 (PDT)
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

I've owned a MIDEX8 for some years now and wanted to do something with it
in Linux , so I started some analysis and coding. The current result can be
found at https://github.com/sgorpi/midex8

it looks a bit like the standard midi class driver, but it requires some
periodic (i guess timer) messages on endpoint 0x82. Therefore, I've took
quite some inspiration from the sound/usb/midi.c driver.

In general, it seems to work now for simple cases, but I'm having a few
issues, that might be due to my lack of knowledge on the USB subsystem, or
something else. In the (simplified) libusb test in the above repository, I
do not seem to have these issues.

Issue 1:
Not all (interrupt) urbs that are submitted will complete (within 25 ms at
least). Wireshark doesn't show the packets being sent out, and the
completeion handler never gets called for those urbs, but also no errors
are given by usb_submit_urb. This happens mainly with the timer messages,
and my current solution is to unlink the urbs that haven't completed within
25ms.
However, I feel there is something going wrong there. If I do not send urbs
on the midi-in endpoint, I do not see any missing urbs... Do I have to
mutex anything for a shared urb queue or so?

Issue 2:
Sometimes after sending a few midi messages, an empty urb shows up in
wireshark. However, in code, there's an if-statement that should allow only
messages of length > 0 to be submitted (line 568, if (num_read > 0)). Might
this have to do with issue 1?

I intend to improve on the driver some more, but if you could give me any
advice on the above issues that would be highly appreciated.

With kind regards, Hedde
