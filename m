From: Travis Place <wishie@wishie.net>
Subject: Problems recording with HP DV2839TX laptop.
Date: Fri, 5 Sep 2008 02:46:50 +1000
Message-ID: <200809050246.51117.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 1046324445
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 18:46:49 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id E3479EB483
	for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2008 17:11:38 +1000 (EST)
Content-Disposition: inline
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

Hello everyone,

Im Travis (wishie) once of the many helpers who man the unofficial #alsa on 
freenode irc network.. I usually spend my time fixing other peoples sound 
issues, but now i have my own.

I have a HP DV2839TX laptop, and i get ALOT of static when recording via the 
inbuilt mic. Also, the mic controls are very strange.. I have (in the Capture 
section of alsamixer).. Digital, Docking Mic, External Mic, Internal Mic.. 
only the "Digital" control seems to effect my recording volume at all. 
Strangely, though, the '* Mic' controls in the PLAYBACK section of alsamixer 
do change the recording properties somewhat (volume being the main factor). 
In any event, i get a rather large amount of static, no matter what mixer 
settings i try. This isnt a problem in the 'other' OS.

My alsa-info.sh output for alsa-driver 1.0.16 is at : 
http://www.alsa-project.org/db/?f=0d1df6446ff1c71ad305e7b7b367f0a6b22b80c8

My alsa-info.sh output for alsa-driver 1.0.18rc1 is at : 
http://www.alsa-project.org/db/?f=9e5cd99f4822e0d671866fa630698bd1b0cd954b
