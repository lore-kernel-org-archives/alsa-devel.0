From: =?UTF-8?Q?Joel_Wir=C4=81mu_Pauling?= <joel@aenertia.net>
Subject: Novation - Focursrite Scarlet 6i6 Gen 2 Support request
Date: Sun, 7 May 2017 10:51:40 +1200
Message-ID: <CAKiAkGT0MPypVPR6sXwzoHx=cuoj8dBfj+r67D_q5sDtkTk_+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9911D26691A
 for <alsa-devel@alsa-project.org>; Sun,  7 May 2017 00:52:01 +0200 (CEST)
Received: by mail-lf0-f43.google.com with SMTP id j1so18453331lfh.2
 for <alsa-devel@alsa-project.org>; Sat, 06 May 2017 15:52:01 -0700 (PDT)
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

Hi all,

I have been attempting to build up as much information as possible on the
2nd gen 6i6  in the hopes someone on the mailing list will be able to find
a quick fix.

The device is usable under linux only as a 2ch output device in it's
current state using snd_usb_audio . And only if you have set Hardware mixer
routing from the Proprietary Focus-rite app in Mac OSX or Windows first.

The following link contains various USB Capture dumps doing different
things with the DAC in various sates. There appears to be something odd
with the way it enumerates sub devices on the USB port so attempts to
pass-through to a Win10 VM via KVM fail. I think I can probably get this
working if I pass the underlying PCI root device controlling the USB hub in
it's entirety but haven't been able to do this yet.

It also looks like there is a firmware load event happening somewhere.

I am hoping the lsusb and the wireshark USB pcap dumps at the link might be
of use to someone more familiar with alsa.

Any help or requests for more information gladly accepted.

I am away for the next week - but will try and get a successful init dump
out of a windows laptop and add to the repository of dumps.

https://drive.google.com/drive/folders/0Bw2fu74VAaO5bksyUEhMZDBtUE0?usp=sharing


Kind regards

-Joel
New Zealand
http://linkedin.com/in/aenertia
