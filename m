From: root <root@iua.upf.es>
Subject: alsa rtctimer not compiled when having rtc as a module
Date: Tue, 02 Apr 2002 16:15:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16sP3w-0006Zx-00@bitone.upf.es>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA06629
	for <alsa-devel@alsa-project.org>; Tue, 2 Apr 2002 17:09:46 +0200
Received: from [193.145.55.62] (helo=bitone.upf.es)
	by iuamtg.upf.es with esmtp (Exim 3.34 #1 (Debian))
	id 16sPsp-0005Uu-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2002 17:07:39 +0200
Received: from root by bitone.upf.es with local (Exim 3.35 #1 (Debian))
	id 16sP3w-0006Zx-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2002 16:15:04 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello,

I noticed that the alsa rtctimer is not compiled when you have
the RTC in your kernel as a module. The problem is in 
alsa-kernel/core/Makefile, where CONFIG_RTC is tested for y
and not for m.

Maarten
