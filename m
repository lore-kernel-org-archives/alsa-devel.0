From: Dennis Kadioglu <denk@post.com>
Subject: Unlikely big volume range Plantronics BT300
Date: Thu, 7 Apr 2016 08:40:39 +0200 (CEST)
Message-ID: <463653196.11639164.1460011239897.JavaMail.zimbra@dkadioglu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FBE3265158
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 08:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 20B487618FD
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 08:40:40 +0200 (CEST)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id nVTH8_zmgwEz for <alsa-devel@alsa-project.org>;
 Thu,  7 Apr 2016 08:40:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by skylla.efm.de (Postfix) with ESMTP id 032627619C0
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 08:40:40 +0200 (CEST)
Received: from skylla.efm.de ([127.0.0.1])
 by localhost (skylla.efm.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rWLCK3fJ4cSp for <alsa-devel@alsa-project.org>;
 Thu,  7 Apr 2016 08:40:39 +0200 (CEST)
Received: from skylla.efm.de (skylla.efm.de [195.190.148.248])
 by skylla.efm.de (Postfix) with ESMTP id E17047618FD
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 08:40:39 +0200 (CEST)
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

Hi,

when I connect the bluetooth BT300 of my Plantronics Headset I can see the following warning:

[172855.985539] usb 2-1.3: Warning! Unlikely big volume range (=720), cval->res is probably wrong.
[172855.985544] usb 2-1.3: [5] FU [PCM Playback Volume] ch = 1, val = -10240/1280/16

As far as I understand it, the problem may be solved by applying a quirk which is already applied for Logitech webcams. Can somebody help me in finding out the correct value for cval->res. I have no clue which calculations are necessary for that.

Thanks in advance.
Dennis Kadioglu
