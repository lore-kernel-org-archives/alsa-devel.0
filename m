From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: kernel 2.5.6: devfs could not append to parent
Date: Fri, 8 Mar 2002 18:02:11 +0100
Message-ID: <E16jNky-0000OC-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mel-rto1.wanadoo.fr (smtp-out-1.wanadoo.fr [193.252.19.188])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA28607
	for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2002 18:03:07 +0100
Received: from duncan by baldrick with local (Exim 3.34 #1 (Debian))
	id 16jNky-0000OC-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Mar 2002 18:02:12 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

While booting kernel 2.5.6 I get the following error:

devfs_register(midi): could not append to parent, err: -17

NB:

0 [card0          ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xda800000/0xda000000, irq 5

Duncan.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
