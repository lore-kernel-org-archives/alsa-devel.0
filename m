From: Marco <marco@cowpride.com>
Subject: Headset jack and intel based Macmini6,2
Date: Sat, 22 Nov 2014 12:29:49 +0100
Message-ID: <CAGUiwu0Qyd2R9NdGBmACrei3BS4gAXpG4jOfBLmk+zh4-C4VLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 2329B2614CA
 for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2014 12:30:11 +0100 (CET)
Received: by mail-ig0-f170.google.com with SMTP id r2so2903772igi.3
 for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2014 03:30:10 -0800 (PST)
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
Cc: david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

/cc David Henningsson that has done something like that for some Dell HW
and might have some suggestions

Hello,
even if poorly advertised, recent mac.* have an headset jack (amplified)
along with the non amplified line jack. For example, for MacMini, from:
apple.com/mac-mini/specs/
> Support for Apple iPhone headset with microphone

Where iPhone headset means a simple headset not preamplified, really.

I own a MacMini6,2 (the october 2012 one) and with Mac OSX it works...
under linux... well... it is a simple out jack.
This jeopardize the ability to use any video conference software (who
doesn't today?) on linux if you don't own a USB audio device (or you don't
want that extra piece of relatively large hw)

The card is a HDA based Cirrus Logic CS4206/4207 and the two specific
models do not work (imac27 and mbp55) while auto works (except the headset
of course :)

I tried to change the pinconfig but on the intel HDA documentation it is
not really clear how the code for an headset jack (in/out) would look like.

I saw that for card ALC269/270/275/276/28x/29x there are models that
support the headset codes but... well.. they don't really seem "standard"
intel codes

I tried to look if it was possible to extract these codes from OSX but I
haven't found anything interesting (but I might have missed something)

Any suggestion dear esteemed Alsa developers? :)

Any help appreciated,

Thanks!

Marco
