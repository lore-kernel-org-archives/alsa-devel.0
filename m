From: Shane Volpe <shanevolpe@gmail.com>
Subject: Alsa + PXA + Kernel 2.6.33 resume issue
Date: Wed, 9 Jun 2010 10:51:54 -0400
Message-ID: <AANLkTin5v43waatvBGKzbcL-smgihRjMT2yStfWsmXYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DEF4103951
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 17:00:09 +0200 (CEST)
Received: by wyg36 with SMTP id 36so972575wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Jun 2010 08:00:06 -0700 (PDT)
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

I have upgraded an embedded system (PXA270) to the 2.6.33 kernel (from
2.6.23).  Now when I run an audio program (ogg123) and put the system
into standby then wake the system up the audio does not work (continue
playing) after resume until I terminate ogg123 and start again.  After
restarting ogg123 the audio works fine with out reseting the system or
changing anything else on the system.

The system is using the UCB1400 AC97 codec and just as added
information when the audio is locked up, after resume, the touchscreen
on the system still works which is also controlled by the UCB1400
audio codec.  I have also tried several other audio players and the
results are the same.   Has anyone else seen this bug and does anyone
have suggestions on further tests to perform to narrow down were the
bug may reside?
Regards,
Shane
