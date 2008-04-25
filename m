From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Lenovo 3000 N100 ALC861-VD quirk
Date: Fri, 25 Apr 2008 01:10:21 -0500
Message-ID: <481175CD.7000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id C299324712
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 08:11:08 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id w49so4039456pyg.36
	for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2008 23:11:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I'm revisiting an unresolved bug report I opened several months ago: bug 
# 0003468
The bug still exists as of ALSA v1.0.15 (Ubuntu 8.04).

A quick recap:

The following line in patch_realtek.c is my machine:

SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO),

If I edit this line as follows, I get sound:

SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo" ALC861VD_3ST),

(or I can just pass model=3stack to get sound).

Inserting headphones doesn't mute the speakers or power the headphones.  
But I can manually unmute the headphones via alsamixer (but speakers are 
still not muted).

I do see that the special keyboard keys for speaker mute, volume up and 
volume down are working correctly; but I don't know if this is something 
ALSA is responsible for, or X, or Ubuntu.  So if this is ALSA, thanks!

Anything more I can do to help resolve this?

Thanks,

Chris
