From: Lorenzo Marcantonio <lomarcan@tin.it>
Subject: Clock Rate on ICE1712
Date: Sat, 11 Jan 2003 22:20:32 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301112209120.12635-100000@eris.discordia.loc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from eris.discordia.loc (host144-147.pool80104.interbusiness.it [80.104.147.144])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA19498
	for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2003 22:20:51 +0100
Received: from eris.discordia.loc ([172.42.1.1])
	by eris.discordia.loc with esmtp (Exim 3.20 #1)
	id 18XT3Q-0003ew-00
	for alsa-devel@alsa-project.org; Sat, 11 Jan 2003 22:20:32 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I'm using alsa-0.9.0rc6 with a 2.4.18 kernel (low-latency patch applied).
Sound card is a Terratec EWX 24/96. My problem is the following:
at startup the master clock rate is at 48KHz. If I try to change it to
44.1KHz with alsamixer, amixer or envy24control it stays fixed at 48.
HOWEVER if I set to external sync THEN to 44.1 all works properly (to get
back to 48 I need to switch to ext-sync then to 48...)

IIRC my previous version (0.9.0beta9) worked differently... it's a bug or
something changed and I'm missing something?

Also what the 'rate lock' and 'rate reset' controls are used for?

Thanks in advance

				-- Lorenzo Marcantonio



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
