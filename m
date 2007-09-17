From: Ludovico Verducci <ludwigvan@alice.it>
Subject: Enabling in-kernel synch for M-Audio boards
Date: Mon, 17 Sep 2007 12:22:19 +0200
Message-ID: <46EE555B.9000700@alice.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mercurio1.dnshostplan.com (dns22.dnshostplan.com
	[151.1.210.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CB6C1037FB
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 12:23:12 +0200 (CEST)
Received: from host9-74-static.89-82-b.business.telecomitalia.it ([82.89.74.9]
	helo=[10.10.1.203])
	by mercurio1.dnshostplan.com with esmtpa (Exim 4.68)
	(envelope-from <ludwigvan@alice.it>) id 1IXDkv-0003zk-AZ
	for alsa-devel@alsa-project.org; Mon, 17 Sep 2007 12:23:05 +0200
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

Hello all! 
 
I'm developing a complex multichannel audio distribution system where 
multiple linux boxes will stream audio data over ethernet and then 
should play audio at sample level resolution synchronization. The boxes 
clocks are synchronized over ethernet using PTP. 
I need to keep in synch the audio board's clocks and I can't use an 
external wordclock nor s/pdif. 
 
At the moment I'm experimenting with m-audio delta 1010, based on envy24 
(VT1712). I know these boards can synch their clocks over PCI signalling 
(in windows drivers this feature support synching up to 4 boards), but 
ALSA drivers don't implement that feature. 
I'm trying to implement a similar feature (controlling board clock synch 
through kernel module), but it's very difficult without a good starting 
point! 
Is there anyone that could give me some help, support or infos? I would 
eventually appreciate also hardware reference designs or application 
notes about the VIA envy24 VT1712 chip. 
 
Obviously, should I ever be successful in the implementation, those 
features could be eventually added to ALSA drivers.
 
Thank you all in advance. 
 
Regards, 
 
Ludovico
