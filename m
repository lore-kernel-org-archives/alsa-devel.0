From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Full duplex questions.
Date: Sat, 27 Mar 2004 20:15:23 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4065E0DB.9050003@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA29845
	for <alsa-devel@alsa-project.org>; Sat, 27 Mar 2004 21:14:42 +0100
Received: from superbug.demon.co.uk ([80.176.146.252])
	by anchor-post-37.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1B7KCW-000M4y-0b
	for alsa-devel@alsa-project.org; Sat, 27 Mar 2004 20:14:40 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I want a sound card to work in full duplex.
I also want the in and out directions in sample sync.
I.E. The playback period size is 160. I have my code polling, so that it 
is executed once every 160 samples.
How do I ensure that each time my code executed, there will be at least 
160 samples ready to be captured?

Is there some way to link the starting of playback and capture so that 
they start at exactly the same time. So, each time i play 160 samples, I 
will have 160 samples ready to capture. If there are only 159 samples 
ready to be captured, my application will fail.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
