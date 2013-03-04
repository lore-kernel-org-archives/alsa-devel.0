From: John Graham <johngavingraham@googlemail.com>
Subject: ALSA SOC Driver (mxs-wm8753)
Date: Mon, 4 Mar 2013 18:25:05 +0000
Message-ID: <CAFio4Nem+9fj+=iUxN1awP=ZBzh=1Eca1kPi1ShjjjLR_9eO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f50.google.com (mail-da0-f50.google.com
 [209.85.210.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C5D26514B
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 19:25:07 +0100 (CET)
Received: by mail-da0-f50.google.com with SMTP id h15so2647439dan.23
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 10:25:06 -0800 (PST)
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

I'm completely new to both kernel/ALSA driver programming (at least at
a serious level) and was looking for some help on a project I'm
working on - I'm part way there but I've kind of hit a brick wall and
don't know where to turn.

I'm trying to get a codec working on a new platform (new for the codec
- the platform itself is not new). Here are the details:

The audio codec is the Wolfson WM8753, which already has a codec
driver in the kernel mainline tree. We also have a vendor-supplied
(but GPL) patch to make the wm8753 work on a CC9M2443 (based on the
Samsung S3C2443). This includes the glue code ("platform" code?) in
sound/soc/s3c24xx/cc9m2443js_wm8753.c. We have a product with this
combination fully working.

The platform is the Karo TX28 (based on the Freescale i.MX28), and
there are already drivers in the kernel tree to make the TX28 work
with an SGTL5000 codec in sound/soc/mxs/mxs-sgtl5000.c. We also have a
product with this combination fully working.

Now we want to move the WM8753 over from the CC9M2443 to work on the TX28.

To simplify, what I *have* is:

    CC9M2443 <----> WM8753
    TX28     <----> SGTL5000

and what I *want* is:

                /-> WM8753
    TX28     <-/

What I was hoping I could do was just "mash" the existing drivers
together - i.e. copy sound/soc/mxs/mxs-sgtl5000.c into
sound/soc/mxs/mxs-wm8753.c, change the parts in it that were specific
for the SGTL5000 to the parts that drive the wm8753 in
sound/soc/s3c24xx/cc9m2443js_wm8753.c, tell the TX28 to probe for it
and that it would "magically work" (hey, crazier things have
happened...).

Obviously, it does not work, but I've got it a little way down the
line. The WM8752 is probed for by the TX28 and recognized - the I2C
control works, and you can change the mixer settings with amixer. When
I try to record (using arecord) I can see with an oscilloscope the I2S
clock lines look correct (in that they look the same as when the
CC9M2443 talks to the WM8753 at the same audio rate).

The problem now is that the I2S data lines don't look right - the line
from codec to TX28 looks like a (more-or-less) square wave with the
same period as the I2S clock, but only going from ~3.1 - ~3.5 V, as
opposed to the 0 - ~3.3 V I expect. Furthermore, it's a pretty regular
square wave - it doesn't have all the breaks you see on a working I2S
data line.

I know I probably haven't provided the right detail to get to the
bottom of this problem, but part of my problem is that I'm so new to
this that I'm not entirely sure where the problem might lie, or what
extra detail to include to ask for more help. Is anyone able to point
me in the right direction/suggest some ideas as to what might be
wrong/anything else at all?

Any help would be much appreciated - many thanks,

John Graham
