From: Jaroslav Kysela <perex@suse.cz>
Subject: alsa-lib compatibility
Date: Wed, 4 Jan 2006 10:12:13 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601041006310.9321@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65606173
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 10:12:14 +0100 (MET)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 3B4D49903D
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 10:12:14 +0100 (MET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 20C5D1B006
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 10:12:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,

	it seems that it is quite required (based on current LKML 
discussion) to keep the alsa-lib compatibility with old drivers. Please, 
keep in mind that for example renaming of control names will break using 
old 2.6 kernel with new alsa-lib.
	The alsa-lib C code already checks for older drivers, but
the extended configuration (like 5.1, s/pdif devices) in most cases
changes a lot. We should add some runtime checks which driver version
is running in XXXXX.conf files and apply the old behaviour if required.

				Any comments?
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
