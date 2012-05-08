From: Maciej Paszta <maciej.paszta@mobile.put.edu.pl>
Subject: Follow Up: "Why my linux OS has only 8 sound cards ?
 How can I modify it ?"
Date: Tue, 08 May 2012 14:52:30 +0200
Message-ID: <4FA9170E.60306@mobile.put.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from seawolf.cs.put.poznan.pl (seawolf.cs.put.poznan.pl
	[150.254.23.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 932941042CC
	for <Alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:52:30 +0200 (CEST)
Received: from [150.254.24.71] (c4isr-5.secpl [150.254.24.71])
	by seawolf.cs.put.poznan.pl (Postfix) with ESMTPSA id 6184D121920
	for <Alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:52:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

This issue has already been brought up by Chris Shen on Nov 8 2011. 
Quick reminder: I have  10 sound cards which need to have oss emulation 
enabled. However, I only see 8 devices (dsp-dsp7). Takashi suggested a 
patch to workaround this problem:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-November/045764.html
I've applied it to kernel 3.0.0 and the only result I get is message 
appearing in kernel logs: "unable to register OSS PCM device 8:0". I've 
done some debugging and the registration fails on these lines 
(sound/core/sound_oss.c):
register1 = register_sound_special_device(f_ops, minor, carddev);
if (register1 != minor)
{
     snd_printk(KERN_ERR "OSS: 4, register1: %i, minor %i\n", register1, 
minor);
     goto __end;
}
the debug lines seem to be constant about the value of "register1" == 
-2. I would really appreciate any help with this problem and I will be 
glad to test any patches, that may solve the issue.

-- 
Maciej Paszta
Mobile Systems Research Labs, Poznan University of Technology
