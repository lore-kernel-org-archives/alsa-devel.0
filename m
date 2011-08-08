From: Almohanad Fayez <alfayez@aol.com>
Subject: TWL4030 Line In/Out Loopback issue
Date: Sun, 7 Aug 2011 20:27:45 -0400 (EDT)
Message-ID: <8CE237920E8878A-21B8-2B9F7@webmail-d033.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-mb01.mx.aol.com (imr-mb01.mx.aol.com [64.12.207.164])
	by alsa0.perex.cz (Postfix) with ESMTP id EBC511037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 02:27:51 +0200 (CEST)
Received: from mtaomg-mb02.r1000.mx.aol.com (mtaomg-mb02.r1000.mx.aol.com
	[172.29.41.73])
	by imr-mb01.mx.aol.com (8.14.1/8.14.1) with ESMTP id p780Rk35002971
	for <alsa-devel@alsa-project.org>; Sun, 7 Aug 2011 20:27:46 -0400
Received: from core-did002b.r1000.mail.aol.com (core-did002.r1000.mail.aol.com
	[172.29.231.5])
	by mtaomg-mb02.r1000.mx.aol.com (OMAG/Core Interface) with ESMTP id
	DCA39E000089
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2011 20:27:45 -0400 (EDT)
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


 I'verealized that there is a loopback dependency between the audioinput/output dependency with the 2.6.38 kernel running on a gumstix overo and also using the 2.6.35 kernel running on the Beaglenboard.

You can replicate this issue by plugging some music into the Line injack and then fire up alsamixer.  Then you would need to modify theDAC2 Dig level, the one on the right no the left.  As you lower thevolume you'll hear your music input decreasing and as you increase itthe music level would increase.  If you lower it enough you can captureaudio from the input jack without hearing it out of your speaker butthe bad thing is that also controls your speaker output so if you tryto play some sound out of gumstix/beagleboard you won't be able to do because youneed to increase your DAC2 Dig level in alsamixer ... it's a catch22!!  I couldn't find any solutions readily.

I am running a console-only Angstrom image on both boards.  I've used the Beagleboard's line in/out capabilities with no issues using the 2.6.29 kernel in the past so is there an update in the TWL4030 ALSA driver that I should take into account?  thanks


al fayez
 
