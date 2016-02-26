From: Brian Jones <g0ukb@ivarc.org.uk>
Subject: USB Sound card with unsafe characters
Date: Fri, 26 Feb 2016 08:43:17 +0000
Message-ID: <CADKQKXb4mhVOwAZx8nkXLW2Z6vCALGw2t-S89=J0cKj_ww_Zrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 918FA2610A7
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 09:43:17 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id a4so60309823wme.1
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 00:43:17 -0800 (PST)
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

I have been trying to work on a fix for Bug 1498129 -
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1498129  on
Ubuntu

My USB soundcard is an Asus Xonar U7 Echelon Edition
<https://www.asus.com/Sound-Cards/Xonar_U7_Echelon_Edition/> which
identifies itself to alsa as "Xonar U7 Echelon Ed." The card is supported
by alsa and works well in analog mode but I cannot get digital output via
alsa or pulseaudio.

It has iec958 as device 1 rather than device 0 and I can access digital
output by referring to directly to hw:x,1 but cannot access digital output
via alsa.

The fix I believe is to add "Xonar U7 Echelon Ed." 1 to the
USB-Audio.pcm.iec958_device section of USB-Audio.conf. This does not work.
As I suspected, and now have confirmed by Raymond on the bug report, this
is because the alsa name for this card contains the period character '.'

Is there a workaround for this or do I need to await an alsa code change?
