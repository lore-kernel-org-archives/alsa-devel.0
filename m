From: Mark Pustjens <pustjens@dds.nl>
Subject: ucb1400 + ac97
Date: Tue, 11 Apr 2006 20:36:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604112023390.1093@thuis.unkie.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.groni1.gr.home.nl (smtpq3.groni1.gr.home.nl [213.51.130.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F019910C
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 20:36:49 +0200 (MEST)
Received: from [213.51.130.188] (port=41075 helo=smtp3.groni1.gr.home.nl)
	by smtpq3.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1FTNjK-0007o0-6F
	for alsa-devel@alsa-project.org; Tue, 11 Apr 2006 20:36:46 +0200
Received: from cp210686-b.roemd1.lb.home.nl ([84.28.59.168]:58370 helo=thuis.unkie.org)
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1FTNjJ-0003tB-4t
	for alsa-devel@alsa-project.org; Tue, 11 Apr 2006 20:36:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to port two drivers from kernel 2.6.11 to 2.6.15.6. One is a 
driver for ucb1400 on a ac97 bus (UCB1400), the second is a driver for the 
touchscreen controller on the chip (UCB1400_TS).

The problem is that after loading UCB1400, the probing function is not 
called. This was the case in kernel 2.6.15.6.

The order of loading modules is:
1) snd-ac97-bus
2) UCB1400
3) UCB1400_TS

After reading the archives a bit, it seems that it might be the case that
snd-ac97-bus has some dependencies which are not loaded automatically. Is 
this the case?

My question is if there have been significant changes which might explain 
this behaviour. Any help would be greatly appreciated.

Also i would like any tips you can give me, like references on things to
read which help me understands the problem.


-- 
Using a metaphor in front of a man as unimaginative as Ridcully was like a
red flag to a bu-- was like putting something very annoying in front of
someone who was annoyed by it.
   (Lords and Ladies)


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
