From: Tim Goetze <tim@quitte.de>
Subject: current cvs inconsistent
Date: Sat, 12 Oct 2002 13:31:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0210121323510.694-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA30611
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 13:32:34 +0200
Received: from localhost (A4838.pppool.de [213.6.72.56])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id NAA18744
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 13:31:57 +0200 (MET DST)
Received: from localhost ([127.0.0.1] ident=tim)
	by localhost with esmtp (Exim 3.35 #1 (Debian))
	id 180KU8-00031l-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 13:31:08 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

it seems snd_pcm_hw_params_clear() is declared but never defined 
in current cvs.

oss mixer and playback pcm work fine with the latest kernel modules
however.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
