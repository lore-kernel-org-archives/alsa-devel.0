From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Anyone have Gadget Labs Wave/4? (patch)
Date: Tue, 20 Aug 2002 12:51:55 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820175155.GA18510@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlug.missouri.edu (root@mlug.missouri.edu [128.206.61.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA13388
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 19:52:03 +0200
Received: from mlug.missouri.edu (markrages@localhost [127.0.0.1])
	by mlug.missouri.edu (8.12.3/8.12.3/Debian -4) with ESMTP id g7KHptKL018863
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL)
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 12:51:55 -0500
Received: (from markrages@localhost)
	by mlug.missouri.edu (8.12.3/8.12.3/Debian -4) id g7KHpt1i018861
	for alsa-devel@alsa-project.org; Tue, 20 Aug 2002 12:51:55 -0500
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I would like someone with a Gadget Labs Wave/4 to try out my driver and
report any problems (and fixes!)

This is a VERY ROUGH version of the driver. Only playback is supported.

RECORDING is not supported... let's get playback solid first. 
MIDI is not supported... There's just a 16550 on the board. Has the code 
for this been written already?

In particular there are a couple things I've been trying to pin down:

1 - The driver only works every second time it's loaded. Some bizarre 
alignment problem? A bug in isapnp code? I don't have the knowledge to say 
for sure.

2 - It's very easy to make an xrun. Latency is hard-wired at 20 msec right 
now.  It's ok with preempt+lockbreak kernel patches. But still hiccups 
sometimes on my system. I want somemone else to try it and report. Maybe I 
have some rogue devices that keep interrupts disabled for a long time?

With those disclaimers, here's the patch (against rc2):
http://rages.net/alsa-driver-0.9.0rc2-wave4.patch.gz 

Regards,
Mark


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
