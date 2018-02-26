From: Freaky <freaky2000@gmail.com>
Subject: No sound on MacbookPro 13,3 (A1707)
Date: Mon, 26 Feb 2018 16:05:34 +0100
Message-ID: <CAEw6Zytyc2c0ajDOrAiKGTi17KCYjk0nyn7p0tPh7G07R7bxxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1BF266FC9
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 16:05:36 +0100 (CET)
Received: by mail-qk0-f182.google.com with SMTP id z197so19374339qkb.6
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 07:05:36 -0800 (PST)
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

we're trying to get sound working on a MacbookPro 13,3 (A1707).

So far I've been unable to get the sound working. Did use the HDA analyzer
and flipped the out-dir, enable and data on all 8 GPIO's, but none of them
got the sound working on either the onboard speakers nor the jack output
for headphone.

Is there anyone willing to help on this issue? Driver development is a bit
beyond my skills. I can provide hands, debug logs, etc. tho' :).

Currently trying with a default Ubuntu 17.10.1 live USB, but a 4.15.3
kernel didn't help either.

Alsa-info has been uploaded to
http://www.alsa-project.org/db/?f=33cc432d3b648d1aa6adc997630817046656a086

The system was booted with an external USB-C dock from Dell, otherwise
there's no network and no regular (USB-A) ports available (booting from
stick) as the WiFi doesn't work and the device has only USB-C ports. The
card 0 is from the dock - it's not relevant (and working).

Before alsa-info ran there was also a USB headphone plugged in, that was
card 1. Without those devices card 2 = 0 and 3 = 1 at boot. Issues are with
what's listed as card 2 currently, the HDA-Intel - HDA Intel PCH.

Any help is greatly appreciated.

Some people already have some trackers for the current state of the
devices. Not sure if they are of use, but might help:
https://github.com/Dunedan/mbp-2016-linux/
https://gist.github.com/roadrunner2/1289542a748d9a104e7baec6a92f9cd7

Kind regards,
