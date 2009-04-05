From: James Gardiner <renidragsemaj@yahoo.com>
Subject: Mixer problem
Date: Sun, 5 Apr 2009 01:44:16 -0700 (PDT)
Message-ID: <277092.94798.qm@web54507.mail.re2.yahoo.com>
Reply-To: renidragsemaj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web54507.mail.re2.yahoo.com (web54507.mail.re2.yahoo.com
	[206.190.49.157]) by alsa0.perex.cz (Postfix) with SMTP id 6532F2433A
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 10:44:18 +0200 (CEST)
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


I'm currently in the process of adding support for my HP dv4-1222nr laptop to the drivers.  It has an IDT 92HD71B7 codec chip and no matter how hard I try, the mixer wants to default to the ATI SB one.  I'm checking my /proc and dmesg and it's telling me the same thing.  The weird thing is that using "model=hp-dv5" in my modprobe is fixing the 0x0d node speaker problem and my mods to get the digital microphone operative are working somewhat.  However, the mixer in the sigmatel source shows that it's capable of adding dmic boost to the mixer controls.  A printk I added in the source at the point where it would start processing the dmic is not even reaching the function. I tried adding my subsystem id to the PCI quirks and that didn't even help.  I'm lost...  Any ideas?
