From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: kernel alsa modprobes too early
Date: Thu, 21 Feb 2002 10:02:30 +0100
Message-ID: <E16dp7X-0000Vw-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mel-rto6.wanadoo.fr (smtp-out-6.wanadoo.fr [193.252.19.25])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA03853
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2002 10:18:34 +0100
Received: from duncan by baldrick with local (Exim 3.34 #1 (Debian))
	id 16dp7X-0000Vw-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2002 10:02:31 +0100
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

If alsa is compiled directly into the 2.5.5 kernel (rather than
as modules) then it calls modprobe before the root file system
is mounted.  The call of course fails leading to a slew of annoying
error messages.

All the best,

Duncan.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
