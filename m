From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP CardBus + Toshiba Satellite : found magic patch !
Date: 30 Aug 2002 13:54:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1030708500.7462.12.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mel-rto3.wanadoo.fr (smtp-out-3.wanadoo.fr [193.252.19.233])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA08190
	for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2002 13:56:38 +0200
Received: from mel-rta7.wanadoo.fr (193.252.19.61) by mel-rto3.wanadoo.fr (6.5.007)
        id 3D49FC7D00B8DEBD for alsa-devel@alsa-project.org; Fri, 30 Aug 2002 13:56:00 +0200
Received: from satellite.undata.org (193.252.186.224) by mel-rta7.wanadoo.fr (6.5.007)
        id 3D6EE7BA00037929 for alsa-devel@alsa-project.org; Fri, 30 Aug 2002 13:56:00 +0200
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

After several weeks of active struggle I finally identified my problem !
The CardBus Hdsp wasn't correctly configured by kernel/pcmcia-cs. It got
an IRQ but no I/O port. Furthermore lspci -M reported a strange
"crossing error" while enumerating the buses. The problem, as Paul had
stated, was a kernel issue : the kernel did not handle correctly certain
types of intel PCI bridges (among which the 82801xx series that can be
found on my Toshiba Satellite 3000-514 laptop).
A patch from Ivan Kokshaysky for the latest stable kernel (2.4.19) can
be found here:
http://groups.google.fr/groups?hl=fr&lr=&ie=UTF-8&selm=20020816194825.A7086%40jurassic.park.msu.ru&rnum=2

It's a great day for me, as I can now definitively trash away my windows partition...
Thanks Ivan, and of course thank you Paul !

Thomas




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
