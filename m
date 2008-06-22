From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: asoc-v2 ac97-wm9713 suspend/resume
Date: Sun, 22 Jun 2008 18:17:01 +0100
Message-ID: <485E890D.2070307@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 79F81103811
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 19:17:03 +0200 (CEST)
Received: from i-83-67-105-182.freedom2surf.net ([83.67.105.182]
	helo=[192.168.0.10])
	by mx0.thdo.woaf.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63) (envelope-from <ipaqlinux@oliford.co.uk>)
	id 1KATBW-0006to-BP
	for alsa-devel@alsa-project.org; Sun, 22 Jun 2008 17:17:03 +0000
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

I have been porting linux to the iPAQ 214 which uses a wm9713 codec on 
the ac97 of a pxa310. It uses it for audio and touchscreen.
I'm working from the git tree of arm.linux.org.uk pxa branch and have 
merged in the asoc-v2-dev of wolfson-asoc (all last thursday).

I have the audio and touchscreen working via a platform driver I've put 
together (sound/soc/pxa/hpipaq214-audio.c) from copying 
sound/soc/pxa/zylonite.c etc a few months ago.

I'm now trying to get the audio working through suspend/resume.
To save as much power as possible in D3 suspend the wm9713 power is 
completely turned off in hpipaq214-audio.c via a gpio. This is in 
suspend_late() and resume_early() to make sure the power is back before 
the AC97/WM9713 drivers try to wake stuff up.

To make the touchscreen work after suspend I had to add a cold reset to 
sound/soc/wm9713.c : wm9713_resume().

Also I have to remove the calls to snd_soc_card_suspend_pcms() and 
snd_soc_card_resume_pcms() from my hpipaq214-audio.c's normal 
suspend/resume functions. These calls were originally in 
sound/soc/pxa/zylonite.c but I notice there is now no suspend/resume 
functions in there. Some of the other platform audio drivers call 
snd_soc_suspend_pcms() some call snd_soc_suspend() and some 
snd_soc_card_suspend_pcms().

Only snd_soc_suspend_pcms() seems to actually exists. If I do actually 
call snd_soc_card_suspend/resume_pcms() then any use of the audio or 
touchscreen later on freezes the process doing it.

Which am I actually supposed to do, and is there a more 'proper' way way 
of bringing the wm9713 back up from complete power down on resume?

Oliver Ford
