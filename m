From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: alsa-driver annoyance
Date: Fri, 14 Apr 2006 22:04:58 +0100
Message-ID: <1145048699.9434.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 34EDA175
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 23:05:42 +0200 (MEST)
Received: from bossclass ([192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.4/Debian-3) with ESMTP id k3EL5ZKG005104
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 22:05:36 +0100
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

Is this a bug or a feature? Or have I missed something?

I am cross compiling alsa driver for use on an NFS root mounted
partition hosted on my development box for use by a box running a 2.6.15
kernel - the development box uses a 2.6.12 kernel

Alsa-driver insists on creating a 2.6.15 modules directory on the
development box hierarchy and then installing modules in that directory
and not in the NFS root partition.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
