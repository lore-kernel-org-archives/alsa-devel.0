From: Michael Findlater <michael.findlater@gmail.com>
Subject: Roland UA-55 (snd-usb-audio)
Date: Mon, 16 Sep 2013 06:37:11 +1200
Message-ID: <CAH8q-WO6BPMP4vdaM2sRpjUhSZACP_Nxr-dNe4UkP=Osw1yhqg@mail.gmail.com>
Reply-To: michael.findlater@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A5BB8261A25
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2013 20:37:32 +0200 (CEST)
Received: by mail-lb0-f172.google.com with SMTP id x18so3597373lbi.3
 for <alsa-devel@alsa-project.org>; Sun, 15 Sep 2013 11:37:32 -0700 (PDT)
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

Hello there!

I am attempting to use the Roland UA-55, which apparently should work
after recent changes were made for support for Roland devices by
Clemens Ladisch. I am using the 3.11 kernel upon Debian sid. The
device shows in /proc/asound/cards but does not seem to work.

The GNOME volume mixer it shows the device as a "QUAD-CAPTURE Analog
Surround 4.0", but I am not sure whether this is correct.

When I select the card as the output device and try to play to it,
nothing will play, 'aplay' does not work either (I hear nothing). If I
turn the headphone output knob on the device up I hear a very soft
static in my right ear.

'alsamixer' reports that 'This sound device does not have any controls.'

I do not know where to go from here, but have ran the "Alsa
Information Script", an output of this is available at:
http://www.alsa-project.org/db/?f=8f62ce460ecc5cac394c0b014b2e2aa4d28ae2dc

I am stuck with how to proceed to debug the issue. If at all possible,
I would be grateful if someone is able to point me in the right
direction.

Best regards,

Michael Findlater
