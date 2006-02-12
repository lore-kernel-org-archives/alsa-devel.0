From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Building alsa-lib with a cross compiler (SH4)
Date: Sun, 12 Feb 2006 23:37:26 +0000
Message-ID: <1139787446.10187.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 257D91C9
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 00:37:41 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k1CNbQlV003215
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 23:37:33 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am guessing that I should be configuring the cross build with:


CC=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc ./configure --host=sh4-linux --with-debug=yes --prefix=/tftpboot/192.168.61.55/usr


Does this look right to folks? Does alsa-lib install configuration files
also? Will they go in the NFS root directory (/tftpboot/192.168.61.55)
with just that --prefix or do I need to add anything else? (I don't want
to over right my existing ALSA config on the i686 box I am building on)

Adrian



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
