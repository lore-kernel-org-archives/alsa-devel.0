From: Gilles Hemberg <gilles.hemberg@gmail.com>
Subject: [bug] SPDIF (digital-out) not working on NForce4/CK804
Date: Fri, 3 Oct 2014 08:13:06 +0200
Message-ID: <CACoHcE19eoZmX1m9BROYqVTSdesZXvrgs8qza4tCQ8gjM7-Omw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id BB691260309
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 08:13:07 +0200 (CEST)
Received: by mail-lb0-f182.google.com with SMTP id z11so452945lbi.13
 for <alsa-devel@alsa-project.org>; Thu, 02 Oct 2014 23:13:07 -0700 (PDT)
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

Sorry to bump in like this, but I was advised to submit a bug-report
for the ALSA-drivers on my HTPC: no sound comes through out of my AVR
when I select the digital output through SPDIF (TOSLINK).


The relevant parts of my HTPC are as follows:
    * CPU: Athlon64 X2 3800+
    * Motherboard: ASUS A8N-SLI Deluxe motherboard (BIOS 1805) NForce4
with CK804 sound (relying on a Realtek ALC850 chip)
    * RAM: 2x 512 MB DDR-400
    * GPU: nVidia Geforce GT240 (which carries a HDMI port and uses the snd-
    * Receiver: Marantz SR7500 (supporting both Dolby Digital 5.1 and
DTS decoding), connected to motherboard's SPDIF TOSLINK port (optical)
+ JBL 5.1 speaker-set
    * OpenElec 4.2.0: Kernel 3.16.3, Alsa 1.0.28


Symptoms:
Speaker-test does not produce any sound. Command used is as follows:

    speaker-test -c2 -r 48000 -D hw:0,2

No sound either from other applications (such as XBMC 13.2).

SPDIF worked flawlessly on the exact same hardware & connections using
Win7/XBMC.
Sound does come through the SPDIF when I use hw:0,0 (= analog device).


Things tried (none working):
    * Blacklisting snd-hda-intel (= HDMI from my GPU) to make sure
CK804 is the only sound chip visible.

    * amixer set 'IEC958 Playback AC97-SPSA' Playback 100% unmute

    * Contacted XBMC developer via IRC for investigation: concluded
that problem would be with kernel driver, advised to create this
bug-report.

    * Tried another distro (Ubuntu from XBMCBuntu 13.0).


Further details which might be useful:
    * alsa-info.sh output: http://sprunge.us/fMeR

    * /proc/asound/card0/ac97#0-0: http://pastebin.com/Q5y1J0Ra

    * /proc/asound/card0/ac97#0-0+re
gs: http://pastebin.com/tBbTCxZg


Similar reports found (no working solution):
    http://mailman.alsa-project.org/pipermail/alsa-devel/2009-September/021336.html
    http://askubuntu.com/questions/264272/no-sound-output-msi-k8n-neo4-ck804-ac97
    http://askubuntu.com/questions/462605/new-install-of-ubuntu-14-04-trusty-3-audio-devices-no-sound
    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=615225
    http://ehc.ac/p/alsa/mailman/message/25973743/
    http://wiki.linuxmce.org/index.php/ASUS_A8N-SLI_Deluxe
    http://forum.xbmc.org/showthread.php?tid=156043&pid=1348176
    http://forum.xbmc.org/showthread.php?tid=168608
    http://ubuntuforums.org/showthread.php?t=2210288
    http://cholla.mmto.org/computers/linux/sound/asus_a8ne.html
    http://www.nvnews.net/vbulletin/showthread.php?t=80521
    ...


I am willing to test or provide further details where needed. I am new
to Linux, but am a developer myself (C#) so I know how to look up some
info... Hoping I haven't offended any of you with this post.

THNX,
Bye!
_____
Gilles Hemberg
gilles.hemberg@gmail.com
