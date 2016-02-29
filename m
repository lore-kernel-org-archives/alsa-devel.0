From: Brian Jones <g0ukb@ivarc.org.uk>
Subject: ERROR: USB Sound card with unsafe characters
Date: Mon, 29 Feb 2016 09:08:12 +0000
Message-ID: <CADKQKXYmcT8eOf9wH=Do_0RTk1RGBwMwTY0hvyNoXxVEwptWRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F882606A9
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 10:08:13 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id l68so49046903wml.1
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 01:08:13 -0800 (PST)
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

Newby alert -  but I don't know how to get this bug to the developers

I have been trying to work on a fix for Bug 1498129 -
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1498129  on
Ubuntu

My USB soundcard is an Asus Xonar U7 Echelon Edition
<https://www.asus.com/Sound-Cards/Xonar_U7_Echelon_Edition/> which
identifies itself to alsa as "Xonar U7 Echelon Ed." The card is supported
by alsa and works well in analog mode but I cannot get digital output via
alsa.

It has iec958 as device 1 rather than device 0 and I can access digital
output by referring to directly to hw:x,1 but cannot access digital output
via alsa.

Attempts to change the iec958 device in USB-Audio.conf fail because of the
period char and apparently my level of OS (Mint 17.3 based on Ubuntu 14.04,
kernel 3.19.0-32) does not have alsa supporting USB vendorid:productid
naming so I don't have a workaround.

If a patch exists, advice on applying/rebuilding alsa would be gratefully
appreciated.
