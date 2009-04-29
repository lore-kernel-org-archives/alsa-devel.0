From: Ryan Dunn <oryandunn.ml@gmail.com>
Subject: module snd-atiixp issue with suspend/hibernate/resume
Date: Wed, 29 Apr 2009 00:06:55 -0400
Message-ID: <bf4fda4a0904282106u7fd3ed03s8d1234423abd679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id EE3262440F
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 06:06:55 +0200 (CEST)
Received: by bwz11 with SMTP id 11so1009943bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 21:06:55 -0700 (PDT)
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

I have a Compaq V2000 laptop with the ATI IXP chipset and make use of the
snd-atiixp module.  The laptop needs to have the ac97_quirk option set to 7
to enable the mute LED.  After setting this option in the
/etc/modprobe.d/options.conf file, the mute LED works after a reboot.
However, after a resume from suspend or hibernate, the mute LED does not
work.  The alsa-info.sh script reports that the quirk is still set with 7.
At this point a reboot will NOT fix the problem.  The only way to fix it is
to remove and reinsert the module with modprobe.

This is on a fresh Ubuntu 9.04 install.  Any ideas?  I wasn't sure if this
should be reported here or on the kernel list.  I saw a similar issue with
the ac97_quirk on the kernel list and they were referred here.  I'm a
software developer, so I'd be willing to try ideas/possible solutions if you
have them.

Thanks,
Ryan
