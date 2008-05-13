From: Ben C <bchang_2@yahoo.com>
Subject: PCM plugin transfer callback size issue
Date: Mon, 12 May 2008 17:39:25 -0700 (PDT)
Message-ID: <119405.9620.qm@web36508.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web36508.mail.mud.yahoo.com (web36508.mail.mud.yahoo.com
	[209.191.85.8]) by alsa0.perex.cz (Postfix) with SMTP id D16C21037F1
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 02:39:26 +0200 (CEST)
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

I'm writing a PCM external filter type plugin. However, due to the processing I must handle fixed size each time. I can only handle 256 samples at a time. In the transfer callback, there would be no problem if the size is say 1024 each time, I just loop it. But the problem is that sometimes it comes back with other numbers.

One instance, it came back with 1114. So I change my code to ONLY process 1024, and return 1024 at the conclusion of the transfer callback, to see if ALSA is smart enough to handle the fact that I didn't process everything. Well, ALSA is smart enough, except the next transfer call, it only sent me the 90 samples that I didn't process. But since I can't process 90 samples, it doesn't help me either; I needed ALSA to combine that 90 samples with the next block of incoming PCM data.

My questions:
1) Is there some sort of configuration I can do to constraint the number of samples?

2) I could even manage the extra samples myself with an internal buffer to combine with the next block. But how do I tell ALSA to give me the next block? If I only processed 1024 samples out of 1114, I could store the 90 samples for next time, but if I lie to ALSA and say I did all 1114, wouldn't it try to process 1114 samples instead of 1024?

Thanks,
Ben



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
